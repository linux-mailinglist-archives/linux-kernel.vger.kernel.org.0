Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17433D452A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfJKQPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:15:44 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:44292 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbfJKQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:15:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 338A68368F0B;
        Fri, 11 Oct 2019 16:15:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:4321:5007:7903:8603:9389:10004:10400:11026:11232:11473:11658:11914:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:21080:21212:21627:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: oil02_4ec6eab431f26
X-Filterd-Recvd-Size: 1758
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 16:15:41 +0000 (UTC)
Message-ID: <168ca7e087da28527134816b7a4dabac043a0796.camel@perches.com>
Subject: Re: [PATCH] ipmi: Convert ipmi_debug_msg to pr_debug and use %*ph
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Oct 2019 09:15:39 -0700
In-Reply-To: <20191011160541.GG32742@smile.fi.intel.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
         <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
         <20191011151220.GB32742@smile.fi.intel.com>
         <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
         <7831759661d9f3d47bd304b2e98e65e5d6c5d167.camel@perches.com>
         <20191011160541.GG32742@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 19:05 +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 08:46:41AM -0700, Joe Perches wrote:
> > Using %*ph format to print small buffers as hex string reduces
> > overall object size and allows the removal of the two variants
> > of ipmi_debug_msg.
> > 
> > This also removes unnecessary duplicate colons from output when
> > enabled by #DEBUG or newly possible CONFIG_DYNAMIC_DEBUG.
> 
> I have sent v2 with slightly better approach (no need to have %s).

Great, yours has the advantage of actually compiling properly.
I did not reverse the arguments after the format.  oops.


