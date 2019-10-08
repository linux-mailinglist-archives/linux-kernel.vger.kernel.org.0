Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791A9D0124
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJHTXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 15:23:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50154 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfJHTXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:23:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 1223428ECE6
Message-ID: <dad6ee9aa3699af0f794f467224a8a01798d86b2.camel@collabora.com>
Subject: Re: [PATCH v3 3/5] drm/rockchip: Add optional support for CRTC
 gamma LUT
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Date:   Tue, 08 Oct 2019 16:23:36 -0300
In-Reply-To: <20191007185432.GG126146@art_vandelay>
References: <20190930222802.32088-1-ezequiel@collabora.com>
         <20190930222802.32088-4-ezequiel@collabora.com>
         <20191007185432.GG126146@art_vandelay>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sean,

On Mon, 2019-10-07 at 14:54 -0400, Sean Paul wrote:
> On Mon, Sep 30, 2019 at 07:28:00PM -0300, Ezequiel Garcia wrote:
> > Add an optional CRTC gamma LUT support, and enable it on RK3288.
> > This is currently enabled via a separate address resource,
> > which needs to be specified in the devicetree.
> > 
> > The address resource is required because on some SoCs, such as
> > RK3288, the LUT address is after the MMU address, and the latter
> > is supported by a different driver. This prevents the DRM driver
> > from requesting an entire register space.
> > 
> > The current implementation works for RGB 10-bit tables, as that
> > is what seems to work on RK3288.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> > Changes from v2:
> > * None.
> > 
> > Changes from v1:
> > * drop explicit linear LUT after finding a proper
> >   way to disable gamma correction.
> > * avoid setting gamma is the CRTC is not active.
> > * s/int/unsigned int as suggested by Jacopo.
> > * only enable color management and set gamma size
> >   if gamma LUT is supported, suggested by Doug.
> > * drop the reg-names usage, and instead just use indexed reg
> >   specifiers, suggested by Doug.
> > 
> > Changes from RFC:
> > * Request (an optional) address resource for the LUT.
> > * Drop support for RK3399, which doesn't seem to work
> >   out of the box and needs more research.
> > * Support pass-thru setting when GAMMA_LUT is NULL.
> > * Add a check for the gamma size, as suggested by Ilia.
> > * Move gamma setting to atomic_commit_tail, as pointed
> >   out by Jacopo/Laurent, is the correct way.
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   3 +
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 114 ++++++++++++++++++++
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   7 ++
> >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
> >  4 files changed, 126 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > index dba352ec0ee3..fd1d987698ab 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > @@ -17,6 +17,7 @@
> >  #include "rockchip_drm_drv.h"
> >  #include "rockchip_drm_fb.h"
> >  #include "rockchip_drm_gem.h"
> > +#include "rockchip_drm_vop.h"
> >  
> >  static const struct drm_framebuffer_funcs rockchip_drm_fb_funcs = {
> >  	.destroy       = drm_gem_fb_destroy,
> > @@ -112,6 +113,8 @@ rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
> >  
> >  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> >  
> > +	rockchip_drm_vop_gamma_set(old_state);
> > +
> 
> Instead of duplicating the commit_tail helper, could you just implement
> .atomic_begin() and call this from there? I think the only hitch is if you
> need this to be completed before crtc->atomic_enable(), at which point you
> might need to call it from vop_crtc_atomic_enable() and then detect that in
> atomic_begin()
> 

I think moving this to .atomic_begin might be enough. Let me send a new
series and we can see how that goes.

Thanks for reviewing,
Ezequiel

