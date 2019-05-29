Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E112E71F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 23:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfE2VLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 17:11:11 -0400
Received: from casper.infradead.org ([85.118.1.10]:59002 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2VLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/IEGWZ5s5PK90Jk/nlfqXuwQUnnri2Ga23rgGUkL3OI=; b=KbJr0BTLPdvlHMfIC2IeEJ3XwJ
        rndJW60/mqZhkdN1xEXDe/q7dHHUYpKRw+JIDq0hdjasK9E9NDZnWwRLSt7sLlAgoZoMfrjvEVJR8
        82xe6EzPI3EYLFpGBhBQPwce0isuDXroJDOggYaYz3Kg+94HI5VNr4+XJmeMVZ5v0+NJMmDbqN0ss
        kSiR+fK7vVCP4anIicrpaI7fZWdxMK81zePyt3Dmp+EGfs6ZgwBizOouGo8CtkNKub5K3wP0Wq8r3
        yeeBpHko5CRWUya+vX6TWqJY8ukFeWygAlspwem1tM9yV3XsRJmod0hffk00pSwkR4X1DZDJ+jOWS
        cWMwEyrQ==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW5qm-0000Eh-Ls; Wed, 29 May 2019 21:11:09 +0000
Date:   Wed, 29 May 2019 18:11:04 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=" <niklas.soderlund@ragnatech.se>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20190529181104.6ae7e5de@coco.lan>
In-Reply-To: <20190529210511.GM1651@bigcity.dyn.berto.se>
References: <20190529080454.6d62a7fd@canb.auug.org.au>
        <20190529210511.GM1651@bigcity.dyn.berto.se>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 29 May 2019 23:05:11 +0200
"Niklas S=C3=B6derlund" <niklas.soderlund@ragnatech.se> escreveu:

> Hi Stephen, Mauro,
>=20
> On 2019-05-29 08:04:54 +1000, Stephen Rothwell wrote:
> > Hi Mauro,
> >=20
> > In commit
> >=20
> >   0c310868826e ("media: rcar-csi2: Fix coccinelle warning for PTR_ERR_O=
R_ZERO()")
> >=20
> > Fixes tag
> >=20
> >   Fixes: 3ae854cafd76 ("rcar-csi2: Use standby mode instead of resettin=
g")
> >=20
> > has these problem(s):
> >=20
> >   - Target SHA1 does not exist
> >=20
> > Did you mean
> >=20
> > Fixes: d245a940d97b ("media: rcar-csi2: Use standby mode instead of res=
etting") =20
>=20
> Yes I meant d245a940d97b commit, for some reason I was on the wrong=20
> branch when looking up the sha1 for the fixes tag and used one from a=20
> local development branch.
>=20
> This is my mess, sorry about that. What can I do to help fix it?

That's a good question... no idea. Rebasing the tree due to that sounds
a bad idea. Reverting/reapplying also doesn't sound the best thing,
as it will just make -stable people even more confused.

I should probably try to implement a script like the one Stephen
has on my patch import scripts.

Thanks,
Mauro
