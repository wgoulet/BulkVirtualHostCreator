import os
import subprocess
import re
import io
import sys
import shutil

# make sure sufficient args passed
if len(sys.argv) < 3:
    print "Error; missing arguments. Invoke with ./setup_scantarget [hostname pattern] [domain]"
    sys.exit()

for sindex in range(2,20):
    # Create virtual ips
    ifaces = io.open("/etc/network/interfaces","a")
    entry = unicode(r"""
auto eth1:{0}
iface eth1:{0} inet static
	address 10.10.10.{0}
        netmask 255.255.255.0

""".format(sindex))
    ifaces.write(entry)
    ifaces.close()
    subprocess.call(["/sbin/ifup","eth1:{0}".format(sindex)])

    # Create certs in /etc/nginx/tls directory
    hostpattern = sys.argv[1]
    domainpattern = sys.argv[2]
    subject = "{0}{1}.{2}".format(hostpattern,sindex,domainpattern)
    subprocess.call(["make","clean"],cwd="/root/EasyOpenSSLCA")
    subprocess.call(["make","client","SUBJECT={0}".format(subject)],cwd="/root/EasyOpenSSLCA")
    clientcert = io.open("/root/EasyOpenSSLCA/client.pem")
    subcacert = io.open("/root/EasyOpenSSLCA/subca.pem")
    cacert = io.open("/root/EasyOpenSSLCA/ca.pem")
    
    cc = clientcert.readlines()
    clientcert.close()
    sub = subcacert.readlines()
    subcacert.close()
    ca = cacert.readlines()
    cacert.close()
    
    with open("/etc/nginx/tls/chain{0}.pem".format(sindex),"wb") as outfile:
        for l in cc:
            outfile.write(l)
        for l in sub:
            outfile.write(l)
        for l in ca:
            outfile.write(l)
    outfile.close()
    
    shutil.copyfile("/root/EasyOpenSSLCA/client.key","/etc/nginx/tls/client{0}.key".format(sindex))
    
    # create nginx config files
    shutil.copyfile("/etc/nginx/sites-available/master",
    "/etc/nginx/sites-enabled/{0}".format(sindex))
    
    with open("/etc/nginx/sites-available/master","r") as infile:
        with open("/etc/nginx/sites-enabled/{0}".format(sindex),"w") as outfile:
            for line in infile.readlines():
                if re.search(r'REPLACEIP',line):
                    outfile.write(re.sub(r'REPLACEIP',"10.10.10.{0}".format(sindex),line))
                elif re.search(r'REPLACESUBJECT',line):
                    outfile.write(re.sub(r'REPLACESUBJECT',subject,line))
                elif re.search(r'REPLACECERT',line):
                    outfile.write(re.sub(r'REPLACECERT',"/etc/nginx/tls/chain{0}.pem".format(sindex),
                    line))
                elif re.search(r'REPLACEKEY',line):
                    outfile.write(re.sub(r'REPLACEKEY',"/etc/nginx/tls/client{0}.key".format(sindex),
                    line))
                else:
                    outfile.write(line) 
