Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70FFB1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKMNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 08:52:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34004 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfKMNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:52:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so2680754ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyCaCCfWBOINbn7kh6i3qJOp8XPmOM9fa7QHBkh+4VE=;
        b=Ci1YJZmdB2Q2xO8P8ZdU5WgniMH8a5hnf6ZkAVx0eSPqbbK8FstfQDpuqQ0TJKycDs
         okSgKVUg3ewqFjrcMTQuSYl76f6x/dN8tN3p+yaahJUVQJJVbWXpJfyAROrp4gUHpzFw
         +CTTjEoPH03lrRSQ0AGkkREZcJRujo3J/rAVvbxSthO86QPxgD4Xb6MpHpfIpgvZ3sI7
         QZiKWqyV1ywUW03vvgfqW9jbrkq+KPVKB5A0fIV0sscO1/2DmCOeu+s8i+0QvkwQCeZb
         A5/zJpnugkJApnSwXPfRdoafoFYl80x17d+cI84FcN0CSeipZVo6saESTHnAlml8/Yl9
         MESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyCaCCfWBOINbn7kh6i3qJOp8XPmOM9fa7QHBkh+4VE=;
        b=glQCAvihg3qvol/hBYG96grdH5krZdYKBdLALpJzf6V+NKIwk0DY3ofLjMoSuzqP6A
         1cOMaepfr6t+YiJEmvbxntUnnEUHIvmoe34XhCJ6yZryDk/IwqZZHXg+igCPN3XVqrrc
         gonfHwufUKzyBqUgoJOB/+dn7Ytf3qfyAEH4cA/3IiIO7MyP1shxy3sTZlJYsdHZjS40
         iCSTq9vaVezQLc8GUWTUsfk+BantyDQnggx4OwY60I7J7HQ2ZCPiWC0jllGn2+Pi+Hcl
         Tdl+ChUHRBmBDxea4BlgkZsrKCzeB7BBwMMp1ss5eakU+McwHUfQArbfCWfXFDy3579V
         gS/Q==
X-Gm-Message-State: APjAAAXxVCqmNgn3vfeXA62Ta3ATyt3sFEL0abwgGULYbECaM93zkjTg
        V+Fl6HrcsCHm/d/QMFnVRFuSFjjue8Lv/f+NxzNnuw==
X-Google-Smtp-Source: APXvYqwW5jWVJFHvPatvx+5Uafl6Y4kdh7Hv2nQ1whBv+PrGGl3XmyfhiAZkbrBJslMf1I6D0AFeGfskbMrj03akYJU=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr2798713lji.218.1573653154150;
 Wed, 13 Nov 2019 05:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20191014184320.GA161094@dtor-ws> <20191105004050.GU57214@dtor-ws>
 <CACRpkdak-gW9+OV-SZQVNNi5BuyNzkjkKvHmYp2+eYq4vu2nyg@mail.gmail.com> <CAKMK7uG7FQ3bDWsTxq0n8Osh7jjws5ia3PFJXvDdo=nxKu7+Ng@mail.gmail.com>
In-Reply-To: <CAKMK7uG7FQ3bDWsTxq0n8Osh7jjws5ia3PFJXvDdo=nxKu7+Ng@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 14:52:23 +0100
Message-ID: <CACRpkdYY_W8_L4---iMORt6vriUa9wKEi0d_kiMRbB_NQatRog@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using fwnode_gpiod_get_index()
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 4:41 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Nov 5, 2019 at 4:29 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Nov 5, 2019 at 1:40 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:

> > I'm happy to merge it into the GPIO tree if some DRM maintainer can
> > provide an ACK.
>
> Ack.

Thanks!

> > Getting ACK from DRM people is problematic and a bit of friction in the
> > community, DVetter usually advice to seek mutual reviews etc, but IMO
> > it would be better if some people felt more compelled to review stuff
> > eventually. (And that has the problem that it doesn't scale.)
>
> This has a review already plus if you merge your implied review.

Yeah I missed Laurent's review tag. I needed some kund of consent
to take it into the GPIO tree I suppose.

> That's more than good enough imo, so not seeing the issue here?

No issue.

What freaked me out was the option of having to pull in an
immutable branch from my GPIO tree into drm-misc. That would
have been scary. Keeping it all in my tree works fine.

Yours,
Linus Walleij
