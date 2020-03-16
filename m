Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5CA186F26
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgCPPui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 11:50:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33561 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731890AbgCPPuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:50:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so21873051wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppucAR3jBSlUx3f6FMEJLnESjyE6tqFd9bVOCG9Ch70=;
        b=KWi+mz5Ml7txmdoZr19aVQmfuq4pxYfgRps9r2wW5ZsBdqZUhieYBFFgGOjP2Y6bx4
         Wyhz0sJVzU+ttJVQaciTpiR1C0VRxuyTIVO+dc22nAk47TiATbV0DDmHWZKNHrvm2d4C
         vUaa0hW1YGFbvsd4Uq2C+TXdm+UshPrNCJCR7kDzhdknhAK2c/faq2qcpOcTCILD4e73
         SanxGSnN9MZ59DsdmAjiBTz1XxdiLtNTzfhIHxG2HnSi1v3DnTsQ2LGv/Q8k3NkWXNkz
         QoSGyKn9pcROOSXjXbika5mVnv89BwzwPk4bOrNqAP29KhbsRRP7ajNL8l0XJVmaY1q3
         +MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppucAR3jBSlUx3f6FMEJLnESjyE6tqFd9bVOCG9Ch70=;
        b=hHICkm4ysKVHE82x88fMf3nBwIz/aM62heUJnS4LpM6IbnhaQb5hqZa3hM+VdOnPD8
         Z68snaURYWpSaczGsjFAbNfKT/OPUZdE4sgcGuYg/DDn+FcJGec7Nfg8c7ICYbJIElXK
         alMYaFrqMCNmzekAJvzOZwsCkrSRuuSVvrmmNYa2AlJ1tZ9CNTeJheKz0fdsogwAh82H
         6iMcsPek2KhDcvJjqnjF6+iePx0SUpx4vHjtOZmsUs0/z2MiGmWRORxO7WjINHyBiVw6
         1E5xerRk2/K8yTF/8vkt3SsNyX/h3woXYYvngUajHrI8B/7kyJwz0MOj+2yQ6LpdlZsu
         Hc3w==
X-Gm-Message-State: ANhLgQ0pMHJwkxTBsNjqT3Me8CS4j8mYBrQVffd01bfp2gDlWvVr1h1j
        wLfH62W+Pp6i5dCqzG++tL1Yjg==
X-Google-Smtp-Source: ADFU+vvMLgpIudyWQDIKiFCwE2bd5t8QaZ3ZQI2eMwU4VsE9JIaD98F8TicbYAXHc+pSTvK+AYpoyA==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr43953wrn.62.1584373836280;
        Mon, 16 Mar 2020 08:50:36 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p16sm147962wmg.22.2020.03.16.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:50:35 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:50:28 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 11/15] iommu/renesas: Use accessor functions for iommu
 private data
Message-ID: <20200316155028.GK304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-12-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-12-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:12:25AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ecb3f9464dd5..310cf09feea3 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -89,9 +89,7 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
>  
>  static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	return fwspec ? fwspec->iommu_priv : NULL;
> +	return dev_iommu_priv_get(dev);

The removal of the fwspec NULL check was worrying me a little. Now any
user of to_ipmmu() directly dereferences dev->iommu->priv where they
previously tested first whether dev->fwspec was set. But I didn't find
anything that could go wrong, and the resulting code looks better.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

>  }
>  
>  #define TLB_LOOP_TIMEOUT		100	/* 100us */
> @@ -727,14 +725,13 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
>  static int ipmmu_init_platform_device(struct device *dev,
>  				      struct of_phandle_args *args)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct platform_device *ipmmu_pdev;
>  
>  	ipmmu_pdev = of_find_device_by_node(args->np);
>  	if (!ipmmu_pdev)
>  		return -ENODEV;
>  
> -	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
> +	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
