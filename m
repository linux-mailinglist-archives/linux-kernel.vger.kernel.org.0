Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06F332AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfFCIjX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jun 2019 04:39:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44630 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:39:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so12896610lfm.11;
        Mon, 03 Jun 2019 01:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TWvaDqv8T+3nSnhW96l6kR7tta+6ilsMfM4h26eVB0A=;
        b=ngJIb8rR0CVkrU3y1S1sh+mFnFBQkKJ5o4MM7UE6i0Fel7i+p7FqhlRk34q9+lYVXF
         1aweaf/bIuCiNwohCC14fg/+ZtTXutrfCb5L91qKRf4P3qAplLt5UOL2SlAk0rAeXUZR
         OhAV6Z72i4oYL2YSN6GI+43jdg0oeuX6K0g3GQzUt4xi8qBugi6ogOeUDAFxq7q3/hdQ
         vL21jw91gh5ZgLSRFctq/cyyfnztJrmVMMAm7lCherXWE4/+UPGKPFs5HnxZDNfecTkm
         4NQlpR5P1eYCVF7Pe2pbMc9yp0B2EsozcCUcn/i3rgoaZ56P+FyonrbcOQZbQvZSYSia
         CRjw==
X-Gm-Message-State: APjAAAWQDWr4BWokZmY95bof7f9L9toTvvOG2O0Hn/zCsujx2czMjkJG
        gORpQVxmh1sZ8AYCFyRgq51djuVk0siNwo7QjgQ=
X-Google-Smtp-Source: APXvYqyXL8w6cO+p1/AqPPxJsRM7EMbyvZE5iVOyx5i9Q6tpF80hkDon+evxwhRB18XKOnAOCAASGOsw2s8ExRWUo2M=
X-Received: by 2002:a19:c142:: with SMTP id r63mr13997915lff.49.1559551160938;
 Mon, 03 Jun 2019 01:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <1558711904-27278-1-git-send-email-gareth.williams.jx@renesas.com>
 <1558711904-27278-2-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdV2jmY2u1-Z6cRR1OQcfW8U0HM_ac-xn1gO9nPf41iD+A@mail.gmail.com> <TY1PR01MB1769FB150E0258A8AC76CDB5F5140@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769FB150E0258A8AC76CDB5F5140@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jun 2019 10:39:08 +0200
Message-ID: <CAMuHMdXiBz6L83sBHXOg=zc0zo4ff37SbLOZc5NwgiTLVG-nTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Document power Domains
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Mon, Jun 3, 2019 at 10:29 AM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 28 May 2019 08:29 Geert Uytterhoeven wrote:
> > On Fri, May 24, 2019 at 5:32 PM Gareth Williams wrote:
> > > The driver is gaining power domain support, so add the new property to
> > > the DT binding and update the examples.
> > >
> > > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>

> > > ---
> > > a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
> > > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
> > @@ -40,4 +42,5 @@ Examples
> > >                 reg-io-width = <4>;
> > >                 clocks = <&sysctrl R9A06G032_CLK_UART0>;
> > >                 clock-names = "baudclk";
> > > +               power-domains = <&sysctrl>;
> >
> > This is an interesting example: according to the driver,
> > R9A06G032_CLK_UART0, is not clock used for power management?
> >
> > Oh, the real uart0 node in arch/arm/boot/dts/r9a06g032.dtsi uses
> >
> >     clocks = <&sysctrl R9A06G032_CLK_UART0>, <&sysctrl
> > R9A06G032_HCLK_UART0>;
> >     clock-names = "baudclk", "apb_pclk";
> >
> > That does make sense...
> Note that the Synopsys DW uart driver already gets the "apb_pclk" clock, so
> we don’t actually need to use clock domains to enable this clock.

That is not necessarily a problem:
  1) DT describes hardware, not software policy,
  2) It doesn't hurt to enable a clock twice.

There are still some R-Car drivers that manage clocks themselves, but
we're slowly migrating away from that, where possible. If the driver
is e.g. shared with a platform without clock domains, we obviously cannot
do that.

So you can take out that code again, that's up to you.

> This is also true for many of the peripheral drivers used on rzn1 (Synopsys
> gpio controller, i2c controller, gmac, dmac, Arasan sdio controller). The
> commit to add this clock to the i2c controller driver is my fault, as I was
> following the pattern of the others.
>
> Of the few drivers that don't already get the hclk/pclk used to access the
> peripherals is the Synopsys spi controller (though that currently doesn’t
> support runtime PM) and the USB Host controller.

Good, so the latter will start working magically, I assume? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
