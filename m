Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2BB810B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404410AbfISSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 14:53:14 -0400
Received: from mailoutvs41.siol.net ([185.57.226.232]:37322 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404363AbfISSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:53:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D85765236A1;
        Thu, 19 Sep 2019 20:53:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SD6JFhZtoeQ4; Thu, 19 Sep 2019 20:53:11 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 845B952374C;
        Thu, 19 Sep 2019 20:53:11 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 4BB805236A1;
        Thu, 19 Sep 2019 20:53:11 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     roman.stratiienko@globallogic.com
Cc:     linux-kernel@vger.kernel.org, mripard@kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: drm/sun4i: Add missing pixel formats to the vi layer
Date:   Thu, 19 Sep 2019 20:53:10 +0200
Message-ID: <9229663.7SG9YZCNdo@jernej-laptop>
In-Reply-To: <20190918110541.38124-1-roman.stratiienko@globallogic.com>
References: <20190918110541.38124-1-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 18. september 2019 ob 13:05:41 CEST je 
roman.stratiienko@globallogic.com napisal(a):
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> According to Allwinner DE2.0 Specification REV 1.0, vi layer supports the
> following pixel formats:  ABGR_8888, ARGB_8888, BGRA_8888, RGBA_8888

It's true that DE2 VI layers support those formats, but it wouldn't change 
anything because alpha blending is not supported by those planes. These 
formats were deliberately left out because their counterparts without alpha 
exist, for example ABGR8888 <-> XBGR8888. It would also confuse user, which 
would expect that alpha blending works if format with alpha channel is 
selected.

Admittedly some formats with alpha are still reported as supported due to lack 
of their counterparts without alpha, but I'm fine with removing them for 
consistency.

Best regards,
Jernej

> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index bd0e6a52d1d8..07c27e6a4b77
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -404,17 +404,21 @@ static const struct drm_plane_funcs
> sun8i_vi_layer_funcs = { static const u32 sun8i_vi_layer_formats[] = {
>  	DRM_FORMAT_ABGR1555,
>  	DRM_FORMAT_ABGR4444,
> +	DRM_FORMAT_ABGR8888,
>  	DRM_FORMAT_ARGB1555,
>  	DRM_FORMAT_ARGB4444,
> +	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_BGR565,
>  	DRM_FORMAT_BGR888,
>  	DRM_FORMAT_BGRA5551,
>  	DRM_FORMAT_BGRA4444,
> +	DRM_FORMAT_BGRA8888,
>  	DRM_FORMAT_BGRX8888,
>  	DRM_FORMAT_RGB565,
>  	DRM_FORMAT_RGB888,
>  	DRM_FORMAT_RGBA4444,
>  	DRM_FORMAT_RGBA5551,
> +	DRM_FORMAT_RGBA8888,
>  	DRM_FORMAT_RGBX8888,
>  	DRM_FORMAT_XBGR8888,
>  	DRM_FORMAT_XRGB8888,




