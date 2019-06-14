Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FD45930
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 11:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfFNJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 05:48:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41544 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFNJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:48:53 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so4352479ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKw06+cNAvnizMFXa6QBpBJf1TOMKPxvPHOwkRTL9lg=;
        b=m2bzfO0vhzMnm6b4HKMSrNLfXIxCD14mTpXJsFvetKma+4zeeuN9k1Fn0wvtLtAfdt
         A94XWPxYmdr+edE0d/FZvljp+KD8syJfo3i46TyfWe3guYAgjUIl7E4G1PtvUQ2GIPGe
         Hni79nNR+YpRjp+XNO8oO4sjIeI8Nqpx+7eyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKw06+cNAvnizMFXa6QBpBJf1TOMKPxvPHOwkRTL9lg=;
        b=fNNRpQ7DAy8yJiPRUbLsquwxlvJhxb5WTEZ7BcTerIJug/4bi4bvKYzs7qHQKgEq7F
         BmioAHSoktkyHv9kVTovqupptho1D3N+cccCa+u8zuow0DOoLBpCR1fzWx5yYJHBfhEC
         jEg4CTO1K537O9sR+D8ppM7WCMqPb6PaMl+SuufTubfMgzIZELYKfj03RL3Iq4LJFCUt
         XzmUngBVe3kcjlbblv5SWH0758R0IbBziNgP4JxOhoqcmcT99OjM+kPEXrURgN7uD9QX
         TwSmFjjRhx+d09vCPD7pD1DXnJEP5/4Oe/XZl6vE/4zLtlI/ZhJ9G3wTxqlTEE9eWx9Y
         AvVg==
X-Gm-Message-State: APjAAAVP5svXhD500Foh7u7Psf9bl6MFR1v88MWioQj03hgPmQyLUkBK
        GCmQWu0T4Wig8rE5mOSw5k/blVFZMKwwl5hELubD1zgpQsg=
X-Google-Smtp-Source: APXvYqxH56vd8m0NL3s5K4g0SpMN6wIAo9CZa8erGisPkMwTglnDa7HWnaXEv9xSFHKy++9LqWSZcGfIftWfjL7A74M=
X-Received: by 2002:a05:6602:2253:: with SMTP id o19mr14187412ioo.297.1560505732488;
 Fri, 14 Jun 2019 02:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
 <20190613185241.22800-6-jagan@amarulasolutions.com> <CAGb2v654p=HZuXCTJkrbWbFP_kEkpRWHwj-7_Ck_=XbyMFmvFw@mail.gmail.com>
In-Reply-To: <CAGb2v654p=HZuXCTJkrbWbFP_kEkpRWHwj-7_Ck_=XbyMFmvFw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 14 Jun 2019 15:18:40 +0530
Message-ID: <CAMty3ZD0atS2uWJmPB-n1wmy324JEpwt42=_wpKeF-8uxM-GbQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] ARM: dts: sun8i: r40: Add TCON TOP LCD clocking
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 9:16 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Jun 14, 2019 at 2:54 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > According to Fig 7-2. TCON Top Block Diagram in User manual.
> >
> > TCON TOP can have an hierarchy for TCON_LCD0, LCD1 like
> > TCON_TV0, TV1 so, the tcon top would handle the clocks of
> > TCON_LCD0, LCD1 similar like TV0, TV1.
>
> That is not guaranteed. The diagram shows the pixel data path,
> not necessarily the clocks. In addition, the LCD TCONs have an
> internal clock gate for the dot-clock output, which the TV variants
> do not. That might explain the need for the gates in TCON TOP.

Correct, the actual idea about explanation here is to mention the
clocks definition in tcon top level and internal tv and lcd can handle
as you explained.

>
> > But, the current tcon_top node is using dsi clock name with
> > CLK_DSI_DPHY which is ideally handle via dphy which indeed
> > a separate interface block.
> >
> > So, use tcon-lcd0 instead of dsi which would refer the
> > CLK_TCON_LCD0 similar like CLK_TCON_TV0 with tcon-tv0.
> >
> > This way we can refer CLK_TCON_LCD0 from tcon_top clock in
> > tcon_lcd0 node and the actual DSI_DPHY clock node would
> > refer in dphy node.
>
> That doesn't make sense. What about TCON_LCD1?
>
> The CCU already has CLK_TCON_LCD0 and CLK_TCON_LCD1. What makes
> you think that the TCONs don't use them directly?
>
> Or maybe they do go through TCON_TOP, but there's no gate,
> so we don't know about it.
>
> You need to rethink this. What are you trying to deal with?

Yes, I understand what your asking for and indeed this is where I get
confused and tried this way initially and attach the dsi reference in
dphy something like

tcon_lcd0 {
                clocks = <&ccu CLK_BUS_TCON_LCD0>, <&ccu CLK_TCON_LCD0>;
                clock-names = "ahb", "tcon-ch0";
};

dphy {
               clocks = <&ccu CLK_BUS_MIPI_DSI>,
                              <&tcon_top CLK_TCON_TOP_DSI>;
               clock-names = "bus", "mod";
};

This would ended-up, phy wont getting the mod clock keep probing for
-EPROBE-DEFER since tcon top driver might not be loaded at the time
mipi driver. This way we have tv0, tv1 and dsi gates supported as
existed. Does it make sense?
