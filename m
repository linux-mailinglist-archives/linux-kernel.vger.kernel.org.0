Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524C280C63
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 22:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHDURX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 16:17:23 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:46355 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbfHDURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 16:17:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1131D181D3368;
        Sun,  4 Aug 2019 20:17:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:421:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:2915:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7903:10004:10400:10848:11232:11658:11914:12296:12297:12555:12663:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21324:21611:21627:30054:30066:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: book66_7a24adcc5af63
X-Filterd-Recvd-Size: 1902
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Aug 2019 20:17:19 +0000 (UTC)
Message-ID: <15450f6ba169de8862e11bc2d20b3645958f4efd.camel@perches.com>
Subject: Re: [PATCH 1/1] block: Use bits.h macros to improve readability
From:   Joe Perches <joe@perches.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Sun, 04 Aug 2019 13:17:17 -0700
In-Reply-To: <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
References: <20190802000041.24513-1-leonardo@linux.ibm.com>
         <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 21:18 -0700, Jens Axboe wrote:
> On 8/1/19 6:00 PM, Leonardo Bras wrote:
> > Applies some bits.h macros in order to improve readability of
> > linux/blk_types.h.
[]
> I know precisely what that does, whereas I have to think about the other
> one, maybe even look it up to be sure. For instance, without looking
> now, I have no idea what the second argument is. Looking at the git log,
> I see numerous instances of:

While I'm not at all a proponent of GENMASK/GENMASK_ULL,
and so not a proponent of this patch, latent defects are
possible in both cases.

You'd likely have to look at SOME_SHIFT to see if it's 0
to verify the actual mask is what's really desired.

$ git grep -P '_SHIFT\s+\(?\s*0\s*\)?\b' | wc -l
11907

