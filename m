Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF4E7C65
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 23:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfJ1WeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 18:34:13 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39520 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfJ1WeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:34:13 -0400
Received: by mail-il1-f195.google.com with SMTP id i12so9630444ils.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2XX2oa9okl2tfpust4RUifahZHp7tb1+MoPm2u47Wc=;
        b=n4p86JogluIaUwX8lpVfKCl315ggHShPT/3PG9nmdvv6A+WmkcxoXlJ1p500UHclpZ
         V7orIaazLLn5Miq8ZaNeWiihu1+79cg9oAg+i/LcaIdcqZQ5iG4T4aVCMjo26c+Cdn97
         r3IOx7w0Y6kNlL3cRfnacuWuUmSw1xh6YKtgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2XX2oa9okl2tfpust4RUifahZHp7tb1+MoPm2u47Wc=;
        b=qBdp7l5A3nLfDOe9x+znBNS+Q8V1vTjkg5OOYkfRLRych3kMDdZh3ODeFUf5vTFFk6
         gL3+BtHtGK7vlkfgPjMPZC1DWxt2BG26A5lyemoLzE350DUdIQCwXijhHcIKkAOq4vuH
         zaSrB1KVm7IoqnC64pKHl3qxP6yBtqXkEccK/y1YXG8Iv9F34JY/owCwol8ueuCSLatz
         zqqfO5aCKopgKGo3BdI+pA2FHpIYnDbbXbvzxXo5z7RBc4P2yhTtVOlo5ZPntVU93IBj
         MC6DmOh00zSED9dKIMMFTISUQcDiZWL1VrjaWFGNQjb9RSkQxA1+619DajIRKOEkYRpp
         78zQ==
X-Gm-Message-State: APjAAAUJkiKrFYmmoaW51xI9P1jVGTYyKhefgrdZsBK+snwr0xRkfksy
        Ci07Ok+a2I9K/zTB30Wiwuq1a9rZ494zG2z4/QXO6Q==
X-Google-Smtp-Source: APXvYqyCGJQl+HAm+sa8mYYJp4Wxr/m+y+g/6ntOZCrMubS4XyZUczCAk4EdzfbP8O6fyXYOHmttxwz3zGzyvqk0tc0=
X-Received: by 2002:a92:99ca:: with SMTP id t71mr8413794ilk.61.1572302047950;
 Mon, 28 Oct 2019 15:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-5-jagan@amarulasolutions.com> <20191028153427.pc3tnoz2d23filhx@hendrix>
In-Reply-To: <20191028153427.pc3tnoz2d23filhx@hendrix>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 29 Oct 2019 04:03:56 +0530
Message-ID: <CAMty3ZCisTrFGjzHyqSofqFAsKSLV1n2xP5Li3Lonhdi0WUZVA@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] drm/sun4i: dsi: Handle bus clock explicitly 
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, Oct 28, 2019 at 9:06 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Fri, Oct 25, 2019 at 11:26:22PM +0530, Jagan Teki wrote:
> > Usage of clocks are varies between different Allwinner
> > DSI controllers. Clocking in A33 would need bus and
> > mod clocks where as A64 would need only bus clock.
> >
> > To support this kind of clocking structure variants
> > in the same dsi driver,
>
> There's no variance in the clock structure as far as the bus clock is
> concerned.
>
> > explicit handling of common clock would require since the A64
> > doesn't need to mention the clock-names explicitly in dts since it
> > support only one bus clock.
> >
> > Also pass clk_id NULL instead "bus" to regmap clock init function
> > since the single clock variants no need to mention clock-names
> > explicitly.
>
> You don't need explicit clock handling. Passing NULL as the argument
> in regmap_init_mmio_clk will make it use the first clock, which is the
> bus clock.

Indeed I tried that, since NULL clk_id wouldn't enable the bus clock
during regmap_mmio_gen_context code, passing NULL triggering vblank
timeout.
