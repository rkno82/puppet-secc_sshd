require 'spec_helper'

#print "os-array: "
#puts os

####
# disabled checks are only temp. disabled and have to be enabled to ensure compliance
####

# sshd config - check
describe command('sshd -T') do
	# Network
	its(:stdout) { should match /^port 22$/ }
	its(:stdout) { should match /^addressfamily inet$/ }
	its(:stdout) { should match /^usedns no/ }
	
	# Banner
	its(:stdout) { should match /^banner \/etc\/issue$/ }
	its(:stdout) { should match /^printmotd yes$/ }
	
	# Req 1
	its(:stdout) { should match /^protocol 2$/ }
	
	# Req 2
	its(:stdout) { should match /^ciphers aes256-ctr$/ }
	its(:stdout) { should match /^macs hmac-sha2-512,hmac-sha2-256$/ }
	its(:stdout) { should match /^kexalgorithms diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1$/ }
	
	# Req 3
	its(:stdout) { should match /^listenaddress 1/ }
	
	# Req 6
	its(:stdout) { should match /^allowtcpforwarding no$/ }
	
	# Req 7
	its(:stdout) { should match /^gatewayports no$/ }
	
	# Req 8
	its(:stdout) { should match /^x11forwarding no$/ }
	its(:stdout) { should match /^x11uselocalhost yes$/ }
	its(:stdout) { should match /^gatewayports no$/ }
	its(:stdout) { should match /^gatewayports no$/ }
	
	# Req 9 and Req 21
	its(:stdout) { should match /^allowagentforwarding no$/ }
	
	# Req 10
	its(:stdout) { should match /^permittunnel no$/ }

	# Req 11
	its(:stdout) { should match /^allowusers root/ }		

	# Req 12
	its(:stdout) { should match /^syslogfacility AUTHPRIV$/ }	
	its(:stdout) { should match /^loglevel VERBOSE$/ }
	
	# Req 13,14,15,17,18
	its(:stdout) { should match /^pubkeyauthentication yes$/ }	
	its(:stdout) { should match /^passwordauthentication no$/ }
	its(:stdout) { should match /^rsaauthentication yes$/ }	
	its(:stdout) { should match /^challengeresponseauthentication no$/ }
	its(:stdout) { should match /^permitemptypasswords no$/ }	
	its(:stdout) { should match /^permitrootlogin without-password$/ }
	its(:stdout) { should match /^authorizedkeysfile .ssh\/authorized_keys$/ }	
	its(:stdout) { should match /^rhostsrsaauthentication no$/ }
	its(:stdout) { should match /^hostbasedauthentication no$/ }	
	its(:stdout) { should match /^ignorerhosts yes$/ }
	
	# Req 21
	its(:stdout) { should match /^allowagentforwarding no$/ }
	
	# additions for user feedback
	its(:stdout) { should match /^strictmodes yes$/ }
	its(:stdout) { should match /^useprivilegeseparation yes$/ }
	
end

# sshd config - check
describe file('/etc/ssh/ssh_config') do
  # Req 19
  its(:content) { should match /^StrictHostKeyChecking ask$/ }
  its(:content) { should_not match /^StrictHostKeyChecking no/ }

  # Req 20
  its(:content) { should match /^ForwardAgent no$/ }
  its(:content) { should_not match /^ForwardAgent yes/ }
  its(:content) { should match /^ForwardX11 no$/ }
  its(:content) { should_not match /^ForwardX11 yes/ }
  its(:content) { should match /^ForwardX11Trusted no$/ }
  its(:content) { should_not match /^ForwardX11Trusted yes/ }
end
