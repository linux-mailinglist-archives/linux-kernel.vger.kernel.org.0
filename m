Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB89FD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfH1Id6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 04:33:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:64948 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfH1Id6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:33:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 01:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="181963014"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2019 01:33:55 -0700
Subject: Re: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and DLL
 register name
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
References: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f06c00b8-8c0f-f738-4b33-92129792a494@intel.com>
Date:   Wed, 28 Aug 2019 11:32:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/19 9:38 PM, Shirley Her (SC) wrote:
> Change O2 Host PLL and DLL register name
> 
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> change in V8:
>  1. fix patch format error
> 
> change in V7:
>  1. change subject
> 
> change in V6:
>  1. change subject and commit message to match the patch
>  2. change register name O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1
> 
> change in V5:
>  1. split 2 patches into 3 patches
>  2. make dll_adjust_count start from 0
>  3. fix ret overwritten issue
>  4. use break instead of goto
> 
> change in V4:
>  1. add a bug fix for V3
> 
> change in V3:
>  1. add more explanation in dll_recovery and execute_tuning function
>  2. move dll_adjust_count to O2_host struct
>  3. fix some coding style error
>  4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1
> 
> change in V2:
>  1. use usleep_range instead of udelay
>  2. move dll_adjust_count to sdhci-pci-o2micro.c
> 
> chagne in V1:
>  1. add error recovery function to relock DLL with correct phase
>  2. retuning HS200 after DLL locked
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 9dc4548..b3a33d9 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -51,7 +51,7 @@
>  #define O2_SD_VENDOR_SETTING2	0x1C8
>  #define O2_SD_HW_TUNING_DISABLE	BIT(4)
>  
> -#define O2_PLL_WDT_CONTROL1	0x1CC
> +#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>  #define  O2_PLL_SOFT_RESET	BIT(12)
> @@ -316,23 +316,23 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>  	u32 scratch32;
>  
>  	/* PLL software reset */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>  	scratch32 |= O2_PLL_SOFT_RESET;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  	udelay(1);
>  	scratch32 &= ~(O2_PLL_SOFT_RESET);
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  
>  	/* PLL force active */
>  	scratch32 |= O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  
>  	/* Wait max 20 ms */
>  	timeout = ktime_add_ms(ktime_get(), 20);
>  	while (1) {
>  		bool timedout = ktime_after(ktime_get(), timeout);
>  
> -		scratch = sdhci_readw(host, O2_PLL_WDT_CONTROL1);
> +		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
>  		if (scratch & O2_PLL_LOCK_STATUS)
>  			break;
>  		if (timedout) {
> @@ -350,9 +350,9 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>  
>  out:
>  	/* Cancel PLL force active */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>  	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  }
>  
>  static int sdhci_o2_get_cd(struct mmc_host *mmc)
> 

