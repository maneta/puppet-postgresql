import "classes/*.pp"
import "definitions/*.pp"
  
class postgresql {
  case $operatingsystem {
    Debian: { 
      case $lsbdistcodename {
        lenny :  { include postgresql::debian::v8-3 }
        squeeze: { include postgresql::debian::v8-4 }
        default: { fail "postgresql not available for ${operatingsystem}/${lsbdistcodename}"}
      }
    } 
    Ubuntu: {
      case $lsbdistcodename {
        lucid :  { include postgresql::debian::v8-4 }
        default: { fail "postgresql not available for ${operatingsystem}/${lsbdistcodename}"}
      }
    }
    /Centos|CentOS/: {
      case $lsbmajdistrelease {
        '5': { include postgresql::centos::v8-4 }
		'6': { include postgresql::centos::v8-4 }
        default: { fail "postgresql module not implemented for ${operatingsystem}-$lsbmajdistrelease"}
      }
	}
    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}

class postgresql::v8-3 {
  case $operatingsystem {
    Debian: {
      case $lsbdistcodename {
        lenny :  { include postgresql::debian::v8-3 }
        default: { fail "postgresql 8.3 not available for ${operatingsystem}/${lsbdistcodename}"}
      }
    }
    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}

class postgresql::v8-4 {
  case $operatingsystem {
    Debian: {
      case $lsbdistcodename {
        lenny,squeeze : { include postgresql::debian::v8-4 }
        default:        { fail "postgresql 8.4 not available for ${operatingsystem}/${lsbdistcodename}"}
      }
    }
    Ubuntu: {
      case $lsbdistcodename {
        lucid :  { include postgresql::debian::v8-4 }
        default: { fail "postgresql 8.4 not available for ${operatingsystem}/${lsbdistcodename}"}
      }
    }
	/Centos|CentOS/: {
      case $lsbmajdistrelease {
        '5': { include postgresql::centos::v8-4 }
        default: { fail "postgresql module not implemented for ${operatingsystem}-$lsbmajdistrelease"}
      }
    }
    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}

class postgresql::v9-0 {
  case $operatingsystem {
    Debian: {
      case $lsbdistcodename {
        squeeze : { include postgresql::debian::v9-0 }
        default:  { fail "postgresql 9.0 not available for ${operatingsystem}/${lsbdistcodename}"}
      }
    }
    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
