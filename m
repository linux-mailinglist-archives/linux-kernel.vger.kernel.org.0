Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453D821525
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfEQIPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 04:15:13 -0400
Received: from verein.lst.de ([213.95.11.211]:36068 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfEQIPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:15:13 -0400
Received: by newverein.lst.de (Postfix, from userid 107)
        id 6C01068C4E; Fri, 17 May 2019 10:14:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on verein.lst.de
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_50
        autolearn=disabled version=3.3.1
Received: from blackhole.lan (p5B33F92B.dip0.t-ipconnect.de [91.51.249.43])
        by newverein.lst.de (Postfix) with ESMTPSA id DBFF067329;
        Fri, 17 May 2019 10:14:19 +0200 (CEST)
Date:   Fri, 17 May 2019 10:14:18 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190517101353.3e86d696@blackhole.lan>
In-Reply-To: <20190517072738.deohh5fly4jxms7k@flea>
References: <20190514155911.6C0AC68B05@newverein.lst.de>
        <20190514160241.9EAC768C7B@newverein.lst.de>
        <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
        <20190515093141.41016b11@blackhole.lan>
        <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
        <20190516154820.GA10431@lst.de>
        <CA+E=qVe5NkAvHXPvVc7iTbZn5sKeoRm0166zPW_s83c2gk7B+g@mail.gmail.com>
        <20190516164859.GB10431@lst.de>
        <20190517072738.deohh5fly4jxms7k@flea>
Organization: LST e.V.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 09:27:38 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Thu, May 16, 2019 at 06:48:59PM +0200, Torsten Duwe wrote:
> > On Thu, May 16, 2019 at 09:06:41AM -0700, Vasily Khoruzhick wrote:
> > >
> > > Driver can talk to the panel over AUX channel only after t1+t3,
> > > t1 is up to 10ms, t3 is up to 200ms.
> >
> > This is after power-on. The boot loader needs to deal with this.
> 
> The bootloader can deal with it, but the kernel will also need to. The
> bootloader might not be doing this because it's not been updated, the
> regulator might have been disabled between the time the kernel was
> started and the time the bridge driver probes, etc.

No, you cannot practically switch off this voltage. It supports _all_
the devices I mentioned. In fact, the PMIC needs to enable it initially,
and then it takes some time before the SoC can access the MMC and read
the SPL from it, just because of exactly these 3.3V. Then the boot
loader starts, and later the eDP bridge gets initialised.

In *theory*, albeit a very daring one, I could imagine a very deep
sleep mode that can only be ended by pressing the power button, which
should still work without DCDC1. Only then, a description of the panel
would be required. But I probably missed something and even this does
not work.

So for all current practical purposes, we can assume the Teres-I panel
to be powered properly and providing valid EDID; nothing to worry about
in software.

HTH,
	Torsten
