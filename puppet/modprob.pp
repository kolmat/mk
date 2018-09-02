class modprob (

	$partition = $::partitions,
	$efi       = false,
	

){

    include kmod
		include stdlib
		$defaults={
			command => '/bin/false'
		}

		$defaults2={
			ensure => absent,
		}

		$blacklist={
			'cramfs'    => {},
			'freevxfs'  => {},
			'vfat'      => {},
		}
		#$modprob::partition.each |String $key, Hash $value| { notice("${key} = ${value}") }
		#/dev/sda2 = {filesystem => LVM2_member, size => 118.75 GiB, size_bytes => 127509987328, uuid => 1I9Dhr-XKGs-sZOd-5f8c-dMnV-pdKn-HRUywD}

			
		#$filtered_data = $data.filter |$items| { $items[0] =~ /berry$/ }
	  #notify {$partition: }
    $root_partition = $facts['partitions'].filter |$device, $partition| { $partition['mount'] == '/kot'}
		#$transformed_data = $facts['partitions'].map |$key,$value| { $value['mount'] }
			
		
		#$::partitions.each |String $key,Hash $value| {
		#	if has_key($value,'mount'){
				#notice($value['mount'])
		#		$_mount=$value['mount']
		#		}	
		#	}
		#notice($transformed_data)	
		notice($root_partition)
		case ! empty($root_partition) {
			true             :  {$_blacklist = delete($blacklist,'vfat') }
			default          :  {$_blacklist = $blacklist }
		}	
    
		
		#case $efi  {
		#	true: { $_blacklist = delete($blacklist,'vfat') } 
		#	default: {$_blacklist = $blacklist }
		#}
		create_resources(kmod::load, $_blacklist, $defaults2)
		create_resources(kmod::install, $_blacklist, $defaults)
}
include modprob
		



#kmod::install { 'pcspkr': }
