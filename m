Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA53118D93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 17:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLJQ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 11:26:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:33968 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:26:58 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 171B7B85;
        Tue, 10 Dec 2019 17:26:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575995215;
        bh=INR/mKkQI/IM3YQhM9P0qlHvkaUK5RnEhhQJIaEZHZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cF1SCOvV+Yi9hh+C6cabPaVN0UqSFawHBYnJTZuU466QMjrST7uN7R8sLgGqIXqHe
         l7tAhnV0TYgKmZ/XOtAEyVn+UTyKRZ1kCvSbzhVKh9yRAhc5pSjnN5XriCu9BxKowN
         2XpDRlx0UxrGHqiqIc9PXH8ExnzxaFlxTvm5fhDM=
Date:   Tue, 10 Dec 2019 18:26:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Walleij <linux.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: panel: export drm_panel_bridge_connector
Message-ID: <20191210162647.GA5211@pendragon.ideasonboard.com>
References: <20191207140353.23967-5-sam@ravnborg.org>
 <20191210144834.27491-1-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210144834.27491-1-mihail.atanassov@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail,

Thank you for the patch.

On Tue, Dec 10, 2019 at 02:48:49PM +0000, Mihail Atanassov wrote:
> The function was unexported and was causing link failures for pl111 (and
> probably the other user tve200) in a module build.
> 
> Fixes: d383fb5f8add ("drm: get drm_bridge_panel connector via helper")
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Linux Walleij <linux.walleij@linaro.org>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/panel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 1443897f999b..f66777e24968 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -306,3 +306,4 @@ struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge)
>  
>  	return &panel_bridge->connector;
>  }
> +EXPORT_SYMBOL(drm_panel_bridge_connector);

-- 
Regards,

Laurent Pinchart
