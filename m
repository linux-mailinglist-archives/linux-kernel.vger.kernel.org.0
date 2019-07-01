Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1A71F930
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfEOROO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 13:14:14 -0400
Received: from foss.arm.com ([217.140.101.70]:49226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfEORON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:14:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C56380D;
        Wed, 15 May 2019 10:14:13 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D8153F5AF;
        Wed, 15 May 2019 10:14:12 -0700 (PDT)
Subject: Re: [v1] drm/arm/mali-dp: Disable checking for required pixel clock
 rate
To:     Wen He <wen.he_1@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Cc:     Leo Li <leoyang.li@nxp.com>
References: <20190515024348.43642-1-wen.he_1@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f87b2a7-c7e8-0597-2f62-d421aa6ccaa5@arm.com>
Date:   Wed, 15 May 2019 18:14:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515024348.43642-1-wen.he_1@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2019 03:42, Wen He wrote:
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
>   drivers/gpu/drm/arm/malidp_crtc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 56aad288666e..bb79223d9981 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -36,11 +36,13 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
>   
>   	if (req_rate) {
>   		rate = clk_round_rate(hwdev->pxlclk, req_rate);
> +#ifndef CONFIG_ARCH_LAYERSCAPE

What about multiplatform builds? The kernel config doesn't tell you what 
hardware you're actually running on.

Robin.

>   		if (rate != req_rate) {
>   			DRM_DEBUG_DRIVER("pxlclk doesn't support %ld Hz\n",
>   					 req_rate);
>   			return MODE_NOCLOCK;
>   		}
> +#endif
>   	}
>   
>   	return MODE_OK;
> 
