Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F68CB4C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 09:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbfJDHCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 03:02:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42478 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbfJDHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:02:47 -0400
Received: from pendragon.ideasonboard.com (modemcable151.96-160-184.mc.videotron.ca [184.160.96.151])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 55CAB2E5;
        Fri,  4 Oct 2019 09:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1570172565;
        bh=zrmGFbzG/xfE9YuhXNxnTY76RKJI2smtQphq1F+z+qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsTRP76d6DshPuBsb+yJthu1LXvQRz2gJ/DeNpO+FRr80VEQBegUxgXQB/Xk4XNA7
         Z2Oa1uF1bX19rXANY+O6G5WWa1svRYuun46yNIarOMkrP1BziraQjA+ePnMcjxX9Wv
         CQh80E7fSvDHK7yJ3klcIw+WS5aefuRxP9r9JWiA=
Date:   Fri, 4 Oct 2019 10:02:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sii902x: Variable status in
 sii902x_connector_detect() could be uninitialized if regmap_read() fails
Message-ID: <20190930231948.GB10149@pendragon.ideasonboard.com>
References: <20190930044502.18734-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930044502.18734-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yizhuo,

Thank you for the patch.

On Sun, Sep 29, 2019 at 09:45:02PM -0700, Yizhuo wrote:
> In function sii902x_connector_detect(), variable "status" could be
> initialized if regmap_read() fails. However, "status" is used to

I assume you meant "could be uninitialized" ?

> decide the return value, which is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 38f75ac580df..afce64f51ff2 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -246,7 +246,7 @@ static enum drm_connector_status
>  sii902x_connector_detect(struct drm_connector *connector, bool force)
>  {
>  	struct sii902x *sii902x = connector_to_sii902x(connector);
> -	unsigned int status;
> +	unsigned int status = 0;
>  
>  	mutex_lock(&sii902x->mutex);

I'll add a bit more context:

> 	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>
> 	mutex_unlock(&sii902x->mutex);
>
> 	return (status & SII902X_PLUGGED_STATUS) ?
> 	       connector_status_connected : connector_status_disconnected;

If regmap read fails, shouldn't we return connector_status_unknown ?

-- 
Regards,

Laurent Pinchart
