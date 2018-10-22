#! /bin/bash

if [ "$1" = "sync" ];
then
  #repo forall -c 'git reset --hard ; git clean -fdx' 
  repo sync --force-sync
fi

. build/envsetup.sh
# bionic
repopick 75308

repopick 224745 -g https://review.lineageos.org -P hardware/qcom/display-caf/msm8994 -f #-> (revert this)
repopick 226488 -g https://review.lineageos.org -P hardware/qcom/display-caf/msm8994 -f
repopick 194969 -g https://review.lineageos.org -P hardware/qcom/audio-caf/msm8994 -f # -> (dirty,dirty workarround)

repopick 230151 -g https://review.lineageos.org -P system/sepolicy
repopick 225115 -g https://review.lineageos.org -P device/gzosp/sepolicy

repopick -t pie-qcom-legacy-sepolicy
repopick -t hima-pie
repopick -t per-process-sdk-override
repopick -t pie-custom-cameraparameters

repopick 67793 -P hardware/qcom/audio-caf/msm8994

repopick 75818 -P AICP/kernel_htc_msm8994 -f

brunch himaul
