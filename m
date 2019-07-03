Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90C5D2DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGBP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 11:29:14 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34061 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGBP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:29:14 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 548C91C0012;
        Tue,  2 Jul 2019 15:29:09 +0000 (UTC)
Date:   Tue, 2 Jul 2019 17:29:08 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bhushan Shah <bshah@mykolab.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?utf-8?B?5Z2a5a6a5YmN6KGM?= <powerpan@qq.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v10 04/11] drm/sun4i: tcon: Compute
 DCLK dividers based on format, lanes
Message-ID: <20190702152908.fwwf7smt7nh2lxo2@flea>
References: <20190523204823.mx7l4ozklzdh7npn@flea>
 <CAMty3ZA0S=+8NBrQZvP6sFdzSYWqhNZL_KjkJAQ0jTc2RVivrw@mail.gmail.com>
 <20190604143016.fcx3ezmga244xakp@flea>
 <CAMty3ZAAK4RoE6g_LAZ-Q38On_1s_TTOz65YG7PVd88mwp-+4Q@mail.gmail.com>
 <20190613131626.7zbwvrvd4e7eafrc@flea>
 <CAMty3ZBDkMJkZm8FudNB1wQ+L-q3XVKa3zR2M0wZ5Uncdy_Ayg@mail.gmail.com>
 <20190624130442.ww4l3zctykr4i2e2@flea>
 <CAMty3ZB+eZUh5mr-LMZuEd_wrwLCN0mbf7arcRQHj8=uUNNq=Q@mail.gmail.com>
 <20190625143747.3czd7sit4waz75b6@flea>
 <CAMty3ZCh+C9+zgcL633tTw6aPW_WOLnYN7FzJHX+3zu8=8Unpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZCh+C9+zgcL633tTw6aPW_WOLnYN7FzJHX+3zu8=8Unpg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 12:30:14AM +0530, Jagan Teki wrote:
> On Tue, Jun 25, 2019 at 8:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > > > BSP has tcon_div and dsi_div. dsi_div is dynamic which depends on
> > > > > > > > > bpp/lanes and it indeed depends on PLL computation (not tcon_div),
> > > > > > > > > anyway I have explained again on this initial link you mentioned.
> > > > > > > > > Please have a look and get back.
> > > > > > > >
> > > > > > > > I'll have a look, thanks.
> > > > > > > >
> > > > > > > > I've given your patches a try on my setup though, and this patch
> > > > > > > > breaks it with vblank timeouts and some horizontal lines that looks
> > > > > > > > like what should be displayed, but blinking and on the right of the
> > > > > > > > display. The previous ones are fine though.
> > > > > > >
> > > > > > > Would you please send me the link of panel driver.
> > > > > >
> > > > > > It's drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> > > > >
> > > > > Look like this panel work even w/o any vendor sequence. it's similar
> > > > > to the 4-lane panel I have with RGB888, so the dclk div is 6, is it
> > > > > working with this divider?
> > > >
> > > > It works with 4, it doesn't work with 6.
> > >
> > > Can be the pixel clock with associated timings can make this diff.
> > > Would you send me the pixel clock, pll_rate and timings this panel
> > > used it from BSP?
> >
> > This board never had an Allwinner BSP
>
> Running on BSP would help to understand some clue, anyway would you
> send me the the value PLL_MIPI register (devme 0x1c20040) on this
> board. I'm trying to understand how it value in your case.

I'm sorry, but I'm not going to port a whole BSP on that board,
especially for something I haven't been convinced it's the right fix.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
