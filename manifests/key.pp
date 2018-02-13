# == Define: usergpg::key
#
# Install gpg key for specified usergpg
define usergpg::key (
  $key             = $title,
  $user            = undef,
  $uid             = undef,
  $manage_package  = true,
  $manage_homedir  = false,
  $homedir         = "/home/${user}",
  $executable      = '/usr/bin/gpg',
  $ensure          = 'present',
  $manage_user     = false,
  $key_file        = "${key}.gpg",
  $key_file_path   = $homedir,
  $key_file_source = "puppet:///modules/usergpg/${user}/${key_file}", #change it if you use profile
  $secret_key      = true,    # Allow import of private key
  $trust_key       = false,   # Becareful with this, if not sure set to false
  $trust_model     = 'always' # pgp|classic|direct|always|auto
) {
  case $::osfamily {
  'RedHat': {
    $gpg_package = 'gnupg2'
    }
  default: {
    $gpg_package = 'gpgv2'
    }
  }
  if $user == 'root' { $homedir ='/root'}

  if $manage_user {
    @user {$user:
      ensure         => 'present',
      uid            => $uid,
      home           => $homedir,
      manage_homedir => $manage_homedir,
    }
    realize(User[$user])
  } else {
      if $manage_homedir {
        file {$homedir:
          ensure => 'present',
          owner  => $user,
        }
      }
    }

  if $manage_package {
    @package {$gpg_package:
      ensure => 'present',
    }
    realize(Package[$gpg_package])
  }

  file {"${key_file_path}/.${key_file}":
    ensure => 'present',
    owner  => $user,
    mode   => '0640',
    source => $key_file_source,
  }

  if $secret_key { $secret_key_opt = '--allow-secret-key-import' }
  if $trust_key  {
    case $trust_model {
      /^(pgp|classic|direct|always|auto)/: {$trust_key_opt  = "--trust-model ${trust_model}" }
      default: {
        notify { 'PGP trust model available: pgp|classic|direct|always|auto': }
        $trust_key_opt = ''
      }
    }
  }

  $command = "${executable} ${secret_key_opt} ${trust_key_opt} --import ${key_file_path}/.${key_file}"
  exec { "su - ${user} -c '${command}'":
    path      => 'usr/bin:/usr/sbin:/bin',
    creates   => "${key_file_path}/.${keyfile}.puppet",
    timeout   => 100,
    require   => File["${key_file_path}/.${key_file}"],
    logoutput => true,
    returns   => [0, 2], # return 0 when all ok, 2 if key is already in, that is fine.
  }
}
