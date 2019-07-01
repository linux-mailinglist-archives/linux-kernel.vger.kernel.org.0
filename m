Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6112916D87
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 00:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEGWbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 18:31:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:58843 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfEGWbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:31:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 15:31:15 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 07 May 2019 15:31:15 -0700
Received: from khbyers-mobl2.amr.corp.intel.com (unknown [10.251.29.37])
        by linux.intel.com (Postfix) with ESMTP id 21B63580105;
        Tue,  7 May 2019 15:31:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Add Cometlake PCI IDs
To:     Evan Green <evgreen@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
References: <20190507215359.113378-1-evgreen@chromium.org>
 <20190507215359.113378-3-evgreen@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com>
Date:   Tue, 7 May 2019 17:31:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507215359.113378-3-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 4:53 PM, Evan Green wrote:
> Add PCI IDs for Intel CometLake platforms, which from a software
> point of view are extremely similar to Cannonlake platforms.

Humm, I have mixed feelings here.

Yes the hardware is nearly identical, with the exception of one detail 
that's not visible to the kernel, but there is no support for DMICs with 
the Skylake driver w/ HDaudio, and Chrome platforms are only going with 
SOF, so is it wise to add these two CometLake platforms to the default 
SND_SOC_INTEL_SKYLAKE selector, which is used by a number of distributions?

I don't mind if we add those PCI IDs and people use this driver if they 
wish to, but it may be time for an explicit opt-in? The 
SND_SOC_INTEL_SKYLAKE definition should even be pruned to mean SKL, APL, 
KBL and GLK, and we can add DMI-based quirks for e.g. the Up2 board and 
GLK Chromebooks which work with SOF.

> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> Changes in v2:
> - Add 0x06c8 for CML-H (Pierre-Louis)
> 
>   sound/soc/intel/Kconfig                | 18 ++++++++++++++++++
>   sound/soc/intel/skylake/skl-messages.c | 16 ++++++++++++++++
>   sound/soc/intel/skylake/skl.c          | 10 ++++++++++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index fc1396adde71..1ebac54b7081 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -110,6 +110,8 @@ config SND_SOC_INTEL_SKYLAKE
>   	select SND_SOC_INTEL_GLK
>   	select SND_SOC_INTEL_CNL
>   	select SND_SOC_INTEL_CFL
> +	select SND_SOC_INTEL_CML_H
> +	select SND_SOC_INTEL_CML_LP
>   	help
>             This is a backwards-compatible option to select all devices
>   	  supported by the Intel SST/Skylake driver. This option is no
> @@ -165,6 +167,22 @@ config SND_SOC_INTEL_CFL
>   	  If you have a Intel CoffeeLake platform with the DSP
>   	  enabled in the BIOS then enable this option by saying Y or m.
>   
> +config SND_SOC_INTEL_CML_H
> +	tristate "CometLake-H Platforms"
> +	depends on PCI && ACPI
> +	select SND_SOC_INTEL_SKYLAKE_FAMILY
> +	help
> +	  If you have a Intel CometLake-H platform with the DSP
> +	  enabled in the BIOS then enable this option by saying Y or m.
> +
> +config SND_SOC_INTEL_CML_LP
> +	tristate "CometLake-LP Platforms"
> +	depends on PCI && ACPI
> +	select SND_SOC_INTEL_SKYLAKE_FAMILY
> +	help
> +	  If you have a Intel CometLake-LP platform with the DSP
> +	  enabled in the BIOS then enable this option by saying Y or m.
> +
>   config SND_SOC_INTEL_SKYLAKE_FAMILY
>   	tristate
>   	select SND_SOC_INTEL_SKYLAKE_COMMON
> diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
> index 4bf70b4429f0..df01dc952521 100644
> --- a/sound/soc/intel/skylake/skl-messages.c
> +++ b/sound/soc/intel/skylake/skl-messages.c
> @@ -255,6 +255,22 @@ static const struct skl_dsp_ops dsp_ops[] = {
>   		.init_fw = cnl_sst_init_fw,
>   		.cleanup = cnl_sst_dsp_cleanup
>   	},
> +	{
> +		.id = 0x02c8,
> +		.num_cores = 4,
> +		.loader_ops = bxt_get_loader_ops,
> +		.init = cnl_sst_dsp_init,
> +		.init_fw = cnl_sst_init_fw,
> +		.cleanup = cnl_sst_dsp_cleanup
> +	},
> +	{
> +		.id = 0x06c8,
> +		.num_cores = 4,
> +		.loader_ops = bxt_get_loader_ops,
> +		.init = cnl_sst_dsp_init,
> +		.init_fw = cnl_sst_init_fw,
> +		.cleanup = cnl_sst_dsp_cleanup
> +	},
>   };
>   
>   const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 4ed5b7e17d44..f864f7b3df3a 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -1166,6 +1166,16 @@ static const struct pci_device_id skl_ids[] = {
>   	/* CFL */
>   	{ PCI_DEVICE(0x8086, 0xa348),
>   		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +#endif
> +#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_LP)
> +	/* CML-LP */
> +	{ PCI_DEVICE(0x8086, 0x02c8),
> +		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> +#endif
> +#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_H)
> +	/* CML-H */
> +	{ PCI_DEVICE(0x8086, 0x06c8),
> +		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
>   #endif
>   	{ 0, }
>   };
> 

