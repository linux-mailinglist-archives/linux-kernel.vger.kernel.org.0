Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25E117642D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgCBTl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:41:29 -0500
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:58237 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgCBTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:41:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8FB63180A813D;
        Mon,  2 Mar 2020 19:41:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fear94_c98062e1a951
X-Filterd-Recvd-Size: 2203
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Mar 2020 19:41:26 +0000 (UTC)
Message-ID: <ff833cf6a9a489ff446910c85e2a56ff1c11ccb4.camel@perches.com>
Subject: Re: [PATCH 2/7] parport: Use more comon logging styles
From:   Joe Perches <joe@perches.com>
To:     Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 11:39:53 -0800
In-Reply-To: <b4a4f5a8-9ff0-e3d3-93c9-260a11cdb439@gmx.de>
References: <cover.1582878393.git.joe@perches.com>
         <1da80f696e3602cc2533988b20f9a47cd42db1c4.1582878394.git.joe@perches.com>
         <b4a4f5a8-9ff0-e3d3-93c9-260a11cdb439@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 20:29 +0100, Helge Deller wrote:
> On 28.02.20 09:32, Joe Perches wrote:
> > Some of the logging can be poorly formatted because of unexpected
> > line breaks given printks without KERN_CONT that should be pr_cont.
[]
> > diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
[]
> > @@ -238,14 +238,14 @@ struct parport *parport_gsc_probe_port(unsigned long base,
> > 
> >  	priv = kzalloc (sizeof (struct parport_gsc_private), GFP_KERNEL);
> >  	if (!priv) {
> > -		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
> > +		printk(KERN_DEBUG "parport (0x%lx): no memory!\n", base);
> 
> pr_warn() instead?

For all of your remarks, the intent here is to keep the
same output.

Logging level changes and printk(KERN_DEBUG -> pr_debug(
conversions cause the dmesg output to be different.

	printk(KERN_DEBUG...)

is always emitted when the console level allows but

	pr_debug(...)

is not normally compiled in at all.

So it's possible for all printk(KERN_DEBUG to be pr_debug
but that causes no logging at all to be emitted when
DEBUG is not defined or CONFIG_DYNAMIC_DEBUG not enabled.


