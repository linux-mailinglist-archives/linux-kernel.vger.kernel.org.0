Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D176103399
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfKTFQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 00:16:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKTFQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:16:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so13627662pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 21:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Yv25wQDQFczcnj/PFyL1UNH1JjWrPFTBbhbehaHIng=;
        b=Cv767rqnulM+BQqNRMs/64y/R7fbJKvDrNUq61kS1jLsdBTFOIriQ5SE6JtRP3K+PI
         R4QA8MfYXkeRgPR5jTAAlTc32XFG7VENXNKQkOOtvbYZ8DbApxDUIMCu6tCR2j/wZttV
         FKPPnam3ATxr4BZpfpZcOV16x8H0CpK2Kk4XHGewT0CS/cjcnmvs70fwV7PJR2WyDWxP
         CUJM17GTPQ/G/mc2Rad2UMIpy+ZkpmTaYiGUHHz5irFykwHjiY5bz0vXbdy1GWRSVO08
         h95M0PAJtd0xP18pJmSkaC+vJAZHbm/qbZ4O6tsEt1+7DLuDWNFYjMjcRMH2ReI4yOqz
         2WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Yv25wQDQFczcnj/PFyL1UNH1JjWrPFTBbhbehaHIng=;
        b=RkYKi5hbjKrAHwxleW3iAIXF3mvkomcsUwIA4xYZdgxy8TsvGoj4FRx2PyxN+jMwUT
         b8tH1RpMXQaTQVkMpS6GI2M/hp6xoblOSOlYRb4XpIfZr+OOq0EOk0siuvvzzyset8+M
         0dFsaosbM8tAGOIgbn9sXfr5XGJJqeqXN4RXJe4xPB2KXvMXYoduLeTTY+t8V3EfWbRB
         sOn5Km5c6cKuW7CVh2VlxoZvBIIUV3VKNFea0PtoWa64oO4Ax1BZz4P9BQ7ctR9sviIg
         JbyYXTz9roE0J5KrHRLzUEukRSS/Xq6A118HrussZnniYFMrTJuz+1ofVLFWWRy0Q9Qx
         fmyQ==
X-Gm-Message-State: APjAAAUIjCrC+LSxe3TelNjtVc1yBKjSByz87xgO5ytz5f4R6gLtvP0B
        AXsKa8c8SL9KYklGarJj2ZLLbA==
X-Google-Smtp-Source: APXvYqxYCLvD4vNiwsF3rw+Ca/QrYYPh39SinCgxiYzgZZOUCffAdOBAR+9g1TpfstwMdS9OIwJDow==
X-Received: by 2002:a63:5c42:: with SMTP id n2mr1007802pgm.229.1574226972064;
        Tue, 19 Nov 2019 21:16:12 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z6sm5508736pjd.9.2019.11.19.21.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 21:16:11 -0800 (PST)
Date:   Tue, 19 Nov 2019 21:16:08 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        ulf.hansson@linaro.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/5] arm64: defconfig: enable CONFIG_QCOM_CPR
Message-ID: <20191120051608.GT18024@yoga>
References: <20191119154621.55341-1-niklas.cassel@linaro.org>
 <20191119154621.55341-5-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119154621.55341-5-niklas.cassel@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Nov 07:46 PST 2019, Niklas Cassel wrote:

> Enable CONFIG_QCOM_CPR.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e76b42b25dd6..4385033c0a34 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -438,6 +438,7 @@ CONFIG_GPIO_PCA953X=y
>  CONFIG_GPIO_PCA953X_IRQ=y
>  CONFIG_GPIO_MAX77620=y
>  CONFIG_POWER_AVS=y
> +CONFIG_QCOM_CPR=y
>  CONFIG_ROCKCHIP_IODOMAIN=y
>  CONFIG_POWER_RESET_MSM=y
>  CONFIG_POWER_RESET_XGENE=y
> -- 
> 2.23.0
> 
