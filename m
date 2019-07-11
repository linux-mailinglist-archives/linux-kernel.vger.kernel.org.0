Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD57D6600F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfGKTjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 15:39:01 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51478 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfGKTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:39:01 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id DC24D803F1;
        Thu, 11 Jul 2019 21:38:56 +0200 (CEST)
Date:   Thu, 11 Jul 2019 21:38:55 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override
 typical timing
Message-ID: <20190711193855.GB5912@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org>
 <20190630202246.GB15102@ravnborg.org>
 <CAD=FV=V_wTD1xpkXRe-z2HsZ8QXKq7jmq8CsfhMnFxi-5XDJjw@mail.gmail.com>
 <20190708175007.GA3511@ravnborg.org>
 <CAD=FV=XnDTKkscdCwFE1137aX6pTtv=5zqXf=yqcnchpZpt5_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XnDTKkscdCwFE1137aX6pTtv=5zqXf=yqcnchpZpt5_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=Xl9dLsEvoqQTC_bOKBsA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug.

> > > > > @@ -91,6 +92,8 @@ struct panel_simple {
> > > > >       struct i2c_adapter *ddc;
> > > > >
> > > > >       struct gpio_desc *enable_gpio;
> > > > > +
> > > > > +     struct drm_display_mode override_mode;
> > > > I fail to see where this poiter is assigned.
> > >
> > > In panel_simple_parse_override_mode().  Specifically:
> > >
> > > drm_display_mode_from_videomode(&vm, &panel->override_mode);
> >
> > The above code-snippet is only called in the panel has specified display
> > timings using display_timings - it is not called when display_mode is
> > used.
> > So override_mode is only assigned in some cases and not all cases.
> > This needs to be fixed so we do not reference override_mode unless
> > it is set.
> 
> I'm afraid I'm not following you here.

> 
> * override_mode is a structure that's directly part of "struct panel_simple".
I had somehow confused myself to think this was a pointer.
And you are right that override_mode is properly initialized when the
structure is allocated.

Sorry for not reading the code and your replies carefully enough.

	Sam
