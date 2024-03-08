#!/usr/bin/perl

use strict;
use warnings;

my $inputFile = $ARGV[0];
my @dataArray = @_;
my @avgArray = @_;
my @stdevArray = @_;
my $counter = 0;

open (DATAFILE, "<$inputFile");
while(my $finput = <DATAFILE>)
{
    chomp $finput;
    my @inputArray = split(/\t/, $finput);

    for(my $i=0; $i<scalar(@inputArray); $i++)
    {
        $dataArray[$counter][$i] = $inputArray[$i];
    }

    $counter++;
}
close DATAFILE;

for(my $i=0; $i<scalar(@{$dataArray[0]}); $i++)
{
    my $total = 0;
    my $number = 0;
    my $stdevTotal = 0;

    for(my $j=0; $j<$counter; $j++)
    {
        $total += $dataArray[$j][$i];
        $number++;
    }

    my $average = $total/$number;

    for(my $j=0; $j<$counter; $j++)
    {
        $stdevTotal += ($dataArray[$j][$i] - $average)*($dataArray[$j][$i] - $average);
    }

    my $stdev = sqrt($stdevTotal/($number-1));

    $avgArray[$i] = $average;
    $stdevArray[$i] = $stdev;
}

my $avgOutput = "";
my $stdevOutput = "";

for(my $i=0; $i<scalar(@avgArray); $i++)
{
     if($i == 0)
     {
         $avgOutput = $avgArray[$i];
         $stdevOutput = $stdevArray[$i];
     }
     else
     {
         $avgOutput .= "\t".$avgArray[$i];
         $stdevOutput .= "\t".$stdevArray[$i];
     }
}

print $avgOutput."\n";
print $stdevOutput."\n";