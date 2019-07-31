Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F507CAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGaRks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:40:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44552 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaRks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:40:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so66430600ljc.11;
        Wed, 31 Jul 2019 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q4EnWjuoFwvcg+PQNQKDl7SJ3NRTDjvZysMShIcjoKI=;
        b=EEGiqtvzdTGgq8ThRpTRzSRRTP6VrSrlPO4IYYXSqpYLJ1pWHT/smy+zbIF9spBxdG
         OPhZlUiy86fYmMqsbJ+fR75XB09QgUuke4Bs8aa9PYGkrTqbahFJVfjl93nk0Q3ff36o
         4CNAKmIBe5E32PDAW7yKpvLxNuV1lPeTQUHA7iJHMdqmLX+3nLVkm0utsFCM5H/+5JXa
         cBmKEid218rblPtIjLKPhBu5EWKqEkzkwF5vunTY0SixI56msLOoXv2XPukyyoSH7Ve0
         1euc7zpXBnh6gBCuZ/uLrqxkrgPUuqlZAXL7Q36Q29fJ3is4HY3M9XrjfIGJL1jp8j8S
         2l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q4EnWjuoFwvcg+PQNQKDl7SJ3NRTDjvZysMShIcjoKI=;
        b=lHI7WHibR0009/4BWqf3s/zWvZdTBUAcanS6bTBr471xcc4fsxCfk+6ooKZg4/oWv+
         EgJmABvk7vsY+dOsIUYydSFnq2ALeb5uk2wM+wFvUH7/ALYUH8fvtcWkDoXgRyel1Mja
         jtdxiR8/29/n12VIpGFWrdbXiwW8Vynq31chPnKKJ9/RN8EeqEYCovLN1/QeyB0aep8S
         9e9OF04d9m7bvaqtDOKV1GeFgeA/vRIbUNfnfynlqsB7qIAi8hdYaVNntBvNZ3pz0IBb
         eCN31MXUth4FPrZvEOQB0vAqulbHOkC6mWI2WpMKGxux6DDYx2G2z6P5JY4kZi52EIBt
         Fl4w==
X-Gm-Message-State: APjAAAWdlzrVSvUfh1KHaqGkuSL2l8mRasuBuby/Gbu94TOGmdmZuMk5
        OiRh40Lx5bA2DKJ8A9D5RsTKfTgN6RrcnQYhWsQ=
X-Google-Smtp-Source: APXvYqyt0Od36zT0596GjCdSHptbQnUWvWqMyOnVl/5FQep+ssyLLf+KxKKOId+xoiOrQ+OT9NTjMGldgO9EObJPhWk=
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr14933002ljb.211.1564594845880;
 Wed, 31 Jul 2019 10:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563983037.git.agx@sigxcpu.org> <20190731143532.GA1935@bogon.m.sigxcpu.org>
 <CAOMZO5Djoi7EuXapkg+dQ6HR2oZZHrw+vnjc837Gxee-Nh00Hw@mail.gmail.com> <13373313.BzCyiC4ED7@jernej-laptop>
In-Reply-To: <13373313.BzCyiC4ED7@jernej-laptop>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Jul 2019 14:40:57 -0300
Message-ID: <CAOMZO5Ak7QFzEM8Qt5XAZBa1CB602fygK+FBDK2iTvxWA4y+oA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/bridge: Add NWL MIPI DSI host controller support
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Lee Jones <lee.jones@linaro.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 1:40 PM Jernej =C5=A0krabec <jernej.skrabec@siol.ne=
t> wrote:

> > Yes, I understood the idea, but this would print:
> >
> > ensabling or dissabling :-)
>
> No, it wouldn't. That extra "s" is part of "%s", e.g. part of format spec=
ifier.

Ops, you are right. Sorry about that!
