Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53AD35A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 12:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfFEKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 06:13:45 -0400
Received: from verein.lst.de ([213.95.11.211]:41960 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfFEKNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:13:44 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 5F8F468B05; Wed,  5 Jun 2019 12:13:17 +0200 (CEST)
Date:   Wed, 5 Jun 2019 12:13:17 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345
 bridge on Teres-I
Message-ID: <20190605101317.GA9345@lst.de>
References: <20190604122150.29D6468B05@newverein.lst.de> <20190604122308.98D4868B20@newverein.lst.de> <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 08:08:40AM -0700, Vasily Khoruzhick wrote:
> On Tue, Jun 4, 2019 at 5:23 AM Torsten Duwe <duwe@lst.de> wrote:
> >
> > Teres-I has an anx6345 bridge connected to the RGB666 LCD output, and
> > the I2C controlling signals are connected to I2C0 bus. eDP output goes
> > to an Innolux N116BGE panel.
> >
> > Enable it in the device tree.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > ---
> >  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 65 ++++++++++++++++++++--
> >  1 file changed, 61 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > index 0ec46b969a75..a0ad438b037f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > @@ -65,6 +65,21 @@
> >                 };
> >         };
> >
> > +       panel: panel {
> > +               compatible ="innolux,n116bge", "simple-panel";
> 
> It's still "simple-panel". I believe I already mentioned that Rob
> asked it to be edp-connector.
> 
For which there are neither bindings nor drivers.

Is anybody seriously proposing to hold back support for existing
(open source!) hardware in favour of an *imaginable* *possibly* better
solution? Especially when this exact line is already used in some other places?
(there's a space missing btw...)

I'm more than glad to follow any constructive improvements towards better
modularity. However there were none so far, and on top of that, it's a laptop.
I see little advantage in mentioning an internal connector when the panel
connected is always the same.

FWIW, Rob should also have received these patches.

	Torsten

