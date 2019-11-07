Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058F5F31BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 15:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfKGOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 09:45:43 -0500
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:38217 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727779AbfKGOpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:45:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9AC94182CED28;
        Thu,  7 Nov 2019 14:45:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3872:4321:4605:5007:7903:8660:10004:10400:10450:10455:10848:11026:11232:11473:11658:11914:12296:12297:12438:12740:12760:12895:13019:13069:13148:13230:13311:13357:13439:14181:14659:14721:14722:14877:19904:19999:21080:21627:21939:30054:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: bait99_88daa8df0b32f
X-Filterd-Recvd-Size: 3046
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Nov 2019 14:45:40 +0000 (UTC)
Message-ID: <bdd82a1f1711cc6862d9d27448bae0a15b96e288.camel@perches.com>
Subject: Re: [PATCH] xtensa: improve stack dumping
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Date:   Thu, 07 Nov 2019 06:45:25 -0800
In-Reply-To: <20191107143810.oon6bj7dc7xqcyxe@pathway.suse.cz>
References: <20191106181617.1832-1-jcmvbkbc@gmail.com>
         <a9e2f6b65d4c098ab027ea849120d3cf61858e67.camel@perches.com>
         <CAMo8BfLmcCOAinyjB3iEuOF36TYBig=724=s9b6EKr3LzwF5QQ@mail.gmail.com>
         <20191107143810.oon6bj7dc7xqcyxe@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 15:38 +0100, Petr Mladek wrote:
> On Wed 2019-11-06 16:21:51, Max Filippov wrote:
> > On Wed, Nov 6, 2019 at 2:34 PM Joe Perches <joe@perches.com> wrote:
> > > > @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
> > > >       for (i = 0; i < kstack_depth_to_print; i++) {
> > > >               if (kstack_end(sp))
> > > >                       break;
> > > > -             pr_cont(" %08lx", *sp++);
> > > > +             sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
> > > >               if (i % 8 == 7)
> > > > -                     pr_cont("\n");
> > > > +                     pr_info("%s\n", buf);
> > > >       }
> > > > +     if (i % 8)
> > > > +             pr_info("%s\n", buf);
> > > 
> > > Could this be done using hex_dump_to_buffer
> > > by precalculating kstack_end ?
> > 
> > I've got this, but it doesn't look very attractive to me:
> > 
> > void show_stack(struct task_struct *task, unsigned long *sp)
> > {
> >         unsigned long *stack;
> >         int len;
> > 
> >         if (!sp)
> >                 sp = stack_pointer(task);
> >         stack = sp;
> > 
> >         len = min((-(unsigned long)stack) & (THREAD_SIZE - 4),
> >                   kstack_depth_to_print * 4ul);
> > 
> >         pr_info("Stack:\n");
> > 
> >         for (; len > 0; len -= 32) {
> >                 char buf[9 * 8 + 1];
> > 
> >                 hex_dump_to_buffer(sp, min(len, 32), 32, 4,
> >                                    buf, sizeof(buf), false);
> >                 pr_info(" %08lx:  %s\n", (unsigned long)sp, buf);
> >                 sp += 8;
> >         }
> 
> I wonder if the cycle actually could get replaced by a single call:
> 
> 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
> 		       16, 1, sp, len, false);

I think it could be using 4 and not 1 to keep the same output
of a u32 instead of spaces between bytes.



