include pkgng

class samba {

    $smbusr = 'smbguest'
    $smbgrp = 'smbguest'

    package { 'samba36':
        name     => 'samba36',
        provider => pkgng
    }

    group { 'smbgrp':
        name   => $smbgrp,
        ensure => present,
        system => true
    }

    user { 'smbusr':
        name       => $smbusr,
        ensure     => present,
        gid        => $smbgrp,
        managehome => false,
        shell      => '/sbin/nologin',
        system     => true,
        require    => Group['smbgrp']
    }
}
