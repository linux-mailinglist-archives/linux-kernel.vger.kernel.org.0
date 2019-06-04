Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB98634C45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfFDPbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 11:31:22 -0400
Received: from vps.xff.cz ([195.181.215.36]:35940 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfFDPbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1559662280; bh=EgCgHGDKwboiv0UTlsIJuwh5ONrmLYgSafz06T59WVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiaHoyT1bOO4eDbEJwSmZxhlVlH/Q9XrhCS1R3LZitSO1roMFHNNsrSUmmyXIs5si
         mst7ZKRw9TbIdERakMAJEUE1Peemsz5RJfrruG9pBwtEDQiAoy1qrF9MIwUIdizIKN
         3bdXmfqHi0FEdEmQ6XLHljKyVzUifByzAHuLYUxg=
Date:   Tue, 4 Jun 2019 17:31:20 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: sun50i-h6-r: Fix incorrect
 W1 clock gate register
Message-ID: <20190604153120.zcxfn4kh2qjfktgo@core.my.home>
Mail-Followup-To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>
References: <20190604150054.17683-1-megous@megous.com>
 <20522585.shqbOC0eQD@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20522585.shqbOC0eQD@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Tue, Jun 04, 2019 at 05:03:55PM +0200, Jernej Škrabec wrote:
> Dne torek, 04. junij 2019 ob 17:00:54 CEST je megous via linux-sunxi 
> napisal(a):
> > From: Ondrej Jirman <megous@megous.com>
> > 
> > The current code defines W1 clock gate to be at 0x1cc, overlaying it
> > with the IR gate.
> > 
> > Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR receiver
> > causing interrupt floods on H6 (because interrupt flags can't be cleared,
> > due to IR module's bus being disabled).
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> You should add Fixes tag and CC stable with this.

Not necessary, since H6 IR is not yet supported on mainline.

regards,
	o.

> Best regards,
> Jernej
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
