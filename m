Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C97C8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfGaQkS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 Jul 2019 12:40:18 -0400
Received: from mailoutvs30.siol.net ([185.57.226.221]:34957 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729842AbfGaQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:40:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 7B0A05209AE;
        Wed, 31 Jul 2019 18:40:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fXh7Bj71aPKg; Wed, 31 Jul 2019 18:40:08 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 84F755233C1;
        Wed, 31 Jul 2019 18:40:07 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 488405209AE;
        Wed, 31 Jul 2019 18:40:04 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
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
Subject: Re: [PATCH 3/3] drm/bridge: Add NWL MIPI DSI host controller support
Date:   Wed, 31 Jul 2019 18:40:03 +0200
Message-ID: <13373313.BzCyiC4ED7@jernej-laptop>
In-Reply-To: <CAOMZO5Djoi7EuXapkg+dQ6HR2oZZHrw+vnjc837Gxee-Nh00Hw@mail.gmail.com>
References: <cover.1563983037.git.agx@sigxcpu.org> <20190731143532.GA1935@bogon.m.sigxcpu.org> <CAOMZO5Djoi7EuXapkg+dQ6HR2oZZHrw+vnjc837Gxee-Nh00Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 31. julij 2019 ob 16:43:47 CEST je Fabio Estevam napisal(a):
> Hi Guido,
> 
> On Wed, Jul 31, 2019 at 11:35 AM Guido G�nther <agx@sigxcpu.org> wrote:
> > The idea is to have
> > 
> >     "%sabling platform clocks", enable ? "en" : "dis");
> > 
> > depending whether clocks are enabled/disabled.
> 
> Yes, I understood the idea, but this would print:
> 
> ensabling or dissabling :-)

No, it wouldn't. That extra "s" is part of "%s", e.g. part of format specifier.

Best regards,
Jernej

> 
> > > Same here. Please return 'int' instead.
> > 
> > This is from drm_bridge_funcs so the prototype is fixed. I'm not sure
> > how what's the best way to bubble up fatal errors through the drm layer?
> 
> Ok, so let's not change this one.
> 
> > I went for DRM_DEV_ERROR() since that what i used in the rest of the
> > driver and these ones were omission. Hope that's o.k.
> 
> No strong preferences here. I just think dev_err() easier to type and
> shorter.
> 
> Thanks for this work!




