Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C272DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfGXLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:41:13 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:58406 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727378AbfGXLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:41:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6ABEC180388E6;
        Wed, 24 Jul 2019 11:41:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:7903:9010:10004:10400:10848:10967:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21627:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: boy04_4462ffde4ad0c
X-Filterd-Recvd-Size: 2574
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 11:41:09 +0000 (UTC)
Message-ID: <9bb45dcae38b0f9322c0ce033c041ede02f8d7ec.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Wed, 24 Jul 2019 04:41:07 -0700
In-Reply-To: <20190722162804.754943bc@lwn.net>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
         <20190629181537.7d524f7d@sk2.org> <201907021024.D1C8E7B2D@keescook>
         <20190706144204.15652de7@heffalump.sk2.org>
         <201907221047.4895D35B30@keescook>
         <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
         <20190722230102.442137dc@heffalump.sk2.org>
         <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
         <20190722155730.08dfd4e3@lwn.net>
         <512d8977fb0d0b3eef7b6ea1753fb4c33fbc43e8.camel@perches.com>
         <20190722162804.754943bc@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 16:28 -0600, Jonathan Corbet wrote:
> On Mon, 22 Jul 2019 15:24:33 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > > If the functions themselves are fully defined in the .h file, I'd just add
> > > the kerneldoc there as well.  That's how it's usually done, and you want
> > > to keep the documentation and the prototypes together.  
> > 
> > In this case, it's a macro and yes, the kernel-doc could
> > easily be set around the macro in the .h, but my desire
> > is to keep all the string function kernel-doc output
> > together so it should be added to lib/string.c
> > 
> > Are you suggesting I move all the lib/string.c kernel-doc
> > to include/linux/string.h ?
> 
> If you want the *output* together, just put the kernel-doc directives
> together in the RST file that pulls it all in.  Or am I missing something
> here?

The negative of the kernel-doc separation of prototypes by .h
and .c files is that the ordering of the functions in the .rst
outout files doesn't make much logical sense.

stracpy is pretty far away from strscpy in the list of functions.

