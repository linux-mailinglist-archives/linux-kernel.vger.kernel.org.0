Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5701B99D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfEMPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 11:11:34 -0400
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:56547 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726738AbfEMPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:11:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 84F98180A8859;
        Mon, 13 May 2019 15:11:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:4321:4385:5007:6119:10004:10400:10848:11232:11657:11658:11914:12043:12555:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21627:21740:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:40,LUA_SUMMARY:none
X-HE-Tag: toy82_2a4704a514822
X-Filterd-Recvd-Size: 1704
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 May 2019 15:11:30 +0000 (UTC)
Message-ID: <0f355f524122cb4dd6388431495a9d182e3ed9d6.camel@perches.com>
Subject: Re: [PATCH v9 1/3] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
From:   Joe Perches <joe@perches.com>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>, angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 13 May 2019 08:11:29 -0700
In-Reply-To: <20190513145539.28174-2-angus@akkea.ca>
References: <20190513145539.28174-1-angus@akkea.ca>
         <20190513145539.28174-2-angus@akkea.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 07:55 -0700, Angus Ainslie (Purism) wrote:
> This is for the development kit board for the Librem 5. The current level
> of support yields a working console and is able to boot userspace from
> the network or eMMC.
[]
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> new file mode 100644

Perhaps add an entry in the MAINTAINERS file for this
.dts file similar to other freescale boards?


