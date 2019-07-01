Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001C44ADAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 00:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfFRWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 18:10:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRWKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:10:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 8027C260D74
Message-ID: <20372cd5e56d67b8e896c2d94b3d0d136cc2886e.camel@collabora.com>
Subject: Re: [PATCH 2/3] drm/rockchip: Add optional support for CRTC gamma
 LUT
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rockchip@lists.infradead.org,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Jun 2019 19:09:57 -0300
In-Reply-To: <CAKb7UvgvY0tJDV9A=4+8=iqraziyt8SGF-QrX=M8jz+R+5JC=A@mail.gmail.com>
References: <20190618213406.7667-1-ezequiel@collabora.com>
         <20190618213406.7667-3-ezequiel@collabora.com>
         <CAKb7UvgvY0tJDV9A=4+8=iqraziyt8SGF-QrX=M8jz+R+5JC=A@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 17:47 -0400, Ilia Mirkin wrote:
> On Tue, Jun 18, 2019 at 5:43 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
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
> > ---
> > Changes from RFC:
> > * Request (an optional) address resource for the LUT.
> > * Drop support for RK3399, which doesn't seem to work
> >   out of the box and needs more research.
> > * Support pass-thru setting when GAMMA_LUT is NULL.
> > * Add a check for the gamma size, as suggested by Ilia.
> > * Move gamma setting to atomic_commit_tail, as pointed
> >   out by Jacopo/Laurent, is the correct way.
> > ---
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index 12ed5265a90b..5b6edbe2673f 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
> > +                              struct drm_crtc_state *old_state)
> > +{
> > +       int idle, ret, i;
> > +
> > +       spin_lock(&vop->reg_lock);
> > +       VOP_REG_SET(vop, common, dsp_lut_en, 0);
> > +       vop_cfg_done(vop);
> > +       spin_unlock(&vop->reg_lock);
> > +
> > +       ret = readx_poll_timeout(vop_dsp_lut_is_enable, vop,
> > +                          idle, !idle, 5, 30 * 1000);
> > +       if (ret)
> > +               return;
> > +
> > +       spin_lock(&vop->reg_lock);
> > +
> > +       if (crtc->state->gamma_lut) {
> > +               if (!old_state->gamma_lut || (crtc->state->gamma_lut->base.id !=
> > +                                             old_state->gamma_lut->base.id))
> > +                       vop_crtc_write_gamma_lut(vop, crtc);
> > +       } else {
> > +               for (i = 0; i < crtc->gamma_size; i++) {
> > +                       u32 word;
> > +
> > +                       word = (i << 20) | (i << 10) | i;
> > +                       writel(word, vop->lut_regs + i * 4);
> > +               }
> 
> Note - I'm not in any way familiar with the hardware, so take with a
> grain of salt --
> 
> Could you just leave dsp_lut_en turned off in this case?
> 

That was the first thing I tried :-)

It seems dsp_lut_en is not to enable the CRTC gamma LUT stage,
but to enable writing the gamma LUT to the internal RAM.

And the specs list no register to enable/disable the gamma LUT.

Thanks!
Eze

