Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class core {
  
    exec { "apt-update":
      command => "/usr/bin/sudo apt-get -y update"
    }
  
    package { 
      [ "wget", "curl", "vim", "git-core", "build-essential" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
	
	exec {
        "heroku-toolbelt":
        command => "wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh",
        creates => "/usr/local/heroku",
        require =>Package["wget"],  
    }
}

class python {

    package { 
      [ "python", "python-setuptools", "python-dev", "python-pip", ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
}

class mysql {
  package {
    ["mysql-client-core-5.5","mysql-client", "mysql-server", "libmysqlclient-dev"]: 
      ensure => installed, 
      require => Exec['apt-update']
  }
  
  service { "mysql":
    ensure    => running,
    enable    => true,
    require => Package["mysql-server"],  
  }
}

class application {
	exec {
		"create-database":
		command => 'echo "create database gitstats" | mysql -uroot',
		require => Service["mysql"],
		unless => 'echo "show databases" | mysql -uroot | grep -c gitstats',
	  }
	
	exec {
		"makemigrations":
		command => 'python /app/manage.py makemigrations',
		require => Exec['create-database'],
		creates => '/app/migrations',
	}
	
	exec {
		"migrate":
		command => 'python /app/manage.py migrate',
		subscribe => Exec['makemigrations'],
		refreshonly => true,
	}
}

include core
include python
include mysql
include application