Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9948A1F7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 17:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfEOPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 11:45:33 -0400
Received: from foss.arm.com ([217.140.101.70]:47338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOPpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:45:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B62374;
        Wed, 15 May 2019 08:45:32 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A74493F703;
        Wed, 15 May 2019 08:45:32 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 0FDFD68240D; Wed, 15 May 2019 16:45:31 +0100 (BST)
Date:   Wed, 15 May 2019 16:45:31 +0100
From:   "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [v1] drm/arm/mali-dp: Disable checking for required pixel clock
 rate
Message-ID: <20190515154530.GX15144@e110455-lin.cambridge.arm.com>
References: <20190515024348.43642-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515024348.43642-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On Wed, May 15, 2019 at 02:42:08AM +0000, Wen He wrote:
> Disable checking for required pixel clock rate if ARCH_LAYERSCPAE
> is enable.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
> change in description:
> 	- This check that only supported one pixel clock required clock rate
> 	compare with dts node value. but we have supports 4 pixel clock
> 	for ls1028a board.

So, your DT says your pixel clock provider is a fixed clock? If you support
more than one rate, you should instead use a real provider for it. How do you
support the 4 pixel clocks?

Also, not sure what the paragraph above is meant to be. Should it be part of
the commit message?

Best regards,
Liviu


>  drivers/gpu/drm/arm/malidp_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 56aad288666e..bb79223d9981 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -36,11 +36,13 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
>  
>  	if (req_rate) {
>  		rate = clk_round_rate(hwdev->pxlclk, req_rate);
> +#ifndef CONFIG_ARCH_LAYERSCAPE
>  		if (rate != req_rate) {
>  			DRM_DEBUG_DRIVER("pxlclk doesn't support %ld Hz\n",
>  					 req_rate);
>  			return MODE_NOCLOCK;
>  		}
> +#endif
>  	}
>  
>  	return MODE_OK;
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
