/*

==Class: postgresql::base

This class is dedicated to the common parts 
shared by the different distributions

*/
class postgresql::base {

  user { "postgres":
    ensure  => present,
    require => Package["postgresql"],
  }

  package {"postgresql":
    ensure => present,
    notify => undef,
  }

  case $operatingsystem {

    /RedHat|Centos|CentOS/: {
      case $lsbmajdistrelease {

        "4","5","6": { }

        default: {
          package {"postgresql-server":
            ensure => present,
          }
        }
      }
    }
  }

  # lens included upstream since augeas 0.7.4
  if versioncmp($augeasversion, '0.7.3') < 0 { $lens = present }
  else { $lens = absent }

  file { "pg_hba.aug":
	name => "/usr/share/augeas/lenses/contrib/pg_hba.aug",
    ensure => $lens,
    mode   => 0644,
    owner  => "root",
    source => "puppet:///postgresql/pg_hba.aug",
  }

}
