package { ['usbutils', 'git', 'vim-nox', 'libpq-dev']:
  ensure => 'installed'
}

class { 'nodejs':
  version => "v0.10.35"
}

package { 'cordova':
  provider => 'npm',
  require  => Class['nodejs']
}

package { 'ionic':
  provider => 'npm',
  require  => Class['nodejs']
}

package { 'bower':
  provider => 'npm',
  require  => Class['nodejs']
}

class { 'java':
  distribution => 'jdk',
  version      => 'latest',
} ->
class { 'android': }
android::platform { 'android-10': }
android::platform { 'android-16': }
android::platform { 'android-18': }

file { '/bin/adb':
   ensure => 'link',
   target => '/home/vagrant/android/android-sdk-linux/platform-tools/adb',
   require => [Class['android']]
}

file { '/bin/android':
   ensure => 'link',
   target => '/home/vagrant/android/android-sdk-linux/tools/android',
   require => [Class['android']]
}

file { "/home/vagrant/android/android-sdk-linux/platform-tools/adb":
  owner => root,
  group => vagrant,
  mode => 4550,
  require => [Class['android']]
}


class { 'postgresql::server': }

postgresql::server::db { 'project':
  user     => 'project',
  password => postgresql_password('project', 'project'),
}

class { 'rvm': version => '1.26.6' }

rvm_system_ruby {
  'ruby-2.1':
    ensure      => 'present',
    default_use => true
}

rvm_gem {
  'rails-api':
    name         => 'rails-api',
    ruby_version => 'ruby-2.1',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.1'];
  'rails':
    name         => 'rails',
    ruby_version => 'ruby-2.1',
    ensure       => "4.2.0",
    require      => Rvm_system_ruby['ruby-2.1'];
  'puppet':
    name         => 'puppet',
    ruby_version => 'ruby-2.1',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.1'];
  'pgsql':
    name         => 'pgsql',
    ruby_version => 'ruby-2.1',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.1'];
}
