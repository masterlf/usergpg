# Private class: see README.md.
#
class usergpg::params {
  $key             = $title
  $user            = undef
  $manage_package  = true
  $homedir         = "/home/${user}"
  $executable      = '/usr/bin/gpg'
  $ensure          = 'present'
  $manage_user     = true
  $manage_package  = true
  $key_file        = "${key}.gpg"
  $key_file_path   = $homedir
  $key_file_source = "puppet:///modules/usergpg/${user}/${key_file}" #change it if you use profile
  $secret_key      = true
  $trust_key       = true #becareful with this!

  case $::osfamily {
  'RedHat': {
    $gpg_package = 'gnupg2'
    }
  default: {
    $gpg_packge = 'gpgv2'
    }
  }

}
