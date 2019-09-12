Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC0B11B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfILPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 11:01:50 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:58292 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732728AbfILPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:01:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B13BC18224D69;
        Thu, 12 Sep 2019 15:01:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3874:4321:4385:5007:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13076:13160:13161:13229:13311:13357:13439:14659:14721:21080:21627:30012:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:37,LUA_SUMMARY:none
X-HE-Tag: pump00_49bc2d71dfd50
X-Filterd-Recvd-Size: 1798
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 15:01:46 +0000 (UTC)
Message-ID: <33c0f43ef2334de5885e5fcf041483a2afb13787.camel@perches.com>
Subject: Re: [PATCH 01/13] nvdimm: Use more typical whitespace
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org
Date:   Thu, 12 Sep 2019 08:01:45 -0700
In-Reply-To: <20190912121707.GA16029@infradead.org>
References: <cover.1568256705.git.joe@perches.com>
         <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
         <20190912121707.GA16029@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 05:17 -0700, Christoph Hellwig wrote:
> Instead of arguing what is better just stick to what the surrounding
> code does.

That's not always feasible nor readable.

Especially for the logic inversion blocks where
the existing code does unreadable and error prone
things like hiding semicolons immediately after
comments.

	if (foo)
		/* longish comment */;
	else {
		<code>;
	}

> Or in other words:  Feel free to be a codingstyle nazi for your code
> (I am for some of mine), but leave others peoples code alone with
> "cleanup" patches.

My point was to avoid documenting per-subsystem
coding style rules.


