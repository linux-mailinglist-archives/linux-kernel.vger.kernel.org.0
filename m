Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44F30D63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfEaLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 07:36:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:10520 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfEaLgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 04:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,535,1549958400"; 
   d="scan'208";a="180297619"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2019 04:36:43 -0700
Subject: Re: [PATCH] mmc: sdhci-pci: remove redundant check of slots == 0
To:     Colin King <colin.king@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190531113223.27474-1-colin.king@canonical.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4336bf57-5fcf-5758-8d0d-9fd4aec3df4a@intel.com>
Date:   Fri, 31 May 2019 14:35:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531113223.27474-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/19 2:32 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The calculation of slots results in a value in the range 1..8
> and so slots can never be zero.  The check for slots == 0 is
> always going to be false, hence it is redundant and can be
> removed.
> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index ab9e2b901094..f70436261746 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2044,8 +2044,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>  
>  	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
>  	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> -	if (slots == 0)
> -		return -ENODEV;
>  
>  	BUG_ON(slots > MAX_SLOTS);
>  
> 

