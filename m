Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D812DF37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgAAOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 09:52:55 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38836 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgAAOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 09:52:55 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53F4B516;
        Wed,  1 Jan 2020 15:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1577890372;
        bh=Rk0K6LoFLxyI8BtA7Uh6mo1W3SlxSPy+7j4y/shJEn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThSsbgXR31D2hjqfzLrK8ukO7yklGCAxOK3T0Kg1IEDNXqQrxCqYshaHKs6ppwuYd
         VdDeu3jNG9N8HT7qHpdyyUfbR5eurnQbR3fiHC8SepYstUtT8iOvHhA3n/1+rMXd5W
         dv/xS9QDQ7XLYKIIAfOn2VZkDHqFwLDAiwiGTfFc=
Date:   Wed, 1 Jan 2020 16:52:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        kernel-janitors@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/16] drm: bridge: dw-hdmi: constify copied structure
Message-ID: <20200101145242.GA4855@pendragon.ideasonboard.com>
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
 <1577864614-5543-16-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1577864614-5543-16-git-send-email-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

Thank you for the patch.

On Wed, Jan 01, 2020 at 08:43:33AM +0100, Julia Lawall wrote:
> The dw_hdmi_hw structure is only copied into another structure,
> so make it const.
> 
> The opportunity for this change was found using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> index 2b7539701b42..dd56996fe9c7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
> @@ -291,7 +291,7 @@ static irqreturn_t snd_dw_hdmi_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct snd_pcm_hardware dw_hdmi_hw = {
> +static const struct snd_pcm_hardware dw_hdmi_hw = {
>  	.info = SNDRV_PCM_INFO_INTERLEAVED |
>  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		SNDRV_PCM_INFO_MMAP |

-- 
Regards,

Laurent Pinchart
