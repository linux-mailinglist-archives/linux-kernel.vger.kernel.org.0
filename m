Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9266870C80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 00:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfGVWYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 18:24:38 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:59822 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbfGVWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:24:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C970C18224D99;
        Mon, 22 Jul 2019 22:24:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:7903:10004:10400:10848:10967:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21627:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: dress20_280f7ba920e31
X-Filterd-Recvd-Size: 2494
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jul 2019 22:24:35 +0000 (UTC)
Message-ID: <512d8977fb0d0b3eef7b6ea1753fb4c33fbc43e8.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Mon, 22 Jul 2019 15:24:33 -0700
In-Reply-To: <20190722155730.08dfd4e3@lwn.net>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
         <20190629181537.7d524f7d@sk2.org> <201907021024.D1C8E7B2D@keescook>
         <20190706144204.15652de7@heffalump.sk2.org>
         <201907221047.4895D35B30@keescook>
         <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
         <20190722230102.442137dc@heffalump.sk2.org>
         <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
         <20190722155730.08dfd4e3@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 15:57 -0600, Jonathan Corbet wrote:
> On Mon, 22 Jul 2019 14:50:09 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > On Mon, 2019-07-22 at 23:01 +0200, Stephen Kitt wrote:
> > > How about you submit your current patch set, and I follow up with the above
> > > adapted to stracpy?  
> > 
> > OK, I will shortly after I figure out how to add kernel-doc
> > for stracpy/stracpy_pad to lib/string.c.
> > 
> > It doesn't seem appropriate to add the kernel-doc to string.h
> > as it would be separated from the others in string.c
> > 
> > Anyone got a clue here?  Jonathan?
> 
> If the functions themselves are fully defined in the .h file, I'd just add
> the kerneldoc there as well.  That's how it's usually done, and you want
> to keep the documentation and the prototypes together.

In this case, it's a macro and yes, the kernel-doc could
easily be set around the macro in the .h, but my desire
is to keep all the string function kernel-doc output
together so it should be added to lib/string.c

Are you suggesting I move all the lib/string.c kernel-doc
to include/linux/string.h ?

