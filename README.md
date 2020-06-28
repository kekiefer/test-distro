test-distro
===========

Test distro for exercising the autobuilder and metdata layer changes.

# Mender Build

Building a mender supported build:

```
git checkout --track origin/master+wip-mender
git submodule update --init
source setup-env -m jetson-tx2 -d testdistro-mender build-mender
```

Note: only cboot is support at this time. Specify the following in your local.conf
if you are using a machine such at jetson-tx2 that uses u-boot by default.

```
PREFERRED_PROVIDER_virtual/bootloader = "cboot-prebuilt"
```

Then build an image:

```
bitbake core-image-base -k
```
