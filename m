Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608AF48489
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 15:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfFQNwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 09:52:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:29283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQNwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:52:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 06:52:19 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2019 06:52:19 -0700
Received: from rkammarx-mobl3.ger.corp.intel.com (unknown [10.252.61.163])
        by linux.intel.com (Postfix) with ESMTP id B38C05801A8;
        Mon, 17 Jun 2019 06:52:17 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: disallow building without
 CONFIG_PCI again
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
References: <20190617124632.1176809-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6103cc84-6af3-7b82-4cac-aea500934dd1@linux.intel.com>
Date:   Mon, 17 Jun 2019 15:52:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617124632.1176809-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 2:45 PM, Arnd Bergmann wrote:
> Compile-testing without PCI just causes warnings:
> 
> sound/soc/sof/sof-pci-dev.c:330:13: error: 'sof_pci_remove' defined but not used [-Werror=unused-function]
>   static void sof_pci_remove(struct pci_dev *pci)
>               ^~~~~~~~~~~~~~
> sound/soc/sof/sof-pci-dev.c:230:12: error: 'sof_pci_probe' defined but not used [-Werror=unused-function]
>   static int sof_pci_probe(struct pci_dev *pci,
>              ^~~~~~~~~~~~~
> 
> I tried to fix this in a way that would still allow compile
> tests, but it got too ugly, so this just reverts the patch
> that allowed it in the first place.
> 
> Most architectures do allow enabling PCI, so the value of the
> COMPILE_TEST alternative was not very high to start with.

I think COMPILE_TEST has value in that it exposed issues in the PCI 
headers, and in general COMPILE_TEST exposes code that can be 
simplified/refactored. That said I don't have the time to suggest an 
alternative at the moment so it's fine with me if you want to revert. If 
you don't mind sharing your config it'd help me work on this when I get 
a chance.
Thanks!

> 
> Fixes: e13ef82a9ab8 ("ASoC: SOF: add COMPILE_TEST for PCI options")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/sof/Kconfig       |  2 +-
>   sound/soc/sof/intel/hda.c   | 13 ++-----------
>   sound/soc/sof/sof-pci-dev.c |  4 ----
>   3 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> index 41f79cdcbf47..fb01f0ca6027 100644
> --- a/sound/soc/sof/Kconfig
> +++ b/sound/soc/sof/Kconfig
> @@ -11,7 +11,7 @@ if SND_SOC_SOF_TOPLEVEL
>   
>   config SND_SOC_SOF_PCI
>   	tristate "SOF PCI enumeration support"
> -	depends on PCI || COMPILE_TEST
> +	depends on PCI
>   	select SND_SOC_SOF
>   	select SND_SOC_ACPI if ACPI
>   	select SND_SOC_SOF_OPTIONS
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 140b1424f291..51c1c1787de7 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -533,9 +533,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>   	 * TODO: support interrupt mode selection with kernel parameter
>   	 *       support msi multiple vectors
>   	 */
> -#if IS_ENABLED(CONFIG_PCI)
>   	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI);
> -#endif
>   	if (ret < 0) {
>   		dev_info(sdev->dev, "use legacy interrupt mode\n");
>   		/*
> @@ -547,9 +545,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>   		sdev->msi_enabled = 0;
>   	} else {
>   		dev_info(sdev->dev, "use msi interrupt mode\n");
> -#if IS_ENABLED(CONFIG_PCI)
>   		hdev->irq = pci_irq_vector(pci, 0);
> -#endif
>   		/* ipc irq number is the same of hda irq */
>   		sdev->ipc_irq = hdev->irq;
>   		sdev->msi_enabled = 1;
> @@ -606,10 +602,8 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>   free_hda_irq:
>   	free_irq(hdev->irq, bus);
>   free_irq_vector:
> -#if IS_ENABLED(CONFIG_PCI)
>   	if (sdev->msi_enabled)
>   		pci_free_irq_vectors(pci);
> -#endif
>   free_streams:
>   	hda_dsp_stream_free(sdev);
>   /* dsp_unmap: not currently used */
> @@ -624,6 +618,7 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
>   {
>   	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
>   	struct hdac_bus *bus = sof_to_bus(sdev);
> +	struct pci_dev *pci = to_pci_dev(sdev->dev);
>   	const struct sof_intel_dsp_desc *chip = hda->desc;
>   
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
> @@ -652,12 +647,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
>   
>   	free_irq(sdev->ipc_irq, sdev);
>   	free_irq(hda->irq, bus);
> -#if IS_ENABLED(CONFIG_PCI)
> -	if (sdev->msi_enabled) {
> -		struct pci_dev *pci = to_pci_dev(sdev->dev);
> +	if (sdev->msi_enabled)
>   		pci_free_irq_vectors(pci);
> -	}
> -#endif
>   
>   	hda_dsp_stream_free(sdev);
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index ab58d4f9119f..e2b19782f01a 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -251,11 +251,9 @@ static int sof_pci_probe(struct pci_dev *pci,
>   	if (!sof_pdata)
>   		return -ENOMEM;
>   
> -#if IS_ENABLED(CONFIG_PCI)
>   	ret = pcim_enable_device(pci);
>   	if (ret < 0)
>   		return ret;
> -#endif
>   
>   	ret = pci_request_regions(pci, "Audio DSP");
>   	if (ret < 0)
> @@ -388,7 +386,6 @@ static const struct pci_device_id sof_pci_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(pci, sof_pci_ids);
>   
> -#if IS_ENABLED(CONFIG_PCI)
>   /* pci_driver definition */
>   static struct pci_driver snd_sof_pci_driver = {
>   	.name = "sof-audio-pci",
> @@ -400,6 +397,5 @@ static struct pci_driver snd_sof_pci_driver = {
>   	},
>   };
>   module_pci_driver(snd_sof_pci_driver);
> -#endif
>   
>   MODULE_LICENSE("Dual BSD/GPL");
> 

