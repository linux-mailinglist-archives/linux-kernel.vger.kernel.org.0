Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2789AB93BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393331AbfITPLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 11:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390869AbfITPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:11:46 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5BE2086A;
        Fri, 20 Sep 2019 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568992305;
        bh=P03LHVKn6LA/jWFaOHU7Nv1MBzcqutnGsNgTkam26qY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=PUiMZ93OuJDn+LjWStwl90tsdFKa1BD/U+Q67U8KHQwJq05X/bx7xf7+D31/Nq6vi
         kRf3XANvqkoSmIpDlCXAF873HIniYr1RMJKwMlrGbiG7HfxFoGAsmbdoLKAuzWOiAr
         St+hu0yLlgkJEO9oiUHQiZ5c8dbY1W6hdRWZmKxU=
Date:   Fri, 20 Sep 2019 17:11:42 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun8i-ui/vi: Fix layer zpos change/atomic
 modesetting
Message-ID: <20190920151142.ijistzhtcaenehx6@gilmour>
References: <20190914220337.646719-1-megous@megous.com>
 <20190918141734.kerdbbaynwutrxf6@gilmour>
 <20190918152309.j2dbu63jaru6jn2t@core.my.home>
 <20190918201617.5gwzmshoxbcxbmrx@gilmour>
 <20190919122058.fhpuafogdq7oir2d@core.my.home>
 <20190919131244.35hmnp7jizegltp7@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190919131244.35hmnp7jizegltp7@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 03:12:44PM +0200, Ond=C5=99ej Jirman wrote:
> On Thu, Sep 19, 2019 at 02:20:58PM +0200, megous hlavni wrote:
> > On Wed, Sep 18, 2019 at 10:16:17PM +0200, Maxime Ripard wrote:
> > > On Wed, Sep 18, 2019 at 05:23:09PM +0200, Ond=C5=99ej Jirman wrote:
> > > > Hi,
> > > >
> > > > On Wed, Sep 18, 2019 at 04:17:34PM +0200, Maxime Ripard wrote:
> > > > > Hi,
> > > > >
> > > > > On Sun, Sep 15, 2019 at 12:03:37AM +0200, megous@megous.com wrote:
> > > > > > From: Ondrej Jirman <megous@megous.com>
> > > > > >
> > > > > > There are various issues that this re-work of sun8i_[uv]i_layer=
_enable
> > > > > > function fixes:
> > > > > >
> > > > > > - Make sure that we re-initialize zpos on reset
> > > > > > - Minimize register updates by doing them only when state chang=
es
> > > > > > - Fix issue where DE pipe might get disabled even if it is no l=
onger
> > > > > >   used by the layer that's currently calling sun8i_ui_layer_ena=
ble
> > > > > > - .atomic_disable callback is not really needed because .atomic=
_update
> > > > > >   can do the disable too, so drop the duplicate code
> > > > > >
> > > > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > > >
> > > > > It looks like these fixes should be in separate patches. Is there=
 any
> > > > > reason it's not the case?
> > > >
> > > > Bullet points just describe the resulting effect/benefits of the ch=
ange to fix
> > > > the pipe control register update issue (see the referenced e-mail).
> > >
> > > It's definitely ok to have multiple patches needed to address a single
> > > perceived issue.
> >
> > Yes, but I can't simply split the patch. In order for each change to wo=
rk on its
> > own, they'd have to be done differently than the final result.
> >
> > I wouldn't mind at all if it was just a simple splitting, but you're as=
king
> > for too much work, this time, for no benefit that I can see.
> >
> > > A commit is not about what you're fixing but what you're changing. And
> > > the fact that you have tha bullet list in the first place proves that
> > > you have multiple logical changes in your patch.
> > >
> > > And even then, your commit log mentions that you're fixing multiple
> > > issues (without explaining them).
> >
> > I can reword the commit message if that helps, and skip the bullet list=
 if it
> > is confusing. There's a single core issue and that is that the driver d=
oesn't
> > update the pipe/channel configuration correctly leading to disabling of
> > arbitrary layers (not even those being updated - update of UI layer may=
 disable
> > VI layer as a side effect for example) at wrong times. And only changes
> > necessary to debug/fix this are included.
>
> How about this:
>
>  A problem was found where identical configuration of planes leads
>  to different register settings at the HW layer when using a X server
>  with modesetting driver and one plane marked as a cursor.

We don't have a cursor plane.

>  On first run of the X server, only the black screen and the layer
>  containing the cursor is visible. Switching to console and back
>  corrects the situation.
>
>  I have dumped registers, and found out this:
>
>  (In both cases there are two enabled planes, plane 1 with zpos 0 and
>  plane 3 with zpos 1).
>
>  1) First Xorg run:
>
>    0x01101000 : 00000201
>    0x01101080 : 00000030
>
>    BLD_FILL_COLOR_CTL: (aka SUN8I_MIXER_BLEND_PIPE_CTL)
>      P1_EN
>
>    BLD_CH_RTCTL: (aka SUN8I_MIXER_BLEND_ROUTE)
>      P0_RTCTL channel0
>      P1_RTCTL channel3
>
>  2) After switch to console and back to Xorg:
>
>  0x01101000 : 00000301
>  0x01101080 : 00000031
>
>    BLD_FILL_COLOR_CTL:
>      P1_EN and P0_EN
>
>    BLD_CH_RTCTL:
>      P0_RTCTL channel1
>      P1_RTCTL channel3
>
>  What happens is that sun8i_ui_layer_enable() function may disable
>  blending pipes even if it is no longer assigned to its layer, because
>  of incorrect state/zpos tracking in the driver.
>
>  In particular, layer 1 is configured to zpos 0 and thus uses pipe 0.
>  When layer 3 is enabled by X server, sun8i_ui_layer_enable() will get
>  called with old_zpos=3D0 zpos=3D1, which will lead to disabling of pipe =
0.
>
>  In general this issue can happen to any layer during enable or zpos
>  changes on multiple layers at once.
>
>  To correct this we now pass previous enabled/disabled state of the
>  layer, and pass real previous zpos of the layer to
>  sun8i_ui_layer_enable() and rework the sun8i_ui_layer_enable() function
>  to react to the state changes correctly. In order to not complicate
>  the atomic_disable callback with all of the above changes, we simply
>  remove it and implement all the chanes as part of atomic_update, which
>  also reduces the code duplication.

I'm not even sure why we need that old state. Can't we just reset
completely the whole thing and do the configuration all over again?

That description just looks to me like the reset is not done properly,
and now we have to deal with the fallouts later on.

>  To make this all work, initial zpos positions of all layers need to be
>  restored to initial values on reset.

And this also fixes a whole other bunch of issues, and can be made
very trivially in a separate patch.

Maxime
