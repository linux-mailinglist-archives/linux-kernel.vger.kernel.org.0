Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE217E723
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 19:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgCISaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 14:30:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34266 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCISaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:30:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so3416670pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CgKKPr0xwtPbP32XtsKM4Pg2CezZujX8rIh5aLwqY9k=;
        b=EQLSmaWU2q/bTK6Rz1P45GyBkBUFS3bk+2CbcMCpLyAq43eVc2WPreKL5a+i6z50IO
         BR/zXDncKdn8muBymm9WU8GSDEM56XkkyORl7tIgBvKivwmAbhAmAHHB3ovqIRKKOshO
         EtoXWfLN/L5BEe5k5H+RUPFvglpuGtZ1vk6/J0cJEcAdXRO6vZaJ+QrMbU10kyjDdDW+
         ZuflQ1anPI1URnPeiwClBJyJKSLi8SWY4D4iX00Qp+5PLH7NZfgZtE7NdrBgxzhmmPr6
         OLpFA3LMf/Q66PZmU+NuBJAXMbCJ40awnoImK4en1CTK0jPuUL/XqKcm0TVxut5RraVS
         G69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CgKKPr0xwtPbP32XtsKM4Pg2CezZujX8rIh5aLwqY9k=;
        b=tCYJXwN8GF3nrYlwmgqHVTDymPspjw9v0gXSATXUkswkbfuPnbYjaCKWM+HkzzhBIM
         ChWDneegApTB2NjnFrHfSdXBsKsYW5JHJyElOnIP4IJZBUjmT45WCgjyTOsUhTYt22Gt
         ZzTWzw7Zjct1gstmfVnssn/PlrtjpNWuJ76+mVrS72UT9qUX3bbC5jOEgcaDqIjWMAeo
         7qMOwjeQAhCWshwsYlCV/EF5Yq7gW1pYUWQcEn2D4K/1EsXWObzq18O4a+oR+60fgyjV
         k6cr4Noqj7XJtek9R+gORH6N+f06rxbprxRlhvCAhbgbWLo6eTIiDS31XSRnhr/Xizmt
         +dUA==
X-Gm-Message-State: ANhLgQ0bmNFmkUcHYXXaoOmvvVHeVd0R2oqXchNUCU85Rrr74etpju2U
        RwUO/yaXM/kiKPJHlGLZp6Iuiw==
X-Google-Smtp-Source: ADFU+vtOyOd1fQy9lpTnW6EA7iLOMrbyb2Fi2EGCNHqKSXzU/O1QZSHNMGuRlAmRob7bmFMt7xi8cg==
X-Received: by 2002:a63:7783:: with SMTP id s125mr17195558pgc.214.1583778651239;
        Mon, 09 Mar 2020 11:30:51 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d22sm249134pja.14.2020.03.09.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:30:50 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:30:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dianders@google.com,
        mka@chromium.org, Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH V2] mmc: cqhci: Update cqhci memory ioresource name
Message-ID: <20200309183048.GB1098305@builder>
References: <1583323250-23596-1-git-send-email-vbadigan@codeaurora.org>
 <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Mar 05:25 PST 2020, Veerabhadrarao Badiganti wrote:

> Update cqhci memory ioresource name from cqhci_mem to cqhci since
> suffix _mem is redundant.
> 
> Only sdhci-msm driver is making use of this resource as of now.
> No other vendor's driver is using it. So this update shouldn't affect
> any other vendor's cqhci functionality.
> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

I do favor using names without the "_mem" suffix and it seems like the
existing code only acquire the first two regions by index. So this
should be fine.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>


But I do expect to see some patches fixing up the 8 dts files that now
has invalid reg-names.

Regards,
Bjorn

> ---
> Corresponding binding change:
> https://lore.kernel.org/linux-arm-msm/1582545470-11530-1-git-send-email-vbadigan@codeaurora.org/
> 
> Changes sicne V1:
> 	- Updated commit text expalining this change affects *only*
> 	  qcom cqhci functionality.
> 
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index e2ea2c4..e24b8ff 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -1077,7 +1077,7 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
>  
>  	/* check and setup CMDQ interface */
>  	cqhci_memres = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -						   "cqhci_mem");
> +						   "cqhci");
>  	if (!cqhci_memres) {
>  		dev_dbg(&pdev->dev, "CMDQ not supported\n");
>  		return ERR_PTR(-EINVAL);
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
