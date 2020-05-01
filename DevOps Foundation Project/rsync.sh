# Login to Host A and make sure rsync and crontab are installed on both Hosts (A and B). If it is not installed, install it using the below command
yum install rsync cronie -y # Installs without prompting

# Create SSH Key pair
ssh-keygen

# Two files are generated in the /root/.ssh directory: id_rsa is a private key file, while id_rsa.pub is a public key file, which must to be copied to Host B
scp /root/.ssh/id_rsa.pub  root@A.com:/root/id_rsa.pub

# Login to Host B using root account, and attach the content in id_rsa.pub file to the authorized_keys file.  If /root/.ssh/authorized_keys file doesn’t exist in Host B, execute the following commands to create it first
mkdir -p /root/.ssh
chmod 700 /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# attach the public key generated in Host A to authorized_keys file
cat /root/id_rsa.pub >> /root/.ssh/authorized_keys

# a - Archive Mode (rsync's Super Power)
# v - Verbose Mode
# z - Compress during copy
# e ssh - Informs rsync to use SSH according to the destination instructions provided in the final argument

rsync -avze ssh /home/user/directory/ user@HOST.B:home/user/directory
