Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6DF0656
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfKETxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 14:53:36 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45194 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKETxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:53:35 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E3F9559;
        Tue,  5 Nov 2019 20:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1572983614;
        bh=fcuygVB2SplZS3Dkx3i6Moc1rRXaeuVQvASKaqu5weI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSiClPhOy6tIRIGYDNTwVfLRgW7hCJ0UlYOb3cMGsCef0GXSd+CDkKf32Ia/rS9t0
         dahaFXWD+U+haYq/otzMkkenbLXXcnTkp2CCICtnxKPuu7dq3prkt0krg6hPaBWAwr
         /pFGt+CwP2k98+RuJZ7vLm3QfEoJTrBrmhlaTMfI=
Date:   Tue, 5 Nov 2019 21:53:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using
 fwnode_gpiod_get_index()
Message-ID: <20191105195323.GC4869@pendragon.ideasonboard.com>
References: <20191014184320.GA161094@dtor-ws>
 <20191105004050.GU57214@dtor-ws>
 <CACRpkdak-gW9+OV-SZQVNNi5BuyNzkjkKvHmYp2+eYq4vu2nyg@mail.gmail.com>
 <CAKMK7uG7FQ3bDWsTxq0n8Osh7jjws5ia3PFJXvDdo=nxKu7+Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKMK7uG7FQ3bDWsTxq0n8Osh7jjws5ia3PFJXvDdo=nxKu7+Ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Nov 05, 2019 at 04:41:41PM +0100, Daniel Vetter wrote:
> On Tue, Nov 5, 2019 at 4:29 PM Linus Walleij wrote:
> > On Tue, Nov 5, 2019 at 1:40 AM Dmitry Torokhov wrote:
> > > On Mon, Oct 14, 2019 at 11:43:20AM -0700, Dmitry Torokhov wrote:
> >
> > > > Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
> > > > the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
> > > > works with arbitrary firmware node.
> > > >
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >
> > > > Andrzej, Neil,
> > > >
> > > > This depends on the new code that can be bound in
> > > > ib-fwnode-gpiod-get-index immutable branch of Linus' Walleij tree:
> > > >
> > > >         git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git ib-fwnode-gpiod-get-index
> > > >
> > > > I hope that it would be possible to pull in this immutable branch and
> > > > not wait until after 5.5 merge window, or, alternatively, merge through
> > > > Linus Walleij's tree.
> > >
> > > Any chance this could be merged, please?
> >
> > I'm happy to merge it into the GPIO tree if some DRM maintainer can
> > provide an ACK.
> 
> Ack.
> 
> > Getting ACK from DRM people is problematic and a bit of friction in the
> > community, DVetter usually advice to seek mutual reviews etc, but IMO
> > it would be better if some people felt more compelled to review stuff
> > eventually. (And that has the problem that it doesn't scale.)
> 
> This has a review already plus if you merge your implied review.
> That's more than good enough imo, so not seeing the issue here?

Isn't the issue that the patch should have been picked by someone for
drm-misc ?

-- 
Regards,

Laurent Pinchart
