# macOS-eGPU-CUDA-guide

Current set up for CUDA machine learning and gaming on macOS using a NVIDIA eGPU

## Requirements

### Hardware

The ports/cables/adapters listed are just the ones relevant for the assembly of the combined rig.

#### Main components

- Apple notebook as [Apple MacBook Pro 13 inch 2015](http://www.trustedreviews.com/2015-13-inch-macbook-pro-review) (2x Thunderbolt 2)
- eGPU as [Akitio Node](https://www.akitio.com/expansion/node) (1x Thunderbolt 3, 1x PCIe)
- NVIDIA Pascal GPU as [GTX 1080 Ti](https://www.nvidia.com/en-us/geforce/products/10series/geforce-gtx-1080-ti/) (1x Displayport, 1x PCIe + others)
- External display as [Dell UP3216Q](http://www.dell.com/ed/business/p/dell-up3216q-monitor/pd) (1x Displayport + others)

#### Cables and adapters

- Displayport cable (2x Displayport, comes with display)
- Thunderbolt 3 cable (2x Thunderbolt 3, comes with Node)
- [Apple Thunderbolt 2 cable](https://www.apple.com/shop/product/MD861LL/A/apple-thunderbolt-cable-20-m) (2x Thunderbolt 2)
- [Apple Thunderbolt 2-3 adapter](https://www.apple.com/shop/product/MMEL2AM/A/thunderbolt-3-usb-c-to-thunderbolt-2-adapter) (1x Thunderbolt 2 + 1x Thunderbolt 3)

### Software

#### General

- [macOS Sierra](https://www.apple.com/lae/macos/sierra/)
- [macOS SIP disabled](https://www.igeeksblog.com/how-to-disable-system-integrity-protection-on-mac/)
- [Automate eGPU script](https://github.com/goalque/automate-eGPU)
- [NVIDIA Web drivers](http://www.nvidia.com/download/driverResults.aspx/117892/en-us)

#### Machine Learning

- [NVIDIA CUDA drivers](docs.nvidia.com/cuda/cuda-installation-guide-mac-os-x/)
- [Tensorflow](tensorflow.org)
- [cuDNN](https://developer.nvidia.com/cudnn)

#### Gaming

- [Wine](https://www.winehq.org)
- [Wineskin Winery](http://wineskin.urgesoftware.com/tiki-index.php) or [WineBottler](http://winebottler.kronenberg.org/) or possibly [CrossOver](https://www.codeweavers.com/products/crossover-mac/features) (for running Windows games)

## Get started step-by-step

WIP
