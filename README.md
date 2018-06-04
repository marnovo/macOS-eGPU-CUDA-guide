# Guide on running NVIDIA eGPUs (with CUDA) on macOS

Sample set up for [CUDA](https://developer.nvidia.com/about-cuda) programming for machine learning and gaming on [macOS](https://www.wikiwand.com/en/MacOS) using a NVIDIA eGPU, 
plus references, tutorials and generalizations that will apply to most hardware.

## Table of Contents

- [Requirements](#requirements)
  - [Hardware](#hardware)
    - [Caveat Emptor](#caveat-emptor)
    - [About Thunderbolt](#about-thunderbolt)
    - [Main components](#main-components)
    - [Cables and adapters](#cables-and-adapters)
  - [Software](#software)
    - [General](#general)
    - [CUDA Programming and Machine Learning](#cuda-programming-and-machine-learning)
    - [Gaming](#gaming)
- [Step-by-step Tutorials](#step-by-step-tutorials)
  - [eGPU on macOS High Sierra](#egpu-on-macos-high-sierra)
  - [eGPU on macOS Sierra and earlier](#egpu-on-macos-sierra-and-earlier)
  - [CUDA on macOS](#cuda-on-macos)
    - [Known CUDA bugs and quirks](#known-cuda-bugs-and-quirks)
- [License](#license)

## Requirements

### Hardware

#### Caveat Emptor

The ports/cables/adapters listed are simply the ones from the reference rig. 
You can probably mix and match hardware in `n→∞` different ways using the very same (or similar) software steps.
Just make sure to have a reasonable idea about your likelihood of success *before* you go on a buying spree.

**Tip:** check [eGPU.io's](https://egpu.io/external-gpu-implementations-table/) for other reference implementations, 
Linux, macOS, Windows (pure or bootcamped) all included. Wealthy source of information, very helpful folks.

#### About Thunderbolt

[Thunderbolt](https://www.wikiwand.com/en/Thunderbolt_(interface)) is a multi-purpose interface designed by Apple and Intel. 
It can transfer a data at high speed, thus is adequate for transferring data between your computer and (e)GPU.

Long story short about Thunderbolt versions:
- **Thunderbolt 3** looks like a [USB-C](https://www.wikiwand.com/en/USB-C) port and provides 40Gbit/s bandwidth and is what you have in the latest computers, as the MacBook Pro from 2016-2017—or the Dell XPS, Razer Blade Stealth, etc.
- **Thunderbolt 2** looks like a [Mini DisplayPort](https://www.wikiwand.com/en/Mini_DisplayPort) port and provides 20Gbit/s bandwidth and is what you have in the previous generation computers, as the MacBook Pro from 2015 and earlier.
- Thunderbolt 1 is very outdated (and slow) and not worth taking into consideration anymore for these purposes.

The sample setup depicted in this guide is not optimal, given its need of Thunderbolt 3 -> Thunderbolt 2 conversion. 
This conversion is necessary in this case since the laptop has a TB2 port and the eGPU enclosure has a TB3 port. 
For this reason you end up requiring additional cabling and *possibly* limiting throughput to TB2 bandwidth.

If you are curious about the performance drops for GPUs connected via Thunderbolt (versions) versus PCIexpress, 
see a [sample comparison](https://egpu.io/forums/mac-setup/pcie-slot-dgpu-vs-thunderbolt-3-egpu-internal-display-test/). 
As usual, your mileage may vary and take things with a grain of salt.

**TL;DR on Thunderbolt:**
- If you are not restricted to TB2 because of an older laptop, go for a TB3->TB3 solution.
- If you are restricted to TB2, you can choose to go TB2->TB2 (cheaper) or TB3->TB2 (upgradable in the long term).

#### Main components

- Apple notebook as [Apple MacBook Pro 13 inch 2015](http://www.trustedreviews.com/2015-13-inch-macbook-pro-review) (2x Thunderbolt 2)
- eGPU as [Akitio Node](https://www.akitio.com/expansion/node) (1x Thunderbolt 3, 1x PCIe), 
other options can be checked at [eGPU.io buyer's guide](https://egpu.io/external-gpu-buyers-guide).
- NVIDIA Pascal GPUs as [GTX 1080 Ti](https://www.nvidia.com/en-us/geforce/products/10series/geforce-gtx-1080-ti/) (1x Displayport, 1x PCIe + others), Maxwell work as well.
- External display as [Dell UP3216Q](http://www.dell.com/ed/business/p/dell-up3216q-monitor/pd) (1x Displayport + others)

#### Cables and adapters

- Displayport cable (2x Displayport, comes with display)
- Thunderbolt 3 cable (2x Thunderbolt 3, comes with Node)
- [Apple Thunderbolt 2 cable](https://www.apple.com/shop/product/MD861LL/A/apple-thunderbolt-cable-20-m) (2x Thunderbolt 2)
- [Apple Thunderbolt 2<->3 adapter](https://www.apple.com/shop/product/MMEL2AM/A/thunderbolt-3-usb-c-to-thunderbolt-2-adapter) (1x Thunderbolt 2 + 1x Thunderbolt 3)

### Software

#### General

- [macOS High Sierra](https://www.apple.com/lae/macos/high-sierra/) or [macOS Sierra](https://www.apple.com/lae/macos/sierra/) or earlier.
- [macOS SIP disabling](https://www.igeeksblog.com/how-to-disable-system-integrity-protection-on-mac/)
- eGPU enabling & automation:
  - If on macOS 13.1 (High Sierra or maybe later): [NVIDIA eGPU v2](https://egpu.io/forums/mac-setup/wip-nvidia-egpu-support-for-high-sierra/paged/12/#post-23263) 
  - If on macOS 12.6 (Sierra) or earlier: [Automate eGPU script](https://github.com/goalque/automate-eGPU)
- [NVIDIA Web drivers](https://www.tonymacx86.com/nvidia-drivers/), just match your OS version with driver version.

#### CUDA Programming and Machine Learning

- [NVIDIA CUDA drivers](http://docs.nvidia.com/cuda/cuda-installation-guide-mac-os-x/)
- [Tensorflow](https://www.tensorflow.org)
- [cuDNN](https://developer.nvidia.com/cudnn)
- [CUDA-z](http://cuda-z.sourceforge.net/) 

#### Gaming

- [WINE](https://www.winehq.org): for running Windows games on macOS (or Linux).
- [Wineskin Winery](http://wineskin.urgesoftware.com/tiki-index.php), or [WineBottler](http://winebottler.kronenberg.org/) or even possibly [CrossOver](https://www.codeweavers.com/products/crossover-mac/features): related to WINE above, to make things easier.

## Step-by-step Tutorials

These tutorials are meant to be *very* (one could say overly) descriptive. 
Nonetheless, for reasons unknown, you may eventually find some slight variations. 
I will do my best to keep this updated with the intrincacies of the process as people report it.

### eGPU on macOS High Sierra

1. Install macOS High Sierra (works with v13.1–v13.3). Please note [v13.4–v13.5+ support is still experimental](https://github.com/marnovo/macOS-eGPU-CUDA-guide/issues/6).
2. Check if [macOS System Integrity Protection](https://support.apple.com/en-us/HT204899) (SIP) is enabled and/or enable it:
    1. Boot the computer in recovery mode: press and hold `Command⌘ + R` when hearing the chime sound.
    2. Open the `Terminal` application from the top menu.
    3. Type `csrutil status` and press `Enter↩︎` to see if SIP is enabled.
    4. If SIP *is not enabled*, type `csrutil enable`, press `Enter↩︎` and reboot.
    5. Reboot.
3. Apply the High Sierra supplemental update (if necessary).
4. Install the corresponding [NVIDIA Web Driver]([NVIDIA Web drivers](https://www.tonymacx86.com/nvidia-drivers/) to your OS version  (remember, SIP *must* be enabled here).
5. Reboot and log in normally.
6. Disable [macOS System Integrity Protection](https://support.apple.com/en-us/HT204899) (SIP):
    1. Boot the computer in recovery mode: press and hold `Command⌘ + R` when hearing the chime sound.
    2. Open the `Terminal` application from the top menu.
    3. Type `csrutil status` and press `Enter↩︎` to see if SIP is enabled.
    4. If SIP *is enabled*, type `csrutil disable`, press `Enter↩︎`
    5. Reboot.
8. Download and install the [NVIDIA eGPU v2 package](https://egpu.io/forums/mac-setup/wip-nvidia-egpu-support-for-high-sierra/paged/12/#post-23263) (if for whatever reason v2 does not work for you even after these exact steps, try v1).
9. Shut down your computer.
10. Now boot *without the eGPU connected*, log in normally, and again shut down your computer.
11. Connect your eGPU enclosure and boot your computer:
    1. In most cases it should work with the eGPU connected before turning the computer on.
    2. In case you see an indefinite black screen, only plug the eGPU after the chime sound, just when the Apple logo shows up.
12. Voilà!

### eGPU on macOS Sierra and earlier

1. Install macOS Sierra or slightly earlier (at this point v12.6).
2. Check if [macOS System Integrity Protection](https://support.apple.com/en-us/HT204899) (SIP) is enabled and/or enable it:
    1. Boot the computer in recovery mode: press and hold `Command⌘ + R` when hearing the chime sound.
    2. Open the `Terminal` application from the top menu.
    3. Type `csrutil status` and press `Enter↩︎` to see if SIP is enabled.
    4. If SIP *is not enabled*, type `csrutil enable`, press `Enter↩︎` and reboot.
    5. Reboot.
3. Apply any supplemental updates (if necessary).
4. Install the corresponding [NVIDIA Web Driver]([NVIDIA Web drivers](https://www.tonymacx86.com/nvidia-drivers/) to your OS version  (remember, SIP *must* be enabled here).
5. Reboot and log in normally.
6. Disable [macOS System Integrity Protection](https://support.apple.com/en-us/HT204899) (SIP):
    1. Boot the computer in recovery mode: press and hold `Command⌘ + R` when hearing the chime sound.
    2. Open the `Terminal` application from the top menu.
    3. Type `csrutil status` and press `Enter↩︎` to see if SIP is enabled.
    4. If SIP *is enabled*, type `csrutil disable`, press `Enter↩︎`
    5. Reboot.
8. Download the [automate-eGPU script](https://github.com/goalque/automate-eGPU)
9. Decompress it your computer if downloaded as a zip file.
10. Run the script with administrator privileges:
    1. Open your `Terminal` application (or equivalent) from the application launcher, dock or Spotlight.
    2. Type `chmod +x` plus a space. This will allow you to run the script.
    3. Either drag & drop the `automate-eGPU.sh` file over the terminal or navigate to its directory.
    4. You should now have something like `chmod +x /this/is/the/dir/automate-eGPU.sh`, then press `Enter↩︎`.
    5. Now type `sudo` plus a space. This will run the script with administrator privileges.
    6. Again, either drag & drop the `automate-eGPU.sh` file over the terminal or navigate to its directory.
    7. You should now have something like `sudo /this/is/the/dir/automate-eGPU.sh`, then press `Enter↩︎`.
    8. Type in your user password and press `Enter↩︎`.
    9. You will see [outputs similar to these](https://github.com/goalque/automate-eGPU).
    10. Whenever asked to download NVIDIA drivers, type `y` and `Enter↩︎`.
9. Reboot your computer normally.
10. Turn on you eGPU enclosure and hot plug it into your computer via the respective Thunderbolt ports.
11. Again, run the script with administrator privileges:
    1. Open your `Terminal` application (or equivalent) from the application launcher, dock or Spotlight.
    2. Now type `sudo` plus a space. This will run the script with administrator privileges.
    3. Again, either drag & drop the `automate-eGPU.sh` file over the terminal or navigate to its directory.
    4. You should now have something like `sudo /this/is/the/dir/automate-eGPU.sh`, then press `Enter↩︎`.
    5. Type in your user password and press `Enter↩︎`.
    6. You will see [outputs similar to these](https://github.com/goalque/automate-eGPU).
    7. In some cases, you may have to add the `-a` flag after the script name (e.g.: `sudo ./automate-eGPU.sh -a`). If not successful with `-a`, run it again but now with the `-m` flag (e.g.: `sudo ./automate-eGPU.sh -m`), start over and skip this step.
12. Shut down your computer.
13. Connect your eGPU enclosure and boot your computer:
    1. In most cases it should work with the eGPU connected before turning the computer on.
    2. In case you see an indefinite black screen, only plug the eGPU after the chime sound, just when the Apple logo shows up.
14. Voilà!

### CUDA on macOS

For now I recommend [NVIDIA's CUDA on macOS installation guide](http://docs.nvidia.com/cuda/cuda-installation-guide-mac-os-x/), 
as it is very extensive, detailed and up-to-date. 
So far you can trust it, but you might run into a few quirks covered below. 
As a rule-of-thumb, mind your macOS, Xcode, NVIDIA drivers, CUDA, cuDNN versions, as well as their compatibility with your machine learning library of choice and *always research before updating any of them*.
This effectively means that at a certain point in time you will likely be running at least one of those (and eventually even all) in not-so-cutting-edge versions—to be fair, like in most of modern software development.

After installing CUDA, you may want to download and run [CUDA-Z](http://cuda-z.sourceforge.net/) for testing and statistics.

Another way of detecting CUDA devices, if you have chosen to install NVIDIA CUDA Samples, is to use `DeviceQuery`: 
1. Go to the directory where CUDA Samples where installed, e.g.: `~/NVIDIA_CUDA-9.0_Samples/1_Utilities/deviceQuery`.
2. On your terminal run: `make -f Makefile` to compile the application.
3. Once compiled, you can run it as `./deviceQuery` to identify CUDA-capable devices. [Sample output](https://gist.github.com/marnovo/7e9f0b36b6e199ccf08f3c8f3cefc4a9).

#### Known CUDA bugs and quirks

##### At compile time

**`nvcc fatal   : The version ('xxxxx') of the host compiler ('Apple clang') is not supported` error:**

This error is fairly common if you tend to keep your Xcode and/or C compiler up-to-date. 
It is caused by an incompatibility between the current Xcode (clang) compiler version installed and "active", 
and the versions supported by CUDA, which usually lags some months behind.
  
The fix is straightforward, but might be time consuming given Xcode humongous size:

1. Check the latest version of Xcode supported by CUDA in NVIDIA's [installation guide requirements for macOS](http://docs.nvidia.com/cuda/cuda-installation-guide-mac-os-x/#system-requirements).
2. Download the above respective version in [Apple's Developer downloads page](https://developer.apple.com/download/more/).
3. Unpack the zip file and rename the extracted `Xcode.app` adding the version it corresponds to, 
to avoid name collision and help you discern between the latest and last compatible versions, e.g.: `Xcode_8.3.3.app`.
4. From you terminal, run:
   `sudo xcode-select -s /path/to/your/Xcode_8.3.3.app/Contents/Developer` (requires administrator privileges).
5. You can also use a [simple bash script I provided](xcode-switcher-for-cuda.sh) to select the "active" Xcode version. 
Just make sure to edit it accordingly with your paths and filenames.

##### At runtime

**`Segmentation fault: 11` error:**

You might get these errors when running (even successfully) compiled CUDA programs or ML libraries.
This is likely a NVIDIA mistake when naming and packaging the CUDA installation files and setting PATHs, [as widely reported](https://github.com/tensorflow/tensorflow/issues/3263) by TensorFlow users.

The fix in this case involves creating a symbolic link between the library called and the existing one, as well as setting correct PATHs:

1. From your terminal, run:
   `sudo ln -sf /usr/local/cuda/lib/libcuda.dylib /usr/local/cuda/lib/libcuda.1.dylib` (requires administrator privileges).
2. Add the following PATHs to your environment profile (e.g.: `~/.bash_profile`, `~/.zshrc` or equivalent):
    1. Add `export CUDA_HOME=/usr/local/cuda`.
    2. Add `export DYLD_LIBRARY_PATH="$CUDA_HOME/lib:$DYLD_LIBRARY_PATH"`.
    3. Add `export PATH="$CUDA_HOME/bin:$PATH"`.
3. Restart or reload your shell to apply the new PATHs.

## License

MIT License

Copyright (c) 2017 Marcelo Novaes

For more information, see [LICENSE](LICENSE).
