Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD466165
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 23:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfGKVxE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Jul 2019 17:53:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36472 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfGKVxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:53:03 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hlgzr-0006th-0q; Thu, 11 Jul 2019 23:52:59 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/7] ARM: dts: rockchip: Specify rk3288-veyron-chromebook's display timings
Date:   Thu, 11 Jul 2019 23:52:58 +0200
Message-ID: <3703486.dL69t9P4Cl@diego>
In-Reply-To: <4744731.Gbjux09qzx@diego>
References: <20190401171724.215780-1-dianders@chromium.org> <20190401171724.215780-7-dianders@chromium.org> <4744731.Gbjux09qzx@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. Juli 2019, 23:27:44 CEST schrieb Heiko St�bner:
> Am Montag, 1. April 2019, 19:17:23 CEST schrieb Douglas Anderson:
> > Let's document the display timings that most veyron chromebooks (like
> > jaq, jerry, mighty, speedy) have been using out in the field.  This
> > uses the standard blankings but a slightly slower clock rate, thus
> > getting a refresh rate 58.3 Hz.
> > 
> > NOTE: this won't really do anything except cause DRM to properly
> > report the refresh rate since vop_crtc_mode_fixup() was rounding the
> > pixel clock to 74.25 MHz anyway.  Apparently the adjusted rate isn't
> > exposed to userspace so it's important that the rate we're trying to
> > achieve is mostly right.
> > 
> > For the downstream kernel change related to this see See
> > https://crrev.com/c/324558.
> > 
> > NOTE: minnie uses a different panel will be fixed up in a future
> > patch, so for now we'll just delete the panel timings there.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> applied for 5.3

5.4 obviously
[just to not confuse people reading that later]


