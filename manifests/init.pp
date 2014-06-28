include pkgng

class samba (
    $smbusr = 'smbguest',
    $smbgrp = 'smbguest',
    $smbcnfsrc = '/root/etc/samba/smb.conf'
){

    $confroot = '/usr/local/etc'

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

    file { 'smbcnf':
        path => '/usr/local/etc/smb.conf',
        ensure => file,
        owner  => 'root',
        group  => 'wheel',
        source => $smbcnfsrc,
        notify => Service['samba']
    }

    service { 'samba':
        ensure => running,
        enable => true,
    }
}
