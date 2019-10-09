Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE519D047F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 01:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfJHXzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 19:55:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44174 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJHXzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:55:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id u12so184359pgb.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2qXzeBiy41nMC6BcEC9DH4mNbWNmy0bhhN79nocj224=;
        b=Xcswi/ZQHoJgM4K6vQuEbWpRb2t3ivGAEJdBvZ6J0FwR7fBA7PhJud+8XTKHlDwEq6
         OPtxpDYFnvgSt5/oP1srt4iULECQUR8PKCWtdLogu9O4eZB3Z7aMIKWcc8gHXcFjCLni
         iQ/3cgiG5VaBdVDBxFFQbx1SspbBXHtd/HY3e+glh68QFfFOlmTgWF+lsBwAgI7uMtkc
         brnIXFgndt9RcrcUZtYytJJMlrnUcK+UicbsraUJDFBfCfRJDCk5aNPopAnvaL0nmImI
         Q6yMRK1xSol4A/I3bjHi6J6tUVIlZEiqJrid+yRK+1SDmTPsi+OEaDNd6vFyGAT7eKeL
         lhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2qXzeBiy41nMC6BcEC9DH4mNbWNmy0bhhN79nocj224=;
        b=N4DUfnL83Wv74fZ2mBgXJKWiWds+udASL83sbaWplRdIzgh5cme1ifHYy0r4xMBXIX
         740oV9e/9VXkwrr/R+vHro7YpJU1hzLSIPndy+b+18a3Ysf6cGlYXNj+mahfyRSYobH5
         RhW+UNvTpEE4xEXXY7u8XYTdQ5421CW8EFmq6sbJjPN5UGJ5kY6VMFkw/Bv8pBZ2PXBD
         zrxmIyJ28UB7M5hm/j3gKLkDSC/z2W41l69XWVrK07fW4KPDURiJew3/Ty4JH2XJe6Fo
         mwQRaj927PAiaH2tdVjFnm+8As1ctvS6OTLl0Fh+x3kmR1VC9BcdJzgIsw53S5/wzBCg
         jBtg==
X-Gm-Message-State: APjAAAVd9iurjWKWojvaBK+3pU5k6Acr/k9G8CYCcqk1MOZ+6VAEc8s3
        uiF+fEQzlgnC5gIiImx2PhdM+w==
X-Google-Smtp-Source: APXvYqxwmHt87kHuLwa1sP/RCTOGLBqRXQsBJBD7JS7k2H1jPvZc+sbBKaNKWGK9A1RXQ1sd3hNMEQ==
X-Received: by 2002:a63:c40e:: with SMTP id h14mr1150602pgd.254.1570578908113;
        Tue, 08 Oct 2019 16:55:08 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 18sm223411pfp.100.2019.10.08.16.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:55:07 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:55:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2 0/2] Avoid regmap debugfs collisions in qcom llcc
 driver
Message-ID: <20191008235504.GN63675@minitux>
References: <20191008234505.222991-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008234505.222991-1-swboyd@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Oct 16:45 PDT 2019, Stephen Boyd wrote:

> Now a two part series. These patches fix a debugfs name collision for
> the llcc regmaps and moves the config to a local variable to save on
> image size.
> 
> Changes from v1 (https://lkml.kernel.org/r/20191004233132.194336-1-swboyd@chromium.org):
>  * New second patch
>  * Dropped static
>  * See range-diff below!
> 
> Stephen Boyd (2):
>   soc: qcom: llcc: Name regmaps to avoid collisions
>   soc: qcom: llcc: Move regmap config to local variable
> 
>  drivers/soc/qcom/llcc-slice.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> 
> Range-diff against v1:
> -:  ------------ > 1:  07bc0e8bdb6e soc: qcom: llcc: Name regmaps to avoid collisions
> 1:  0c54fc8a7ed6 ! 2:  5c4446e36783 soc: qcom: llcc: Name regmaps to avoid collisions
>     @@ Metadata
>      Author: Stephen Boyd <swboyd@chromium.org>
>      
>       ## Commit message ##
>     -    soc: qcom: llcc: Name regmaps to avoid collisions
>     +    soc: qcom: llcc: Move regmap config to local variable
>      
>     -    We'll end up with debugfs collisions if we don't give names to the
>     -    regmaps created inside this driver. Copy the template config over into
>     -    this function and give the regmap the same name as the resource name.
>     +    This is now a global variable that we're modifying to fix the name.
>     +    That isn't terribly thread safe and it's not necessary to be a global so
>     +    let's just move this to a local variable instead. This saves space in
>     +    the symtab and actually reduces kernel image size because the regmap
>     +    config is large and we can replace the initialization of that structure
>     +    with a memset and a few member assignments.
>      
>     -    Fixes: 7f9c136216c7 ("soc: qcom: Add broadcast base for Last Level Cache Controller (LLCC)")
>     -    Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>     -    Cc: Evan Green <evgreen@chromium.org>
>          Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>      
>       ## drivers/soc/qcom/llcc-slice.c ##
>     @@ drivers/soc/qcom/llcc-slice.c
>       
>       static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>       
>     --static const struct regmap_config llcc_regmap_config = {
>     +-static struct regmap_config llcc_regmap_config = {
>      -	.reg_bits = 32,
>      -	.reg_stride = 4,
>      -	.val_bits = 32,
>     @@ drivers/soc/qcom/llcc-slice.c: static struct regmap *qcom_llcc_init_mmio(struct
>       {
>       	struct resource *res;
>       	void __iomem *base;
>     -+	static struct regmap_config llcc_regmap_config = {
>     ++	struct regmap_config llcc_regmap_config = {

Now that this isn't static I like the end result better. Not sure about
the need for splitting it in two patches, but if Evan is happy I'll take
it.

Regards,
Bjorn

>      +		.reg_bits = 32,
>      +		.reg_stride = 4,
>      +		.val_bits = 32,
>     @@ drivers/soc/qcom/llcc-slice.c: static struct regmap *qcom_llcc_init_mmio(struct
>       
>       	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
>       	if (!res)
>     -@@ drivers/soc/qcom/llcc-slice.c: static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
>     - 	if (IS_ERR(base))
>     - 		return ERR_CAST(base);
>     - 
>     -+	llcc_regmap_config.name = name;
>     - 	return devm_regmap_init_mmio(&pdev->dev, base, &llcc_regmap_config);
>     - }
>     - 
> 
> base-commit: 8b0eed9f6e36a5488967b0acc51444d658dd711b
> -- 
> Sent by a computer through tubes
> 
