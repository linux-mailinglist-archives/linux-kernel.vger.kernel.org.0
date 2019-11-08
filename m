Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3544CF3D95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 02:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfKHBqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 20:46:32 -0500
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:43964 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbfKHBqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:46:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 564B2100E7B44;
        Fri,  8 Nov 2019 01:46:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2692:2731:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6691:6742:7514:10004:10400:11232:11658:11914:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21324:21451:21627:30054:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: cough96_558de86610607
X-Filterd-Recvd-Size: 2341
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Nov 2019 01:46:27 +0000 (UTC)
Message-ID: <2367894118ccee058ed451927412d7c1a33864bd.camel@perches.com>
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     megous@megous.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, kishon@ti.com, paul.kocialkowski@bootlin.com,
        linux-sunxi@googlegroups.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
Date:   Thu, 07 Nov 2019 17:46:14 -0800
In-Reply-To: <20191107233914.GW25745@shell.armlinux.org.uk>
References: <20191020134229.1216351-3-megous@megous.com>
         <20191107204645.13739-1-rikard.falkeborn@gmail.com>
         <20191107233914.GW25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 23:39 +0000, Russell King - ARM Linux admin wrote:
> On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
> > Arguments are supposed to be ordered high then low.
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> > Spotted while trying to add compile time checks of GENMASK arguments.
> > Patch has only been compile tested.
> 
> My feeling, personally, is that GENMASK() really isn't worth the pain
> it causes.  Can we instead get rid of this thing and just use easier
> to understand and less error-prone hex masks please?
> 
> I don't care what anyone else says, personally I'm going to stick with
> using hex masks as I find them way easier to get right first time than
> a problematical opaque macro - and I really don't want the effort of
> finding out that I've got the arguments wrong when I build it.  It's
> just _way_ easier and less error prone to use a hex mask straight off.

I agree, but there are already more than 8000 uses of this rather
silly (and perhaps backwards argument order) macro in the kernel.


