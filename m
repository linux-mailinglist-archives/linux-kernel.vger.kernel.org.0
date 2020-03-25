Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEF19213A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 07:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 02:37:17 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38362 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCYGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 02:37:16 -0400
Received: by mail-vk1-f193.google.com with SMTP id n128so380989vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jSH6IwIzcHxO1dEAdKynoMSu3DuDL5sjpp02Uv2TK0=;
        b=jDm+gCbrABJRyKRkp6gI9YwPYuCeyHlXluAEXOh4yEMKoB+Tdx9T0+7noW1hpUNKzZ
         Kx/ZghXAAOW1qwMTlbHcf7Cig7EJ1MkmptqzUsnzhGfuytVbR6W5/tZy0c9w68S09hEb
         GoXhEGlfEndrcxqymIz5E4AK/TERQhQBmuoYIdgtF2ZaqtXRhVe8H86H7NSD7Jjg04nA
         STKax034sKWZzH1CevSpC8khjbcZcVVxIAJfS5r9pkeDk5lT61cLr+mNuU+KGm22qLTf
         YAMJokPA29sN9sDPIx7mSxT1/xoMMrPUqC9d3wBKZ8Siulb2zK8uHy0mqdOxj8FTcBaV
         P+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jSH6IwIzcHxO1dEAdKynoMSu3DuDL5sjpp02Uv2TK0=;
        b=OvlnwC+GcPJ2CBDXEfqZwVWZu6z4qU65lfZphuDzAtKXL3+F06L8ABkFaCYbAoS+qK
         j1eOhhxcFKIaibaDPNuXCyq9bcTFPXTMqEokRWaz61+SpoXFema3uTv9SAEI57PMfBhJ
         P5yUtszxhZTsqGJn4ch/j+QK7fBXHg61yM+O1mmvm+0SvPd7rdynCWAJpyE8GJh5x2ww
         4UXbqN7ukbjQdFEHO5n0MPiqjmd8qC+fT2HehiMAhvNb9wGOYPaYe2ICZ8VpCwBri0dY
         UFjjecn00yuCnHbm0bEKjvSkrpkSIJtEZ3ywPnIq18PpveYn8zytoKpXjPJouwe8hjaR
         yNBg==
X-Gm-Message-State: ANhLgQ0j41Pd028XI7SFhr5xPNSclsobfJ7td7MykO8Pxl+Wr/2fXRP0
        85Az+kJkL6tb/RPAa/a3GDt1AVZjpK1r1gxo+4nPXw==
X-Google-Smtp-Source: ADFU+vsYq8yJ59LPZqkr3eoifR7LDoo0CMncce0p+aNIhNSb+G7C4aTfiUP1oZ5YrcCWtKdvlXN7vBWm52sQhYicOGo=
X-Received: by 2002:a1f:ee05:: with SMTP id m5mr1056922vkh.9.1585118235539;
 Tue, 24 Mar 2020 23:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200309045411.21859-1-andy.tang@nxp.com> <18c58e1b-583c-2308-ee60-a8923c2027ee@linaro.org>
 <CAHLCerPBxe=Az=EexxYQkgvhRO40JT0qEhnAwqnGbeesiU-bnQ@mail.gmail.com>
In-Reply-To: <CAHLCerPBxe=Az=EexxYQkgvhRO40JT0qEhnAwqnGbeesiU-bnQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 25 Mar 2020 12:07:04 +0530
Message-ID: <CAHLCerN6ccJ7zbj9uYKGp-b05q1o7HsaUyW_oTZmEJX1EWXWQQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: make cooling-maps property optional
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Yuantian Tang <andy.tang@nxp.com>, Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 9:43 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Mon, Mar 16, 2020 at 8:22 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 09/03/2020 05:54, andy.tang@nxp.com wrote:
> > > From: Yuantian Tang <andy.tang@nxp.com>
> > >
> > > Cooling-maps doesn't have to be a required property because there may
> > > be no cooling device on system, or there are no enough cooling devices for
> > > each thermal zone in multiple thermal zone cases since cooling devices
> > > can't be shared.
> > > So make this property optional to remove such limitations.
> > >
> > > For thermal zones with no cooling-maps, there could be critic trips
> > > that can trigger CPU reset or shutdown. So they still can take actions.
> > >
> > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> >
> > Amit, I'm about to pick this patch, it will collide with the yaml
> > conversion changes.
>
> Thanks for the headsup. I can fixup v3 when I respin.
>
> However, I've always interpreted this binding as follows:
> - cooling-maps should be mandatory for active and passive trip types
> otherwise there will be no cooling
> - cooling-maps make no sense for critical trip type since we're
> invoking system shutdown
> - cooling-maps are optional for hot trip types.
>
> Is this your understanding too?
>
> We should be able to enforce this in YAML.

Rui, Daniel,

What do you think about the above interpretation of the cooling-maps bindings?

Regards,
Amit
