Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1431CDB28A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408727AbfJQQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 12:38:15 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:45423 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729529AbfJQQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:38:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 326BC181D341E;
        Thu, 17 Oct 2019 16:38:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6742:8531:8985:9025:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12555:12663:12740:12760:12895:12986:13069:13095:13311:13357:13439:14181:14659:14721:21063:21080:21433:21627:21740:30012:30034:30054:30070:30091,0,RBL:47.151.135.62:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: club44_2a4e4b9966947
X-Filterd-Recvd-Size: 3120
Received: from XPS-9350.home (unknown [47.151.135.62])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Oct 2019 16:38:10 +0000 (UTC)
Message-ID: <c2a4d95bee896df95d277fe84295e91014835030.camel@perches.com>
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
From:   Joe Perches <joe@perches.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Whitcroft <apw@canonical.com>,
        "DavidS. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        AlexeiStarovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        ArnaldoCarvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Thu, 17 Oct 2019 09:38:09 -0700
In-Reply-To: <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
         <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
         <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
         <20191017130550.nwswlnwdroyjwwun@pathway.suse.cz>
         <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-17 at 21:29 +0800, Kefeng Wang wrote:
> On 2019/10/17 21:05, Petr Mladek wrote:
> > On Tue 2019-10-08 14:39:32, Kefeng Wang wrote:
> > > On 2019/10/2 16:55, Petr Mladek wrote:
> > > > On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
> > > > > There are pr_warning and pr_warng to show WARNING level message,
> > > > > most of the code using pr_warn, number based on next-20190919,
> > > > > 
> > > > > pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)
> > > > 
> > > > The ratio is 10:1 in favor of pr_warn(). It would make sense
> > > > to remove the pr_warning().
> > > > 
> > > > Would you accept pull request with these 32 simple patches
> > > > for rc2, please?
> > > > 
> > > > Alternative is to run a simple sed. But it is not trivial
> > > > to fix indentation of the related lines.
> > > 
> > > Kindly ping, should I respin patches with comments fixed?
> > > Is the patchset acceptable, hope to be clear that what to do next :)
> > 
> > I am going to check how many conflicts appeared in linux-next.
> > 
> > If there are only few then I'll take it via printk.git. This way
> > we get proper indentation and other changes.
[]
> For tools parts(api/bpf/perf, patch [29-31]), it renames pr_warning
> to pr_warn, and make manually changes in some place, simply 'sed'
> maybe not enough.

Perhaps tools/ should not be changed.

Last time I did this, I did not convert tools/ as there are
possible external dependencies and code like pr_warning_wrapper
exists and that adds some complexity to the change.

https://lore.kernel.org/patchwork/cover/761816/


