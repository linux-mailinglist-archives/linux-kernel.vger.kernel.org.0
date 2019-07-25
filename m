Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD575446
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbfGYQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:41:05 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:38324 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727957AbfGYQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:41:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C28EC100E86C1;
        Thu, 25 Jul 2019 16:41:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3871:3872:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12050:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21740:30029:30054:30064:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: egg25_7d66ef2072332
X-Filterd-Recvd-Size: 2173
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 16:41:01 +0000 (UTC)
Message-ID: <2331c1248aceff966403c0f3c5d527c95c930b5b.camel@perches.com>
Subject: Re: [PATCH v2] writeback: fix -Wstringop-truncation warnings
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@lca.pw>, David Laight <David.Laight@ACULAB.COM>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "tobin@kernel.org" <tobin@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "jack@suse.cz" <jack@suse.cz>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jul 2019 09:41:00 -0700
In-Reply-To: <1564069805.11067.20.camel@lca.pw>
References: <1564065511-13206-1-git-send-email-cai@lca.pw>
         <4017a4af4b0e4b96a6d7ed66afe18120@AcuMS.aculab.com>
         <1564069805.11067.20.camel@lca.pw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 11:50 -0400, Qian Cai wrote:

> > > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
[]
> > > @@ -66,8 +66,10 @@
> > >  	),
> > > 
> > >  	TP_fast_assign(
> > > -		strncpy(__entry->name,
> > > -			mapping ? dev_name(inode_to_bdi(mapping->host)-
> > > > dev) : "(unknown)", 32);
> > > 
> > > +		strscpy_pad(__entry->name,
> > > +			    mapping ?
> > > +			    dev_name(inode_to_bdi(mapping->host)->dev) :
> > > +			    "(unknown)", 32);
> > 
> > Shouldn't the 32 be 'sizeof (something)' ??
> 
> Maybe could do a sizeof(__entry->name) as it is defined as,
> 
> 	TP_STRUCT__entry (
> 		__array(char, name, 32)
> 		__field(unsigned long, ino)
> 		__field(pgoff_t, index)
> 
> But, that might be a follow-up patch and does not seem belong here.

stracpy_pad would work one day.


