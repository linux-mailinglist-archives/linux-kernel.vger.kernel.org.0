Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED51760B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 18:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCBRJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 12:09:32 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41406 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCBRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:09:31 -0500
Received: by mail-il1-f194.google.com with SMTP id q13so130251ile.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pY7gYt6OotnqUFf5LH33Rx81o88vShjsNxCsLlJhYP4=;
        b=DtUzEjZ2EX4gK3h2FVa30ZrjyJn5c8NLbEZlX32xqFDizBzR9jkt1IsVoyBpkqIVBb
         wdyaBSEsz6fj8DYUIoFStMXzGiMEJUn2lsI7FDENHK2caElhml5HIDOdryQBb8stdj9N
         YxaE5AvIwMHeJGxU5Gb2TRUhrl93Uhn0RRAqR7q2ZTc/kcn1qqEp1/oOztL0T2j95BFZ
         DxetxZRndHIUODo4h/EmKsTjCh8Ut0dnmnBybKbPj5zqGbXkyAbWP3Y4Kr4l3uxWJmFX
         TAgksVEStQUML5z0Y5xDHz+lIx1OAPO6n0rEa7/clUAr3sRYIFSgC7eku6BsgxhRC6yk
         H+Ng==
X-Gm-Message-State: ANhLgQ1KNEmaRnJQhYyyOvxTCThoTUfj06hF961Jp21fkmu9FrLoyGtv
        /l+wfWjYi5dpa8FRHO9mFLdLnA==
X-Google-Smtp-Source: ADFU+vvLqUKxKaXlniz29wyCsSX4+Kp1o78dvk9pMAs2sRWuO4RBSRWjMfxc6G3wlV7VF6Vft4V9EA==
X-Received: by 2002:a92:9c57:: with SMTP id h84mr594806ili.94.1583168970924;
        Mon, 02 Mar 2020 09:09:30 -0800 (PST)
Received: from google.com ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id z63sm6813088ilk.44.2020.03.02.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:09:30 -0800 (PST)
Date:   Mon, 2 Mar 2020 10:09:26 -0700
From:   Raul Rangel <rrangel@chromium.org>
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x
Message-ID: <20200302170926.GA59937@google.com>
References: <20200219092900.9151-1-benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219092900.9151-1-benchuanggli@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 05:29:00PM +0800, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Enable MSI interrupt for GL9750/GL9755. Some platforms
> do not support PCI INTx and devices can not work without
> interrupt. Like messages below:
> 
> [    4.487132] sdhci-pci 0000:01:00.0: SDHCI controller found [17a0:9755] (rev 0)
> [    4.487198] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.PBR2._PRT.APS2], AE_NOT_FOUND (20190816/psargs-330)
> [    4.487397] ACPI Error: Aborting method \_SB.PCI0.PBR2._PRT due to previous error (AE_NOT_FOUND) (20190816/psparse-529)
> [    4.487707] pcieport 0000:00:01.3: can't derive routing for PCI INT A
> [    4.487709] sdhci-pci 0000:01:00.0: PCI INT A: no GSI
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 5eea8d70a85d..ce15a05f23d4 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -262,10 +262,26 @@ static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	return 0;
>  }
>  
> +static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
> +{
> +	int ret;
> +
> +	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		pr_warn("%s: enable PCI MSI failed, error=%d\n",
> +		       mmc_hostname(slot->host->mmc), ret);
> +		return;
> +	}
> +
> +	slot->host->irq = pci_irq_vector(slot->chip->pdev, 0);
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
>  
> +	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>  	sdhci_enable_v4_mode(host);
>  
> @@ -276,6 +292,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
>  
> +	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>  	sdhci_enable_v4_mode(host);
>  
Tested-by: Raul E Rangel <rrangel@chromium.org>

