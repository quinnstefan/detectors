use strict;
use warnings;

our %configuration;
our $toRad;
our $microgap;




sub make_scatt_chambers
{
	my $rohacell_thickness = 6;
	my $nplanes = 4;

	my @zpos       = ( -115.0,  340.0, 370.0, 490.0 );
	my @oradius    = (   50.0,   50.0,  30.0,  30.0 );
	my @iradius    = (    0.0,    0.0,   0.0,   0.0 );
	my @t_oradius  =  (   0.0,    0.0,   0.0,   0.0 );

	for(my $i = 0; $i <$nplanes; $i++) {
		$iradius[$i]   = $oradius[$i] - $rohacell_thickness;
		$t_oradius[$i] = $oradius[$i] + $rohacell_thickness;
	}
	
	
	my $dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $zpos[$i]*mm";}

	
   my %detector = init_det();
   $detector{"name"}        = "scattChamber";
   $detector{"mother"}      = "root";
   $detector{"description"} = "ddvcs scatt chambers";
   $detector{"color"}       = "aaaaaa";
   $detector{"type"}        = "Polycone";
   $detector{"dimensions"}  = $dimen;
   $detector{"material"}    = "rohacell";
   print_det(\%configuration, \%detector);
	
		
	my @z_plane    =  ( $zpos[0] - 1, $zpos[1], $zpos[2], $zpos[3] + 1 );
	
	
	# vacuum target container
	%detector = init_det();
	$detector{"name"}        = "target";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Target Container";
	$detector{"color"}       = "22ff22";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $t_oradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	$nplanes = 5;
	my @oradiusT  =  (   2.5,  10.3,  7.3,  5.0,  2.5);
	my @z_planeT  =  ( -24.2, -21.2, 22.5, 23.5, 24.5);
	
	# actual target
	%detector = init_det();
	$detector{"name"}        = "lh2";
	$detector{"mother"}      = "target";
	$detector{"description"} = "Target Cell";
	$detector{"color"}       = "aa0000";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradiusT[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_planeT[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_lH2";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	# 50 microns exit / entry windows
	
	my $wzpos = $zpos[3]  - 1;
	my $worad = $oradius[3] - 7;
	
	%detector = init_det();
	$detector{"name"}        = "scattChamberExitWindow";
	$detector{"mother"}      = "target";
	$detector{"description"} = "Vacuum exit window";
	$detector{"color"}       = "aaaaff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $worad*mm 0.05*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"pos"}         = "0 0 $wzpos*mm";
	print_det(\%configuration, \%detector);

	$wzpos = $wzpos + 10;
	$worad = $worad + 7;
	
	%detector = init_det();
	$detector{"name"}        = "vacuumEntryWindow";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Vacuum exit window";
	$detector{"color"}       = "aaaaff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $worad*mm 0.05*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"pos"}         = "0 0 $wzpos*mm";
	print_det(\%configuration, \%detector);

}


