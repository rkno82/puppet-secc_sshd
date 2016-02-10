# SecC Linux SSH Hardening
class secc_sshd (
  $ext_admininterface_nr = '0',
  $ext_admininterface_xen0 = 'xenbr0',
  $ext_sshd_AllowUsers = 'root rootuser',
  $ext_sshd_AllowGroups = '',
  $ext_sshd_DenyUsers = '',
  $ext_sshd_DenyGroups = '',
  $ext_sshd_KexAlgorithms = 'diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1',
  $ext_sshd_Ciphers = 'aes256-ctr',
  $ext_sshd_MACs = 'hmac-sha2-512,hmac-sha2-256',
  $ext_servicename = 'Servicename'
) {

  $admininterface_nr   = hiera(admininterface_nr, $ext_admininterface_nr)
  $admininterface_xen0 = hiera(admininterface_xen0, $ext_admininterface_xen0)
  $sshd_AllowUsers     = hiera(sshd_AllowUsers, $ext_sshd_AllowUsers)
  $sshd_AllowGroups    = hiera(sshd_AllowGroups, $ext_sshd_AllowGroups)
  $sshd_DenyUsers      = hiera(sshd_DenyUsers, $ext_sshd_DenyUsers)
  $sshd_DenyGroups     = hiera(sshd_DenyGroups, $ext_sshd_DenyGroups)
  $sshd_KexAlgorithms  = hiera(sshd_KexAlgorithm, $ext_sshd_KexAlgorithms)
  $sshd_Ciphers        = hiera(sshd_Ciphers, $ext_sshd_Ciphers)
  $sshd_MACs           = hiera(sshd_MACs, $ext_sshd_MACs)
  $servicename         = hiera(servicename, $ext_servicename)

  include secc_sshd::install

  class { 'secc_sshd::config':
    admininterface_nr   => $admininterface_nr,
    admininterface_xen0 => $admininterface_xen0,
    sshd_AllowUsers     => $sshd_AllowUsers,
    sshd_AllowGroups    => $sshd_AllowGroups,
    sshd_DenyUsers      => $sshd_DenyUsers,
    sshd_DenyGroups     => $sshd_DenyGroups,
    sshd_KexAlgorithms  => $sshd_KexAlgorithms,
    sshd_Ciphers        => $sshd_Ciphers,
    sshd_MACs           => $sshd_MACs,
    servicename         => $servicename,
    require             => Class['secc_sshd::install'],
    notify              => Class['secc_sshd::service'],
  }

  include secc_sshd::service

  include secc_sshd::ssh_config

}