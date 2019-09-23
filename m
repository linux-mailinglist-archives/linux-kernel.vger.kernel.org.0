Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C06BBA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440174AbfIWRbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 13:31:13 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40234 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437821AbfIWRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:31:13 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3E7FF20042;
        Mon, 23 Sep 2019 19:31:08 +0200 (CEST)
Date:   Mon, 23 Sep 2019 19:31:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/36] drm/atmel-hlcdc: use bpp instead of cpp for
 drm_format_info
Message-ID: <20190923173106.GA13649@ravnborg.org>
References: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
 <1569243119-183293-2-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569243119-183293-2-git-send-email-hjc@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=s8YR1HE3AAAA:8
        a=GZYic5qFh62CaahH_tAA:9 a=CjuIK1q_8ugA:10 a=jGH_LyMDp9YhSvY-UuyI:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy.

Thanks for taking care of this, but...

On Mon, Sep 23, 2019 at 08:51:45PM +0800, Sandy Huang wrote:
> cpp[BytePerPlane] can't describe the 10bit data format correctly,
> So we use bpp[BitPerPlane] to instead cpp.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 89f5a75..ab7d423 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -644,7 +644,7 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  		int xdiv = i ? fb->format->hsub : 1;
>  		int ydiv = i ? fb->format->vsub : 1;
>  
> -		state->bpp[i] = fb->format->cpp[i];
> +		state->bpp[i] = fb->format->bpp[i] / 8;
>  		if (!state->bpp[i])
>  			return -EINVAL;

Awaiting conclusion on Daniels comment on PATCH 1 and has dropped this
patch for now.
And please address the concerns Rob has about bisectability in your
cover letter for v2.

	Sam
