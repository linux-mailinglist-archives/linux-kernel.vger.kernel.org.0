Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3662318452F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 11:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgCMKs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 06:48:27 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:49668 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:48:27 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 02DAmKLN010761;
        Fri, 13 Mar 2020 19:48:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 02DAmKLN010761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584096501;
        bh=JPUSYJFjWhyniU1qgq95NHuOfe3MBhxe5TPFalXRYjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QteD1KVq/gcwv2TvVNwXkdXsbfX1rI+maoy/IhK032uvjS2VCV/sqcFWmNPn9IAUR
         pIh/actlxHN76YvlD4YnzNstDgF5P3qe+VvqBV+uQzzjV+tYPxFsjxd4Z45LvsNEe0
         ZpBdmNhNKDTtNw+ZKVsWfov8n3LHeYR9tBmVT0w9TSnSZa9LOecurdv9n0kBACOyEB
         DP78bH/c6GqqBY22r3eP5XdImTul+lKHvP7PH1vVqA6HJf6+qjn1Vw2eBgf7Mky+Nf
         fY9dSVIgvSDRhf8vjrW5vEWmxcHNlbghcllEEDANydiXDjFGITqvqUwZf+t2fMbyO4
         EiPj6f2aT8dAw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id c18so5765804vsq.7;
        Fri, 13 Mar 2020 03:48:21 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1GBhK/hYn0pMR3CFiYW2nO3te6l71evjyIEjSbDyhQINIW9CZ4
        hswPnbRH2qqN1fOjIG2CqDKFkj+gbNZ4C0Yb3hg=
X-Google-Smtp-Source: ADFU+vvsYSgrvwDt40Kwaoojzk6PijqEahzLfY9nrBKpISQsGBKm7+XYq0rwc0V+iwP1dc8lh5aX38CLJblGDTzjd5E=
X-Received: by 2002:a67:3201:: with SMTP id y1mr9085168vsy.54.1584096500083;
 Fri, 13 Mar 2020 03:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <1584070314-26495-1-git-send-email-peng.fan@nxp.com> <CAK8P3a0r1stgYw2DGtsHpMWdBN7GM9miAsUo20NaJxwasQy4iA@mail.gmail.com>
In-Reply-To: <CAK8P3a0r1stgYw2DGtsHpMWdBN7GM9miAsUo20NaJxwasQy4iA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 Mar 2020 19:47:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfQmpVxG7N9_ZL4uTaMY2DeP-Y1aAdP72eatD936zkYA@mail.gmail.com>
Message-ID: <CAK7LNASfQmpVxG7N9_ZL4uTaMY2DeP-Y1aAdP72eatD936zkYA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Makefile: build arm64 device tree
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 7:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 13, 2020 at 4:38 AM <peng.fan@nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > To support aarch32 mode linux on aarch64 hardware, we need
> > build the device tree, so include the arm64 device tree path.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
>
> There are a few other platforms with similar requirements, in
> particular bcm2837,
> so maybe try doing it the same way they do, see
> arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts

I think this was discussed over again,
but it is odd to tightly couple
DT and Linux arch.


Maybe, a long time solution might be to
create a new directory, dts/
and collect all DT stuff into it.

dts/<vendor>/<board>.dts


Then, also move like follows:

Documentation/devicetree/bindings/
 ->  dts/Bindings/

include/dt-bingins/
 -> dts/include/dt-bindings/






>
> > V1:
> >  This is just the device tree part. Besides this,
> >  I am not sure whether need to create a standalone defconfig under arm32
> >  for aarch32 mode linux on aarch64 hardware, or use multi_v7_defconfig.
> >  multi_v7_defconfig should be ok, need to include LPAE config.
>
> I'd rather not have a standalone defconfig for it, given that we have a
> single defconfig for all armv6/armv7/armv7hf i.mx machines.
>
> There was a suggestion to use a fragment for enabling an LPAE
> multi_v7_defconfig recently, which I think is still under discussion but
> should also help here, both with imx_v6_v7_defconfig and multi_v7_defconfig.
>
> Can you remind us why this platform needs LPAE? Is it only needed to
> support more than 4GB of RAM, or something else on top of that?
> Note that users that actually have 4GB or more on i.mx8 should
> really run a 64-bit kernel anyway, even if they prefer using 32-bit user
> space.
>
> Turning on LPAE not only disables imx3 and imx5 but also the Cortex-A9
> based imx6 variants.
>
>       Arnd



-- 
Best Regards
Masahiro Yamada
