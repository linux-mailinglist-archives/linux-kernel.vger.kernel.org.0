Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD01432D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 21:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgATUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 15:20:10 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:46542 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:20:09 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8C24C2002C;
        Mon, 20 Jan 2020 21:20:06 +0100 (CET)
Date:   Mon, 20 Jan 2020 21:20:05 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/panel: make LVDS panel driver DPI capable
Message-ID: <20200120202005.GA17555@ravnborg.org>
References: <20200115123401.2264293-1-oleksandr.suvorov@toradex.com>
 <20200115123401.2264293-2-oleksandr.suvorov@toradex.com>
 <20200118130418.GA13417@ravnborg.org>
 <CAGgjyvHVg9OBWqpBd9k1hf561VjFQwh3o9QUFcy1A=_KNnK2Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgjyvHVg9OBWqpBd9k1hf561VjFQwh3o9QUFcy1A=_KNnK2Gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=vY_M7HEJ-dsChd7xKHoA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr.

Thanks for the quick reply.

On Mon, Jan 20, 2020 at 10:03:20AM +0000, Oleksandr Suvorov wrote:
> Hi Sam,
> 
> On Sat, Jan 18, 2020 at 3:04 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > The LVDS panel driver has almost everything which is required to
> > > describe a simple parallel RGB panel (also known as DPI, Display
> > > Pixel Interface).
> > >
> > > ---
> >
> > There are a few high-level things we need to have sorted out.
> >
> > The driver, when this patch is added, assumes that certain properties
> > are now mandatory when using the panel-dpi compatible.
> >   - data-mapping
> >   - width-mm
> >   - height-mm
> >   - panel-timing
> >
> > But this does not match the panel-dpi binding.
> > So we need the panel-dpi binding updated first.
I just sent a patch-set converting this binding to DT schema.
Let's land this and you can make your changes on top of it.
Care to review it?

> >
> >
> > The current driver specify the connector type in drm_panel_init().
> > But a DPI panel is assumed to use a DRM_MODE_CONNECTOR_DPI,
> > and not a DRM_MODE_CONNECTOR_LVDS.
> > So the drm_panel_init() call needs to take into account the type
> > of binding.
> >
> Thanks, I'll fix it in 2nd version.
> >
> > > @@ -257,7 +279,7 @@ static struct platform_driver panel_lvds_driver = {
> > >       .probe          = panel_lvds_probe,
> > >       .remove         = panel_lvds_remove,
> > >       .driver         = {
> > > -             .name   = "panel-lvds",
> > > +             .name   = "panel-generic",
> >
> > I think changing the name of the driver like this is an UAPI change,
> > which is not OK
> 
> I see 2 simple ways there:
> - keep the original platform driver name;
Please keep the original platform driver name.
It is a bit confusing but this is the best option I see.

	Sam
