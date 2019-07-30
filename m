Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB937AE63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfG3Qt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 12:49:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36365 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3Qt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:49:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so66616230wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3ZRZqPlW393A4SfrzlxF/J+oKcj3tnZsgx5iPZdNSso=;
        b=vQTGe9Dte9REAOhH9JGolroaWD4dTZ1rzPFTN/4owUiZJzp1y6xPes8mxPhZwiGnNr
         Et7QN71BQklkQ6VL9HjmjDE1nVT9zKKNciY3lIKqpv8wJqDEr7AbfE+2cNZ6OoEZr/Dg
         TdoOIiQzla6VD0sLnMJWLXDviutR/Dk2osIsAR4CKafkog8LwJvIeMPjEBW0tR53g4UT
         N+ryRRMjjTq6Rf58M77Cd/hE169n3Kl2b9agde2eYBzwf3KTIL+lD2uxNBOIqndq4JN8
         MVw0Wcm1GOGjrPPAWHI+ayaLdRGnboAWlcFd6tDu0EZXiAPzeecAy278oTSVpSHNhnlH
         VXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3ZRZqPlW393A4SfrzlxF/J+oKcj3tnZsgx5iPZdNSso=;
        b=jpl0zW8ECDLOxm/Zrj16XGTs/qj6tQEi05/wDj5f9ffQPltA9PRtqE0RBwlSGI7PaI
         lkRGcZjaKuUVwQUJ1Bc7CcaLO7QFmeQ4tQlooXgPOFKN0OInCe3+CBxQBtUR1f8jUGyG
         5JuquZwP1RF64YKbFXUGT02kHv49E73XkfF0aVWPgsGCyXY+LKo2+PVkPBcZLVzc4/ZE
         PBaS1qsk9++cxcIN3Y6oYCsu2Gyxmu7yNXR3OKWPVIs4C/NQTvnZuYVz46t5ytiEzqMk
         gkX3auvdh4fP4hqxcMAiRuwH4N/52tg9EbocHK79S43m3VMHuV0oJJgf0XyV4w1zLv4c
         akHw==
X-Gm-Message-State: APjAAAWAHImH1BqMXLT8LMFuYgutIRjogfSpiAgZmcuxA/shQ1qYGo/p
        NSv1hrOotPE6q2shB+5EKB4UY7ps
X-Google-Smtp-Source: APXvYqzESTEwOC9IAL8fmoPMmOEqSGjEqArpRdMzBvWvLXjbIO2WqkSqj7b+A4DapwI9I1UpF4ZfOA==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr44101776wro.348.1564505395346;
        Tue, 30 Jul 2019 09:49:55 -0700 (PDT)
Received: from arch-x1c3 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
        by smtp.gmail.com with ESMTPSA id x20sm148936433wrg.10.2019.07.30.09.49.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 09:49:54 -0700 (PDT)
Date:   Tue, 30 Jul 2019 17:49:26 +0100
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm: uapi: add gdepaper uapi header
Message-ID: <20190730164926.GD14551@arch-x1c3>
References: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
 <0e22c86a-3998-c2fd-cb14-203df547eb5c@jaseg.net>
 <20190730140852.GB12424@arch-x1c3>
 <52212fa4-e396-29c4-e5d2-07fbb371c302@jaseg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52212fa4-e396-29c4-e5d2-07fbb371c302@jaseg.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/31, Jan Sebastian G�tte wrote:
> Hi Emil,
> 
> thank you for your comments.
> 
> On 7/30/19 11:08 PM, Emil Velikov wrote:
> > On 2019/07/30, Jan Sebastian G�tte wrote:
> >> Signed-off-by: Jan Sebastian G�tte <linux@jaseg.net>
> >> ---
> >>  include/uapi/drm/gdepaper_drm.h | 62 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 62 insertions(+)
> >>  create mode 100644 include/uapi/drm/gdepaper_drm.h
> >>
> >> diff --git a/include/uapi/drm/gdepaper_drm.h b/include/uapi/drm/gdepaper_drm.h
> >> new file mode 100644
> >> index 000000000000..84ff6429bef5
> >> --- /dev/null
> >> +++ b/include/uapi/drm/gdepaper_drm.h
> >> @@ -0,0 +1,62 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> >> +/* gdepaper_drm.h
> >> + *
> >> + * Copyright (c) 2019 Jan Sebastian G�tte
> >> + */
> >> +
> > I'm glad to see more devices using upstream KMS interface. Usually
> > custom UAPI should not be needed for such devices.
> > 
> > Can you elaborate why this is required? Is there an open-source
> > userspace that uses these?
> 
> Not yet. I added this API because I couldn't figure out a way to do that in KMS. What I need is some way for userspace to tell the driver parameters for the display refresh (driving waveforms, refresh speed etc.) on a frame-by-frame basis. These parameters depend on ambient temperature and the displayed content. One has to trade off speed, ghosting and the number of possible partial refreshes until next full one.
> 
> Usually, epaper display refresh all pixels at once like an LCD would. This takes about 15s of flickering for b/w/red displays. Since they're bistable, they can also only physically refresh part of the area though. The reason for not having that on-by-default is that epaper partial refresh is really tricky. If you refresh the same area partially a few times, charge builds up, image quality degrades and the picture starts bleeding. If you refresh the same area partially all the time and don't do enough full refresh cycles to balance charges again, eventually the display is going to get permanent burn-in. I think partial refresh should be supported by a driver like this since it's a good tool to alleviate the enormous full refresh times.
> 
> For partial hardware refresh you have to customize all these values and the waveform LUTs depending on the displayed content. For example you might want a LUT specifying more inversion cycles for text display to reduce ghosting, or one with less cycles but higher voltages for some spinning loading animation to reduce flickering. If you are displaying a loading bar you might be able to get away with a high drive strength since you know it's going to be done in a few frames, but if you display e.g. a text console you might want to reduce drive strength to do as many partial updates as possible before the next full refresh, to reduce flicker. 
> 
> I think what one would like to do from userspace here is along the lines of:
> * set voltages depending on content
> * set waveforms depending on content
> * write framebuffer
> * (optional) trigger partial refresh of affected areas
> 
> You can get the display up and running with some default values and the factory-programmed OTP LUTs using full hardware refresh, but if you try partial hardware refresh with those you get a irrecognizable mess.
> 
> >> +#ifndef _UAPI_GDEPAPER_DRM_H_
> >> +#define _UAPI_GDEPAPER_DRM_H_
> >> +
> >> +#include "drm.h"
> >> +
> >> +#if defined(__cplusplus)
> >> +extern "C" {
> >> +#endif
> >> +
> >> +enum drm_gdepaper_vghl_lv {
> >> +	DRM_GDEP_PWR_VGHL_16V = 0,
> >> +	DRM_GDEP_PWR_VGHL_15V = 1,
> >> +	DRM_GDEP_PWR_VGHL_14V = 2,
> >> +	DRM_GDEP_PWR_VGHL_13V = 3,
> >> +};
> >> +
> >> +struct gdepaper_refresh_params {
> >> +	enum drm_gdepaper_vghl_lv vg_lv; /* gate voltage level */
> > From my experience, kernel drivers aim to avoid exposing voltage control
> > to userspace. AFAICT exceptions are present, but generally it's a no-go
> I agree with that. FWIW, in this draft these properties are exposed through a DRM_ROOT_ONLY ioctl.
> 
> >> +	__u32 vcom_sel; /* VCOM select bit according to datasheet */
> >> +	__s32 vdh_bw_mv; /* drive high level, b/w pixel (mV) */
> >> +	__s32 vdh_col_mv; /* drive high level, red/yellow pixel (mV) */
> >> +	__s32 vdl_mv; /* drive low level (mV) */
> >> +	__s32 vcom_dc_mv;
> >> +	__u32 vcom_data_ivl_hsync; /* data ivl len in hsync periods */
> >> +	__u32 border_data_sel; /* "vbd" in datasheet */
> >> +	__u32 data_polarity; /* "ddx" in datasheet */
> > These properties look like they should live in the device-tree bindings.
> 
> On init they are loaded from dt, but they can be overwritten via ioctl. This would be necessary for anything using the display's partial hardware refresh feature and might change frame-by-frame.
> 
> >> +	__u32 use_otp_luts_flag; /* Use OTP LUTs */
> >> +	__u8 lut_vcom_dc[44];
> >> +	__u8 lut_ww[42];
> >> +	__u8 lut_bw[42];
> >> +	__u8 lut_bb[42];
> >> +	__u8 lut_wb[42];
> > There is UAPI to manage LUT (or was it WIP with patches on the list) via
> > the atomic API. Is that not flexible enough for your needs?
> 
> I had a look around, and I found something in uapi/drm/drm_mode.h for color LUTs. This isn't color LUTs though. The vendor should really have called them "waveform tables". They basically contain a list of voltage levels a pixel transitioning white-black, white-red etc. should be driven at. The format seems to be standardized across different driver chips, but I'd really treat them as device-dependent binary blobs since for some chips they're not even specified and there's no guarantee the format won't suddenly change for some new chip.
> 
> >> +};
> >> +
> >> +/* Force a full display refresh */
> >> +#define DRM_GDEPAPER_FORCE_FULL_REFRESH		0x00
> >> +#define DRM_GDEPAPER_GET_REFRESH_PARAMS		0x01
> >> +#define DRM_GDEPAPER_SET_REFRESH_PARAMS		0x02
> >> +#define DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN	0x03
> >> +
> >> +#define DRM_IOCTL_GDEPAPER_FORCE_FULL_REFRESH \
> >> +	DRM_IO(DRM_COMMAND_BASE + DRM_GDEPAPER_FORCE_FULL_REFRESH)
> >> +#define DRM_IOCTL_GDEPAPER_GET_REFRESH_PARAMS \
> >> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_GET_REFRESH_PARAMS, \
> >> +	struct gdepaper_refresh_params)
> >> +#define DRM_IOCTL_GDEPAPER_SET_REFRESH_PARAMS \
> >> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_REFRESH_PARAMS, \
> >> +	struct gdepaper_refresh_params)
> >> +#define DRM_IOCTL_GDEPAPER_SET_PARTIAL_UPDATE_EN \
> >> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN, __u32)
> >> +
> > Similarly to the LUT above, the atomic UAPI has support for partial
> > updates. The property is called FB_DAMAGE_CLIPS and there is an example
> > in weston how to use it see 009b3cfa6f16bb361eb54efcc7435bfede4524bc.
> 
> I do already have support for that. The partial_update_en flag here controls whether the partial hardware refresh is used to implement that. The force_full_refresh thing would be useful to do the periodic (every 10hrs) refresh required by the display's specs without having to re-render the content.
> 
Correct me if I'm wrong, so it sounds like at least the full refresh is
a decision that can and should in the kernel? After all we don't need
an ioctl if it's a trivial "wait 10h, full refresh".

With regards to the other properties, what heuristic are you using to
adjust the parameters? Perhaps it's better to expose the decision itself
to the kernel module?

This way, the kernel can change voltages and perform sanity checks (rate
limit, temperature, etc.) instead of "blindly" damaging the hardware.

HTH
Emil
