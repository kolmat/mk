include kmod
$defaults={
	command => '/bin/false'
}

$defaults2={
	ensure => absent,
}


$blacklist={
	'cramfs'    => {},
	'freevxfs'  => {},
}
create_resources(kmod::load, $blacklist, $defaults2)
create_resources(kmod::install, $blacklist, $defaults)






#kmod::install { 'pcspkr': }
