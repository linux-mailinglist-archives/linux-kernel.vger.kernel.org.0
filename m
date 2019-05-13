Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC51BD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfEMSxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 14:53:49 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:48967 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbfEMSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:53:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B8E03C1DCBC;
        Mon, 13 May 2019 18:53:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2553:2559:2562:2691:2731:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3873:4321:4385:4605:5007:6119:6742:10004:10400:10848:11232:11657:11658:11914:12043:12555:12740:12760:12895:13069:13215:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: fly77_5b0af3af8b416
X-Filterd-Recvd-Size: 2641
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 May 2019 18:53:45 +0000 (UTC)
Message-ID: <ea3792fdc90c2d37dd8a889c173c94d743b7b583.camel@perches.com>
Subject: Re: [PATCH v10 1/4] MAINTAINERS: add an entry for for arm64 imx 
 devicetrees
From:   Joe Perches <joe@perches.com>
To:     Angus Ainslie <angus@akkea.ca>, Fabio Estevam <festevam@gmail.com>
Cc:     angus.ainslie@puri.sm, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 13 May 2019 11:53:44 -0700
In-Reply-To: <e61562bfc80e25bf233ae7fd7b032f83@www.akkea.ca>
References: <20190513174057.4410-1-angus@akkea.ca>
         <20190513174057.4410-2-angus@akkea.ca>
         <CAOMZO5BaQnrDOYogzgpmCExjB+uhYQ8SsxBiMWrSB-1KRtgeVQ@mail.gmail.com>
         <e61562bfc80e25bf233ae7fd7b032f83@www.akkea.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 11:48 -0700, Angus Ainslie wrote:
> On 2019-05-13 11:01, Fabio Estevam wrote:
> > On Mon, May 13, 2019 at 2:41 PM Angus Ainslie (Purism) <angus@akkea.ca> 
> > wrote:
> > > Add an explicit reference to imx* devicetrees
> > > 
> > > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 7707c28628b9..0871a21a5bbb 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1648,6 +1648,7 @@ T:        git 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> > >  F:     arch/arm/boot/dts/ls1021a*
> > >  F:     arch/arm64/boot/dts/freescale/fsl-*
> > >  F:     arch/arm64/boot/dts/freescale/qoriq-*
> > > +F:     arch/arm64/boot/dts/freescale/imx*
> > 
> > No, please put this entry under ARM/FREESCALE IMX / MXC ARM 
> > ARCHITECTURE
> > 
> 
> I believe order is important. Would you like it before or after the "N:" 
> entries ? Or just as the last entry.

Order is not important, but I prefer the
N: entries after the X: and F: entries.


