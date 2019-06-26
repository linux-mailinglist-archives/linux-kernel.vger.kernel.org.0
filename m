Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F206056C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfFZOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:40:18 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40125 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfFZOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:40:18 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B6A632004F;
        Wed, 26 Jun 2019 16:40:14 +0200 (CEST)
Date:   Wed, 26 Jun 2019 16:40:13 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, tzimmermann@suse.de,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] drm/vram: store dumb bo dimensions.
Message-ID: <20190626144013.GB12510@ravnborg.org>
References: <20190626065551.12956-1-kraxel@redhat.com>
 <20190626065551.12956-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626065551.12956-2-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=P2sAgps8Zq9CMGv8isMA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd.

On Wed, Jun 26, 2019 at 08:55:50AM +0200, Gerd Hoffmann wrote:
> Store width and height of the bo.  Needed in case userspace
> sets up a framebuffer with fb->width != bo->width..
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_vram_helper.h     | 1 +
>  drivers/gpu/drm/drm_gem_vram_helper.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
> index 1a0ea18e7a74..3692dba167df 100644
> --- a/include/drm/drm_gem_vram_helper.h
> +++ b/include/drm/drm_gem_vram_helper.h
> @@ -39,6 +39,7 @@ struct drm_gem_vram_object {
>  	struct drm_gem_object gem;
>  	struct ttm_buffer_object bo;
>  	struct ttm_bo_kmap_obj kmap;
> +	unsigned int width, height;
>  
>  	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
>  	struct ttm_placement placement;
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> index 4de782ca26b2..c02bf7694117 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -377,6 +377,8 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
>  	gbo = drm_gem_vram_create(dev, bdev, size, pg_align, interruptible);
>  	if (IS_ERR(gbo))
>  		return PTR_ERR(gbo);
> +	gbo->width = args->width;
> +	gbo->height = args->height;
>  
>  	ret = drm_gem_handle_create(file, &gbo->gem, &handle);
>  	if (ret)

Be warned, I may have missed something in the bigger picture.

Your patch will set width and height only for dumb bo's
But we have several users of drm_gem_vram_create() that will
not set the width and height.

So only in some cases can we rely on them being set.
Should this be refactored so we always set width, height.
Or maybe say in a small comment that width,height are only
set for dumb bo's?

	Sam
