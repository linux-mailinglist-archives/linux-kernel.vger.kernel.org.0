Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095395E099
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 11:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGCJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 05:11:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35276 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfGCJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:10:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so904956pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=As2upjpnu0eNfhcHUKlBkgyy1u4yzbeYFixzSKqaDY4=;
        b=ObWcSxFyx81NI2OD5AYV1+2zf6+ZncHg9EmE7AwksRacdzCfdlIP0d9ckHlCSk+hAE
         lkIF1fwAfUwolfL8XdbQ0DqaD6bt2B1+RCqafwyRLeiMOQNEtmTnoR/6nVgXwKXbm9sU
         uxSk7sytU9XzbuoPWfaw76VZJQcVDVWHZ8tWKtLZL28YnSLgT0hSP9zD11bnACe+24F7
         GnFTEl6L7+NzdthUoBXS60y3CmnZ9N3bq1xqzwdpXzMQwLoKEITiT6AmxobFJbRpkujk
         3m+ymw+NthAjrjGNfrbA2ry19Ag6AnfdneyhwF0MwTOfOC5UVUgYLyt69JILg9kL5Zva
         DKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=As2upjpnu0eNfhcHUKlBkgyy1u4yzbeYFixzSKqaDY4=;
        b=mS1RY4gKxVs44DgCrgiutpykZIdbJCjUy2yTQE64c/QnGuYcjokOpMQj6kuiyeqKFp
         CKezDtY/AONGGGuw1j84Van770/zRPU6rpqv3WEn5e5fhRfC6SVGTWWnlNIyXOleZ5Kp
         rEpdRT9ZSfH998aGumE7sVK1xUyYbwJZwabdhxglsFhlnz2ykh2JPdgvWNnIEzTTMo1E
         IEOYsTllGuBgkwT5Nc7jEK+oqNPE7vBC+bVTx6Rbxk28J8dWFTeVPj5w9iBZFDAlOow6
         FEyUlYST+d2km10mgzWCuE4ATqwGSx38WkCkrt0N2J5ELnu3UeC0LVMmnVO9fwES0npH
         oeSA==
X-Gm-Message-State: APjAAAWG850nCANVZwDxHNmsBPKtz5noZ9+M2Nf1z3xjLHqTx7A+0kIi
        +R3yX7jDtVuYaEGgM1pnplo=
X-Google-Smtp-Source: APXvYqzFCXmdRw6ALVWTUgHPfy1hOiev9xTr20YFwbNlADqhKzfB6/Es/73il0GfRP7q2dFFqSPcKA==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr11615624pjq.114.1562145057087;
        Wed, 03 Jul 2019 02:10:57 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id x1sm1350046pjo.4.2019.07.03.02.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:10:56 -0700 (PDT)
Date:   Wed, 3 Jul 2019 02:10:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     shengjiu.wang@nxp.com
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] ASoC: fsl_esai: Wrap some operations to be
 functions
Message-ID: <20190703091046.GA8764@Asurada>
References: <cover.1562136119.git.shengjiu.wang@nxp.com>
 <f57c5a045c6e5491b1bc9831388eab2c88773176.1562136119.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57c5a045c6e5491b1bc9831388eab2c88773176.1562136119.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, yet two small comments inline.

Please add this to this patch in the next version:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

On Wed, Jul 03, 2019 at 02:42:04PM +0800, shengjiu.wang@nxp.com wrote:
> +static int fsl_esai_register_restore(struct fsl_esai *esai_priv)
> +{
> +	int ret;
> +	/* FIFO reset for safety */
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,

Checkpatch script would probably warn this. Usually we add a blank
line after variable declarations.

> @@ -866,22 +935,9 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, esai_priv);
>  
> -	/* Reset ESAI unit */
> -	ret = regmap_write(esai_priv->regmap, REG_ESAI_ECR, ESAI_ECR_ERST);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to reset ESAI: %d\n", ret);
> +	ret = fsl_esai_init(esai_priv);

Could we rename this function to fsl_easi_hw_init() or something
clear like fsl_esai_register_init? fsl_easi_init() feels like a
driver init() function to me.

Thank you
Nicolin
