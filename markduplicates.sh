#!/bin/bash
#
# markduplicates.sh
# mark duplicates on bam files
# Usage: markduplicates.sh <reads> 

# mkdir
export HOME=$PWD
mkdir -p input output

# assign reads to $1
reads=$1

# copy $reads from staging to input directory
cp /staging/jespina/$reads input

# get basename of treatment and assign to $samplename for naming output files
samplename=`basename $reads .bam`

# print name reads file to stdout
echo "BAM file" $reads 

# mark duplicates using GATK MarkDuplicates
gatk MarkDuplicates -I input/$reads \
-O output/${samplename}_mkdup.bam \
-M output/${samplename}_mkdup_metrics.txt 

# move output mkdup files to staging
cd output
mv ${samplename}_mkdup.bam /staging/jespina
mv ${samplename}_mkdup_metrics.txt /staging/jespina
cd ~

# before script exits, remove files from working directory
rm -r input output

###END
