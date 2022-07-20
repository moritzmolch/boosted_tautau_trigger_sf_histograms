#!/bin/bash

### Setup of CMSSW release
CMSSW=CMSSW_10_2_16_UL

export SCRAM_ARCH=slc7_amd64_gcc700
export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh

scramv1 project $CMSSW; pushd $CMSSW/src
eval `scramv1 runtime -sh`

# combine on 102X slc7
git clone git@github.com:cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit
cd HiggsAnalysis/CombinedLimit
git fetch origin
git checkout v8.0.1
cd -

# CombineHarvester (current master for 102X)
git clone git@github.com:cms-analysis/CombineHarvester.git CombineHarvester

# SM analysis specific code
git clone git@github.com:KIT-CMS/SMRun2Legacy.git CombineHarvester/SMRun2Legacy

# TauID analysis specific code
git clone git@github.com:KIT-CMS/TauIDSFMeasurement.git CombineHarvester/TauIDSFMeasurement

# compile everything
# Build
scram b clean
scram b -j 10
