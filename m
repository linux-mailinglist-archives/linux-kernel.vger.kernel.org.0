Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BAA1C3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfENHgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 03:36:01 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60420 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfENHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:36:00 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 882062B6;
        Tue, 14 May 2019 09:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1557819358;
        bh=nolBExI+DWiS8pK5x3HhfK+hZ9kk42aFw2lSkjS8Nh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTMqPVjtXKUfpi1KBEi5RChx30hzmziJFFeKC14+oQlD3zipyBNFMKlcvX1Aqg8Dd
         c7LOV+/rXlfrHtGWnTuU5NvcFtlEg7pRVQnoukwFE+YmLcf/7ol724o4sDVN+u5pcb
         Fx0y6fbHqWBP8AdnCXPIXNGEh0H0IGbdMdfsZzpk=
Date:   Tue, 14 May 2019 10:35:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Remove duplicate header
Message-ID: <20190514073542.GA4969@pendragon.ideasonboard.com>
References: <5cda6ee2.1c69fb81.2949b.d3e7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cda6ee2.1c69fb81.2949b.d3e7@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sabyasachi,

Thank you for the patch.

On Tue, May 14, 2019 at 01:01:41PM +0530, Sabyasachi Gupta wrote:
> Remove drm/drm_panel.h which is included more than once
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/gpu/drm/bridge/panel.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 7cbaba2..402b318 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -15,7 +15,6 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_panel.h>

Which tree is this against ? The patch applies on neither drm-next nor
drm-misc-next.

While at it, could you you reorder the other header alphabetically to
make this kind of issue easier to notice ?

>  
>  struct panel_bridge {
>  	struct drm_bridge bridge;

-- 
Regards,

Laurent Pinchart
