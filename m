Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F881669F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 22:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgBTVh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 16:37:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45256 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:37:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id a2so5018870qko.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oh9NnMK5dEkxSL8LqLeezQXMtkg2eo9bP7+6KDERK7c=;
        b=dkZ+fmKTL4NxfsQL//wkNrqdn+7ALxc9PWB4/cJdjaMYai6+a2ObaTrZTi3QiRCL0V
         TMTIpnezZMnaC9KNCUXgF5o59tmklGM0vyhpkCSUldlOCdklJMYjN8kgqicn7b0H5uvR
         mRyrf9vU9fUmbYaeaIRealAwfliz91+76OSwSjZRyYEy8UDGoP0f0sy8JOKnLJPzFxbC
         rMegihWdjYtYGneebotaZntHloXNCy8nrj2aAhjn/yFq/gWFTTJg6TRppJoIn0GMcVsY
         NpvhM1m57XvH2otQn99m5FFoJbCjQ9wgnJAVRPPA+LBskBn1YeWZ4SpX//vhyZqwvvN3
         mFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oh9NnMK5dEkxSL8LqLeezQXMtkg2eo9bP7+6KDERK7c=;
        b=Ucv8Z4BpGv+ttYF9/GjbfHKaXWT37HJuAfEJlYliNxfcTyMgJdcQkXQ2iIW4G809W5
         q5qHaY/gk0GC3IX5UlS/uc7p0LikVeK/Eva1DQ0nUHRiLT6DKNkk+fe4AmW5oIsfCGJL
         +1SgM3tMZjw+AqEu8JC0gxiCE65Gh02yv41bQpch0FQ06QTJfVX22eyJ2U36EXrOoopY
         makR/DLj4KmIJrGPgBGoqC8f/fUvh7jmGp3r25QGDifS+WH4qlyuP/psjHc551p1IjKy
         dazRQj9Qlr3nsX5DFsEKvWz/3FFQRYrQtYaoQiy5CJTSPkmzLajSyimIzU8wrRdycuip
         F1pA==
X-Gm-Message-State: APjAAAWkvx+zkEZlNCpm5ip6/4V6rJjTUoYuFnAjnf+Aqh+XSLvVIjLT
        WtvDsI1wZIFmFKMog2pl67Y0Ln0q+hH8Wk4jK9A=
X-Google-Smtp-Source: APXvYqxbMtUxwi5PqTgTmL0zS8fcAZIOH3LG0rqKdR9B+eNvxbGatS+IgDq4lagM0iirCc+ygm9t5HGOeR8kbKdfxTs=
X-Received: by 2002:a05:620a:1426:: with SMTP id k6mr30609606qkj.276.1582234645770;
 Thu, 20 Feb 2020 13:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20200220083508.792071-1-anarsoul@gmail.com> <20200220083508.792071-4-anarsoul@gmail.com>
 <20200220093528.GA10402@ravnborg.org>
In-Reply-To: <20200220093528.GA10402@ravnborg.org>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 20 Feb 2020 13:37:12 -0800
Message-ID: <CA+E=qVf2eGddyBd7G5+W0cScLSQF3qmPgw-ja_F=4LeEMeLn5Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: Add Guangdong Neweast Optoelectronics
 CO. LTD vendor prefix
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 1:35 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Vasily
>
> On Thu, Feb 20, 2020 at 12:35:05AM -0800, Vasily Khoruzhick wrote:
> > Add vendor prefix for Guangdong Neweast Optoelectronics CO. LTD
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 6456a6dfd83d..a390a793422b 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -665,6 +665,8 @@ patternProperties:
> >      description: Nexbox
> >    "^nextthing,.*":
> >      description: Next Thing Co.
> > +  "^neweast,.*":
> > +    description: Guangdong Neweast Optoelectronics CO., LT
>
> Alphabetical order.
> "new" comes before "nex".

Will fix in v2

>
>         Sam
