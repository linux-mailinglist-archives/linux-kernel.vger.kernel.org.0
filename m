Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA610E11F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLAJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 04:10:02 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:34604 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLAJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 04:10:02 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A87B980656;
        Sun,  1 Dec 2019 10:09:43 +0100 (CET)
Date:   Sun, 1 Dec 2019 10:09:41 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: clean up indentation issue
Message-ID: <20191201090941.GA8753@ravnborg.org>
References: <20190925120357.10408-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925120357.10408-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=DfNHnWVPAAAA:8
        a=X4VG-in_caqo2OVBQ50A:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin.

On Wed, Sep 25, 2019 at 01:03:57PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a continue statement that is indented one level too deeply,
> remove the extraneous tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
> index 2bae1db3ff34..7dd67262a2ed 100644
> --- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
> +++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
> @@ -161,7 +161,7 @@ static int lcd_olinuxino_get_modes(struct drm_panel *panel)
>  				lcd_mode->hactive,
>  				lcd_mode->vactive,
>  				lcd_mode->refresh);
> -				continue;
> +			continue;
>  		}
>  
>  		mode->clock = lcd_mode->pixelclock;

Thanks, this is the kind of issues that can fool one or take
focus away when reading code.

Applied to drm-misc-next.

	Sam
