#!/usr/bin/perl

use strict;
use Xchat qw( :all );
my $version = "1.0.15";
my $settings = `cat ~/.asaconf`;
Xchat::register("Clarjon1 and Flare183's annoying Song Announcer",$version,"Amarok/clemntine xchat info");
IRC::print("Clarjon1 and Flare183's annoying Song Announcer ".$version." for XChat \cB\cC3loaded\cC0 :)");
my ($player) = ($settings =~ /player-dbus: (.*)/ ? $1 : "org.mpris.amarok" );
IRC::add_command_handler("curplay", "cmd_amacurplay");

sub cmd_amacurplay {
    if(!$_[0]){
announce();

    }
    elsif($_[0] eq "next"){
   playnext();

    }
	elsif($_[0] eq "prev"){
playprev();

    }
 elsif($_[0] eq "play"){
 if($player eq "org.mpris.amarok"){ playpause();}
elsif($player eq "org.mpris.clementine"){clemplay();}

    }
 elsif($_[0] eq "pause"){
   playpause();

    }
 elsif($_[0] eq "stop"){
   playstop();

    }
 elsif($_[0] eq "exit"){
   playexit();

    }
 elsif($_[0] eq "start"){
   playstart();

    }
 elsif($_[0] eq "version"){
   playversion();

    }
     elsif($_[0] eq "boring"){
   playboring();

    }
     elsif($_[0] eq "reload"){
   reload();

    }

    else{
IRC::print("usage: /curplay [boring|next|prev|play|pause|stop|exit|start|version]");
    }
return Xchat::EAT_ALL;
}
sub reload{
 $settings = `cat ~/.asaconf`;
($player) = ($settings =~ /player-dbus: (.*)/ ? $1 : "org.mpris.amarok" );
IRC::print("Settings reloaded.");

}

sub playboring{
    my $META = `qdbus $player /Player GetMetadata`;
    my $META2 = "volume: " . `qdbus $player /Player VolumeGet`;
    my $RANGE = 15;

    my ($ARTIST) = ( $META =~ /artist: (.*)/  ? $1 : "-" );
    my ($TITLE)  = ( $META =~ /title: (.*)/   ? $1 : "not playing" );
    my ($ALBUM)  = ( $META =~ /album: (.*)/   ? $1 : "-" );
    my ($VOLUME) = ( $META2 =~ /volume: (.*)/  ? $1 : "-" );
    my ($BITRATE) = ( $META =~ /audio-bitrate: (.*)/  ? $1 : "-" );
    my ($SAMPLERATE) = ( $META =~ /audio-samplerate: (.*)/  ? $1 : "-" );

	my ($time_total_secs) = ( $META =~ /mtime: (.+)/ ? $1 : "--" );
	$time_total_secs /= 1000;

	my $time_played_secs = `qdbus $player /Player PositionGet`;
	$time_played_secs /= 1000;

	my $time_remaining_secs = $time_total_secs - $time_played_secs;

    # Zeiten in richtige Minutenangabe umwandeln
    my @time_total = (0, $time_total_secs % 60);
    $time_total[0] = ($time_total_secs - $time_total[1]) / 60;
    my @time_played = (0, $time_played_secs % 60);
    $time_played[0] = ($time_played_secs - $time_played[1]) / 60;
    my @time_remaining = (0, $time_remaining_secs % 60);
    $time_remaining[0] = ($time_remaining_secs - $time_remaining[1]) / 60;

    # Text bauen und ausgeben
    # Gesamtzeit
    # my $text = 'Total time of track is '.$time_total[0].':';
    # if ($time_total[1] < 10) { $text .= '0'; }
    # $text .= $time_total[1];

    # Gespielte Zeit
    my  $text = ''.roundit($time_played[0]).':';
    if ($time_played[1] < 10) { $text .= '0'; }
    $text .= $time_played[1];

    # Verbleibende Zeit
    #$text .= ' /'.roundit($time_remaining[0]).':';
    $text .= ' /'.roundit($time_total[0]).':';
    if ($time_total[1] < 10) { $text .= '0'; }
    $text .= $time_total[1].'';

    IRC::command("/me is currently listening to [['$TITLE']] by [['$ARTIST']] from the album [['$ALBUM']] at [['$VOLUME%']] Volume, at position [['".$text."']], bitrate [['$BITRATE']], and samplerate [['$SAMPLERATE']]");


  sub roundit{
    my $number =shift;
    return int($number + .5 * ($number <=> 0));
}

}

sub announce{
    my $META = `qdbus $player /Player GetMetadata`;
    my $META2 = "volume: " . `qdbus $player /Player VolumeGet`;
    my $RANGE = 15;
    my $RAND1 = int(rand($RANGE));
    my $RAND2 = int(rand($RANGE));
    my $RAND3 = int(rand($RANGE));
    my ($ARTIST) = ( $META =~ /artist: (.*)/  ? $1 : "-" );
    my ($TITLE)  = ( $META =~ /title: (.*)/   ? $1 : "not playing" );
    my ($ALBUM)  = ( $META =~ /album: (.*)/   ? $1 : "-" );
    my ($VOLUME) = ( $META2 =~ /volume: (.*)/  ? $1 : "-" );
    my ($BITRATE) = ( $META =~ /audio-bitrate: (.*)/  ? $1 : "-" );
    my ($SAMPLERATE) = ( $META =~ /audio-samplerate: (.*)/  ? $1 : "-" );

	my ($time_total_secs) = ( $META =~ /mtime: (.+)/ ? $1 : "--" );
	$time_total_secs /= 1000;

	my $time_played_secs = `qdbus $player /Player PositionGet`;
	$time_played_secs /= 1000;

	my $time_remaining_secs = $time_total_secs - $time_played_secs;

    # Zeiten in richtige Minutenangabe umwandeln
    my @time_total = (0, $time_total_secs % 60);
    $time_total[0] = ($time_total_secs - $time_total[1]) / 60;
    my @time_played = (0, $time_played_secs % 60);
    $time_played[0] = ($time_played_secs - $time_played[1]) / 60;
    my @time_remaining = (0, $time_remaining_secs % 60);
    $time_remaining[0] = ($time_remaining_secs - $time_remaining[1]) / 60;

    # Text bauen und ausgeben
    # Gesamtzeit
    # my $text = 'Total time of track is '.$time_total[0].':';
    # if ($time_total[1] < 10) { $text .= '0'; }
    # $text .= $time_total[1];

    # Gespielte Zeit
    my  $text = ''.roundit($time_played[0]).':';
    if ($time_played[1] < 10) { $text .= '0'; }
    $text .= $time_played[1];

    # Verbleibende Zeit
    #$text .= ' /'.roundit($time_remaining[0]).':';
    $text .= ' /'.roundit($time_total[0]).':';
    if ($time_total[1] < 10) { $text .= '0'; }
    $text .= $time_total[1].'';

    IRC::command("/me \002\003".$RAND1."is currently listening to \003".$RAND2."[[\003".$RAND3."'$TITLE'\003".$RAND2."]] \003".$RAND1."by \003".$RAND2."[[\003".$RAND3."'$ARTIST'\003".$RAND2."]] \003".$RAND1."from the album \003".$RAND2."[[\003".$RAND3."'$ALBUM'\003".$RAND2."]] \003".$RAND1."at \003".$RAND2."[[\003".$RAND3."'$VOLUME%'\003".$RAND2."]]\003".$RAND1." Volume, at position \003".$RAND2."[[\003".$RAND3."'".$text."\003".$RAND2."']]\003".$RAND1.", bitrate \003".$RAND2."[[\003".$RAND3."'$BITRATE'\003".$RAND2."]] \003".$RAND1."and samplerate \003".$RAND2."[[\003".$RAND3."'$SAMPLERATE'\003".$RAND2."]]");


  sub roundit{
    my $number =shift;
    return int($number + .5 * ($number <=> 0));
}

}
  sub playnext {
    IRC::print("Playing Next Song");
    system('qdbus '.$player.' /Player Next');
}
  sub playprev {
    IRC::print("Playing Previous Song");
    system('qdbus '.$player.' /Player Prev');
}
  sub clemplay {
    IRC::print("Playing Song");
    system('qdbus '.$player.' /Player Play');
}
  sub playpause {
    IRC::print("Playing/Pausing Song");
if($player eq "org.mpris.amarok"){ system("qdbus org.mpris.amarok /Player PlayPause");}
elsif($player eq "org.mpris.clementine"){system("qdbus org.mpris.clementine /Player Pause");}

}
  sub playstop {
    IRC::print("Stopping Song");
    system('qdbus '.$player.' /Player Stop');
}
  sub playexit {
    IRC::print("Stopping Player");
   if($player eq "org.mpris.clementine"){ IRC::print("This doesn't work for clementine yet");}
    system('qdbus '.$player.' /MainApplication quit');
}
  sub playstart {
    my $RANGE = 15;
    my $RAND1 = int(rand($RANGE));
    my $RAND2 = int(rand($RANGE));
    my $RAND3 = int(rand($RANGE));
    IRC::command("/me \003".$RAND1."is now \003".$RAND2."Starting \003".$RAND3."The Music! ");
if($player eq "org.mpris.amarok"){ system("amarok &");}
elsif($player eq "org.mpris.clementine"){system("clementine &");}
}
  sub playversion {
    my $RANGE = 15;
    my $RAND1 = int(rand($RANGE));
    my $RAND2 = int(rand($RANGE));
    my $RAND3 = int(rand($RANGE));
    IRC::command("/me \003".$RAND1."is using \003".$RAND2."the homegrown \003".$RAND3."Clarjon1 and Flare183's \003".$RAND1."Annoying \003".$RAND2."Song\003".$RAND3." Announcer \003".$RAND2."VERSION\003".$RAND1." ".$version."!! Hosted on Github ( https://github.com/clarjon1/Annoying-Song-Announcer ) ");
    }
