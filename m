Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4F29A95
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbfEXPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 11:06:53 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:51211 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388995AbfEXPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:06:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 94BB718224D9C;
        Fri, 24 May 2019 15:06:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:196:355:379:599:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1622:1711:1730:1747:1777:1792:2393:2525:2553:2566:2682:2685:2693:2828:2829:2859:2890:2902:2916:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4042:4250:4321:5007:6117:7903:8985:9010:9025:9388:10004:10049:10400:10432:10433:10848:11232:11658:11914:12043:12663:12682:12740:12760:12895:13069:13072:13095:13311:13357:13439:14096:14097:14181:14659:14721:14764:14777:19903:19997:21080:21326:21433:21450:21451:21627:21781:21819:30001:30003:30021:30022:30029:30054:30060:30062:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFt
X-HE-Tag: feet66_3bc40e256854e
X-Filterd-Recvd-Size: 2638
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 May 2019 15:06:50 +0000 (UTC)
Message-ID: <ee5c9928d7193436735bf766fb3c1fce81241bf5.camel@perches.com>
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
From:   Joe Perches <joe@perches.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Date:   Fri, 24 May 2019 08:06:49 -0700
In-Reply-To: <20190524125402.GA616@chatter.i7.local>
References: <20190522193011.GB21412@chatter.i7.local>
         <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
         <20190522195804.GC21412@chatter.i7.local> <20190524045708.GH2532@mit.edu>
         <20190524125402.GA616@chatter.i7.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 08:54 -0400, Konstantin Ryabitsev wrote:
> On Fri, May 24, 2019 at 12:57:08AM -0400, Theodore Ts'o wrote:
> > > I'm perfectly fine with Link:, however Reported-By: usually has the 
> > > person's
> > > name and email address (i.e. PII data per GDPR definition). If that pehrson
> > > submitted the bug report via bugzilla.kernel.org or a similar resource,
> > > their expectation is that they can delete their account should they choose
> > > to to do so. However, if the patch containing Reported-By is committed to
> > > git, their PII becomes permanently and immutably recorded for any reasonable
> > > meaning of the word "forever."
> > 
> > Many (most?) bugzilla.kernel.org components result in e-mail getting
> > sent to vger.kernel.org mailing lists.  So even if they delete the
> > bugzilla account, there e-mail will be immortalized in lore.kernel.org
> > and their associated git repositories.
> 
> I wouldn't say that most -- to my knowledge, it's only about 5-6 
> components of the 50+. It's hard to tell how much that is by volume, 
> though, because certainly not all components see much activity.
> 
> We *can* excise things on lore.kernel.org. It's a massive pain, since 
> message archive is a git repository itself, so will need to be rebased, 
> reindexed and remirrored -- but it *is* possible.

It's likely not a worthwhile pain to self-inflict because
lore.kernel.org is not the only public vger mailing list archive.

https://lkml.org/
https://www.spinics.net/lists/kernel/
http://lkml.iu.edu/hypermail/linux/kernel/
https://marc.info/?l=linux-kernel

etc...


