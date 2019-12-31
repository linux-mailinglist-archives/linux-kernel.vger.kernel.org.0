Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37512D835
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfLaLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 06:24:08 -0500
Received: from mailoutvs13.siol.net ([185.57.226.204]:36391 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726643AbfLaLYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:24:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A35B1523032;
        Tue, 31 Dec 2019 12:24:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mVev96vKAiOH; Tue, 31 Dec 2019 12:24:04 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4A6DB523035;
        Tue, 31 Dec 2019 12:24:04 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 01118523020;
        Tue, 31 Dec 2019 12:24:03 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        roman.stratiienko@globallogic.com
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: Re: [PATCH v2 2/4] drm/sun4i: Add mode_set callback to the engine
Date:   Tue, 31 Dec 2019 12:24:03 +0100
Message-ID: <2843589.CbtlEUcBR6@jernej-laptop>
In-Reply-To: <20191229162828.3326-2-roman.stratiienko@globallogic.com>
References: <20191229162828.3326-1-roman.stratiienko@globallogic.com> <20191229162828.3326-2-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne nedelja, 29. december 2019 ob 17:28:26 CET je 
roman.stratiienko@globallogic.com napisal(a):
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Create callback to update engine's registers on mode change.
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej

> ---
> v2:
> - Split commit in 2 parts.
> - Add description to mode_set callback
> - Dropped 1 line from sun4i_crtc_mode_set_nofb()
> - Add struct drm_display_mode declaration (fix build warning)
> ---
>  drivers/gpu/drm/sun4i/sun4i_crtc.c   |  3 +++
>  drivers/gpu/drm/sun4i/sunxi_engine.h | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> b/drivers/gpu/drm/sun4i/sun4i_crtc.c index 3a153648b369..f9c627d601c3
> 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -141,6 +141,9 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc
> *crtc) struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
> 
>  	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
> +
> +	if (scrtc->engine->ops->mode_set)
> +		scrtc->engine->ops->mode_set(scrtc->engine, mode);
>  }
> 
>  static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
> diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h
> b/drivers/gpu/drm/sun4i/sunxi_engine.h index 548710a936d5..44102783ee3c
> 100644
> --- a/drivers/gpu/drm/sun4i/sunxi_engine.h
> +++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
> @@ -9,6 +9,7 @@
>  struct drm_plane;
>  struct drm_device;
>  struct drm_crtc_state;
> +struct drm_display_mode;
> 
>  struct sunxi_engine;
> 
> @@ -108,6 +109,17 @@ struct sunxi_engine_ops {
>  	 * This function is optional.
>  	 */
>  	void (*vblank_quirk)(struct sunxi_engine *engine);
> +
> +	/**
> +	 * @mode_set:
> +	 *
> +	 * This callback is used to update engine registers that
> +	 * responsible for display frame size other mode attributes.
> +	 *
> +	 * This function is optional.
> +	 */
> +	void (*mode_set)(struct sunxi_engine *engine,
> +			 struct drm_display_mode *mode);
>  };
> 
>  /**




