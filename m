Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E164F46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfGJXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 19:35:37 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35018 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfGJXfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:35:36 -0400
Received: by mail-pg1-f173.google.com with SMTP id s27so1980403pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 16:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fo3zNx7q8KOphF4/0k8ry1Exilbv+0XYzkMqa1pkdPw=;
        b=brITT/5d5a9WyodVg5ZUQsakATJo0F+/1F0NZxiiEO4WZQws6EdiwGGKUFKY2pt/Zo
         CYrZAOfPL/cCfxp3dHvE1aabIU8b7cgowtd3fXrrYR35j+w9wSFI4/MnhtzBbTlu/r6f
         JEKXEkQJ8j3TQqvb0K33a80yiZ+zyjPj5Z0pWmtYCvMAWLp/UJAgsVYiQ8MZ2pqd06Fp
         zjAAh5jbOtcdf3eu7kihy5eqVXw3cEWFA1QhWDw/g3HaPszaNu2XlkvfcZEoFxHBZ2vN
         4/RaulelQD0Ma3GGYGzUZGqEEk/VKTIwXHs0hbdk8/rAh81ECwzdFDbV1PeVNjYcWwM+
         vBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fo3zNx7q8KOphF4/0k8ry1Exilbv+0XYzkMqa1pkdPw=;
        b=s3E34wTLi9246JwatdKgbgSy1w1rjUpTcVCiX1PWOtlnArZCsnGugPrpPB9gCGA3TQ
         rQHYgolICSCcs9h1WM8ATJTLOlADaiwYRfVbJD0WJqjPEPOF7+18ydyNrfS5w7DL9yf4
         VyAX4+Sx9TFfMzFDv7tIgjai7ae6JJulThSr6kKJnp/CYjWVI/amfjKkQL11iHOmy2iR
         Po+2Pdd59Gu3hhK2zvZDIaysKax3k0A6peILFt8n9lTwz7pWVIU79DwkAnU7XtTc/Nu1
         mGhhu0p04oViZmLUrrGlf5gw7XKv7kCW1Ff863f+yi1YAHlMnRDI/cmQMhxtsl2w7/V4
         A98A==
X-Gm-Message-State: APjAAAXPT7lpfqXVave2d3g8oH6bGbD2e/LJ9OWDXkCVteF+VHjEgt0P
        BbJHJAhPWLtrUh7nbQ+Vwug=
X-Google-Smtp-Source: APXvYqxyqTCbrq1xdCzkoYVL+c48dQADntW+6Bi3tN/r4jmGUpVWI/udlq43jQcwlgvVT5ebKnuk1w==
X-Received: by 2002:a17:90a:36e4:: with SMTP id t91mr1101282pjb.22.1562801735794;
        Wed, 10 Jul 2019 16:35:35 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q1sm6318517pfn.178.2019.07.10.16.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 16:35:35 -0700 (PDT)
Date:   Wed, 10 Jul 2019 16:36:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     shengjiu.wang@nxp.com
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Message-ID: <20190710233605.GA9886@Asurada-Nvidia.nvidia.com>
References: <cover.1562566531.git.shengjiu.wang@nxp.com>
 <a055d9d590124aad2de70e97266e50d2bae752c8.1562566531.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a055d9d590124aad2de70e97266e50d2bae752c8.1562566531.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

Mostly looks good to me, just some small comments.

On Mon, Jul 08, 2019 at 02:38:52PM +0800, shengjiu.wang@nxp.com wrote:
  
> +static void fsl_esai_hw_reset(unsigned long arg)
> +{
> +	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
> +	u32 saisr, tfcr, rfcr;
> +	bool tx = true, rx = false, enabled[2];

Could we swap the lines of u32 and bool? It'd look better.

> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);

Let's add a line of comments for these two:
	/* Enforce ESAI personal resets for both TX and RX */

> +	/*
> +	 * Restore registers by regcache_sync, and ignore
> +	 * return value
> +	 */

Could fit into single-line?

> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK, 0);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
> +			   ESAI_PRRC_PDC_MASK, ESAI_PRRC_PDC(ESAI_GPIO));
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
> +			   ESAI_PCRC_PC_MASK, ESAI_PCRC_PC(ESAI_GPIO));

Could remove the blank line and add a line of comments:
	/* Remove ESAI personal resets by configuring PCRC and PRRC also */

Btw, I still feel this personal reset can be stuffed into one
of the wrapper functions. But let's keep this simple for now.

> +	regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);

Why do we read saisr here? All its bits would get cleared by
the hardware reset. If it's a must to clear again, we should
add a line of comments to emphasize it.

Thank you
