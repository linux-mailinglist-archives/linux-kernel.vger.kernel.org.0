Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71CC1691E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 22:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgBVV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 16:27:19 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:39562 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgBVV1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 16:27:19 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B446120095;
        Sat, 22 Feb 2020 22:27:14 +0100 (CET)
Date:   Sat, 22 Feb 2020 22:27:13 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     tang pengchuan <kevin3.tang@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Orson Zhai <orsonzhai@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH RFC v3 2/6] drm/sprd: add Unisoc's drm kms master
Message-ID: <20200222212713.GA30872@ravnborg.org>
References: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
 <1582271336-3708-3-git-send-email-kevin3.tang@gmail.com>
 <20200221213652.GD3456@ravnborg.org>
 <CAFPSGXacMKTPrxk_FOrwrvH_XfmO3dYCCa_GoPCe_HUfQFPHtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFPSGXacMKTPrxk_FOrwrvH_XfmO3dYCCa_GoPCe_HUfQFPHtw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=GLTfEzBshYVTt7jvnNEA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin/tang.

Thanks for the quick and detailed feedback.
Your questions are addressed below.

	Sam


> > > +static int sprd_drm_bind(struct device *dev)
> > > +{
> > > +     struct drm_device *drm;
> > > +     struct sprd_drm *sprd;
> > > +     int err;
> > > +
> > > +     drm = drm_dev_alloc(&sprd_drm_drv, dev);
> > > +     if (IS_ERR(drm))
> > > +             return PTR_ERR(drm);
> > You should embed drm_device in struct sprd_drm.
> > See example code in drm/drm_drv.c
> >
> > This is what modern drm drivers do.
> >
> > I *think* you can drop the component framework if you do this.
> >
> I have read it(drm/drm_drv.c) carefully, if drop the component framework,
> the whole our drm driver maybe need to redesign, so i still want to keep
> current design.
OK, fine.

> > > +     sprd_drm_mode_config_init(drm);
> > > +
> > > +     /* bind and init sub drivers */
> > > +     err = component_bind_all(drm->dev, drm);
> > > +     if (err) {
> > > +             DRM_ERROR("failed to bind all component.\n");
> > > +             goto err_dc_cleanup;
> > > +     }
> > When you have a drm_device - which you do here.
> > Then please use drm_err() and friends for error messages.
> > Please verify all uses of DRM_XXX
> >
>   modern drm drivers need drm_xxx to replace DRM_XXX?
Yes, use of DRM_XXX is deprecated - when you have a drm_device.

> >
> > > +     /* with irq_enabled = true, we can use the vblank feature. */
> > > +     drm->irq_enabled = true;
> > I cannot see any irq being installed. This looks wrong.
> >
> Our display controller isr is been register on crtc driver(sprd_dpu.c), not
> here.

I think you just need to move this to next patch and then it is fine.

	Sam

