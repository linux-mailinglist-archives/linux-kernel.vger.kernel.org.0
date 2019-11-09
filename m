Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91452F5D14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 03:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfKICrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 21:47:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35459 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfKICrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:47:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id d13so6397544pfq.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 18:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cq4ckbPSNxVgpRvUOo2jxu08YcSsyOPv7EiFLNFV+wY=;
        b=BHLDbjp2/rjicvCl9Y6Pk/ehYvuXqPBXedtlwLQJ6829OC8HZwQ967is0orJ2YDroL
         HldAwgVrojmuko3zckLESNvoKOwgmP/HsWZVX7T8/ZDhtHij+BgfUJXCM1gWHTjxToas
         f8Xsbu71sf7NSixiLXUTZ2/i/1NCF61PFr8DOI91U8Mri732IefQkVCYXJLhovCFTgvM
         XL+kC0wSm1LX0crJx6yNQNTUDsqh3Y4zycOSS5BVxpjzVPLyaxqztoc/U6kaoiv8upxP
         aGNVu4M6PMMFMA41rZKciCsvXqgN90bXWvHb7lUfm7xPfMGJJGNqdi/zhgqfhaFxN/v1
         GfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cq4ckbPSNxVgpRvUOo2jxu08YcSsyOPv7EiFLNFV+wY=;
        b=AL0ykMoENl0ALfCrWp2NWHI1tvJ+PQkAKFvqNsM7Du1nK290PKaUXb1WGj3Qab9O/t
         qG+UxiQaxwkERzuKwLm6Ehds0HanZYE/exFfv6yu40owc2IAHXUpUw+fO9PXZJ77b8OK
         LOFqTyZvU6LZyHiHzyzqWenBLSkXP2+bDrQDqbpuBsHsqLKfSIZl7WgzQCwaMT8S4x1i
         1nHz05DaFQjG082L3ezWaMp22XUeXNfGLUZ03I/cRSY6aM9zUZFO/zXiCHR3hoM1ppqf
         +L6Zco0B92va0lZeWQruwZD6VuDFZHVpwXQUmckzQidzXzJtQcyHy8XEKsSHNiTbFYA0
         i0qg==
X-Gm-Message-State: APjAAAWmfSs4WzE3nJo2Ihdp0ONcIceCJrzedRsqXoHCcY85JnBehTby
        uWZYOGYqFMYAZ/gk2t7MSt2bMB/PE8I=
X-Google-Smtp-Source: APXvYqzOaurDRWYu9ke1kM+bB+a8DNEavcWgckpha8tyYpW7pnfmEP7gMnK3Q1hF+tuDBY5QVGIRDA==
X-Received: by 2002:a63:644:: with SMTP id 65mr7421600pgg.306.1573267629257;
        Fri, 08 Nov 2019 18:47:09 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r184sm8643749pfc.106.2019.11.08.18.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 18:47:09 -0800 (PST)
Date:   Fri, 8 Nov 2019 18:45:02 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_audmix: Add spin lock to protect tdms
Message-ID: <20191109024502.GA9187@Asurada-Nvidia.nvidia.com>
References: <1573025265-31852-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573025265-31852-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:27:45PM +0800, Shengjiu Wang wrote:
> Audmix support two substream, When two substream start
> to run, the trigger function may be called by two substream
> in same time, that the priv->tdms may be updated wrongly.
> 
> The expected priv->tdms is 0x3, but sometimes the
> result is 0x2, or 0x1.

Feels like a bug fix to me, so  might be better to have a "Fixes"
line and CC stable tree?

Anyway, change looks good to me:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_audmix.c | 6 ++++++
>  sound/soc/fsl/fsl_audmix.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index c7e4e9757dce..a1db1bce330f 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -286,6 +286,7 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>  				  struct snd_soc_dai *dai)
>  {
>  	struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
> +	unsigned long lock_flags;
>  
>  	/* Capture stream shall not be handled */
>  	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> @@ -295,12 +296,16 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		spin_lock_irqsave(&priv->lock, lock_flags);
>  		priv->tdms |= BIT(dai->driver->id);
> +		spin_unlock_irqrestore(&priv->lock, lock_flags);
>  		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		spin_lock_irqsave(&priv->lock, lock_flags);
>  		priv->tdms &= ~BIT(dai->driver->id);
> +		spin_unlock_irqrestore(&priv->lock, lock_flags);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -491,6 +496,7 @@ static int fsl_audmix_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->ipg_clk);
>  	}
>  
> +	spin_lock_init(&priv->lock);
>  	platform_set_drvdata(pdev, priv);
>  	pm_runtime_enable(dev);
>  
> diff --git a/sound/soc/fsl/fsl_audmix.h b/sound/soc/fsl/fsl_audmix.h
> index 7812ffec45c5..479f05695d53 100644
> --- a/sound/soc/fsl/fsl_audmix.h
> +++ b/sound/soc/fsl/fsl_audmix.h
> @@ -96,6 +96,7 @@ struct fsl_audmix {
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
>  	struct clk *ipg_clk;
> +	spinlock_t lock; /* Protect tdms */
>  	u8 tdms;
>  };
>  
> -- 
> 2.21.0
> 
