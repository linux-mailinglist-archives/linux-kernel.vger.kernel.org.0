Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70831244EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEUAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 20:07:26 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:58630 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726584AbfEUAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:07:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AC7CA837F24D;
        Tue, 21 May 2019 00:07:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2551:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3868:3870:3871:3874:4250:4321:5007:6119:7576:7875:9545:10004:10400:10848:11232:11658:11914:12043:12050:12295:12663:12683:12740:12760:12895:13069:13141:13161:13229:13230:13311:13357:13436:13439:14096:14097:14181:14659:14721:14777:21080:21433:21451:21627:21819:30022:30045:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: power90_2371a2faf914a
X-Filterd-Recvd-Size: 2784
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 May 2019 00:07:23 +0000 (UTC)
Message-ID: <1522228b6c9c7ec89ce14f3f3cf1fe221a315371.camel@perches.com>
Subject: Re: [EXT] Re: [PATCH] checkpatch: add test for empty line after
 Fixes statement
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Date:   Mon, 20 May 2019 17:07:22 -0700
In-Reply-To: <20190520135214.GM4573@mtr-leonro.mtl.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
         <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
         <MN2PR18MB318292E37F3AB9383D9FBE0FA1060@MN2PR18MB3182.namprd18.prod.outlook.com>
         <60717bc4cdf327ffe671c328d47c315eefd385c8.camel@perches.com>
         <20190520135214.GM4573@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 16:52 +0300, Leon Romanovsky wrote:
> On Mon, May 20, 2019 at 06:34:49AM -0700, Joe Perches wrote:
> > On Mon, 2019-05-20 at 13:16 +0000, Michal Kalderon wrote:
> > > > From: Joe Perches <joe@perches.com>
> > > > Sent: Monday, May 20, 2019 3:57 PM
> > > > Subject: [EXT] Re: [PATCH] checkpatch: add test for empty line after Fixes
> > > > statement
> > > > 
> > > > External Email
> > > > 
> > > > ----------------------------------------------------------------------
> > > > On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> > > > > Check that there is no empty line after a fixes statement
> > > > 
> > > > why?
> > > > 
> > > This comment is given a lot on the netdev and rdma mailing lists when patches are submitted with
> > > an empty line between Fixes: tag and SOB tags. Since "Fixes:" is just another tag and should be kept
> > > together with the other ones.
> > 
> > So test that all signature blocks and Fixes do not have
> > blank lines between them instead of just the "Fixes:" line.
> > 
> > And if there is some specific ordering required, perhaps a
> > test for that ordering should be added as well.
> 
> I'm aware of only one request - Fixes above SOB.

Well, nack for the suggested patch.

If there are signature blocks, then there should not be blank lines
between entries and there should be a blank line before the
signature block.

The current documentation in Documentation/process/submitting-patches.rst
doesn't state anything about blank lines above or below Fixes: lines.


