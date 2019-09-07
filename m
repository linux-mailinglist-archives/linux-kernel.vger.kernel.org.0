Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69F5AC91E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 22:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406122AbfIGUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 16:01:14 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:36646 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391561AbfIGUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:01:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6BB4B45DA;
        Sat,  7 Sep 2019 20:01:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:2915:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:6691:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13095:13141:13161:13229:13230:13311:13357:13439:14181:14659:14721:21080:21433:21627:30054:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: clock12_449f447336531
X-Filterd-Recvd-Size: 1691
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 20:01:11 +0000 (UTC)
Message-ID: <628cfe909375f444c33ef4da0b09a32dbff0303b.camel@perches.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
From:   Joe Perches <joe@perches.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        jslaby@suse.com
Date:   Sat, 07 Sep 2019 13:01:10 -0700
In-Reply-To: <9A23770B-49B8-4DB1-8B45-22F3650E0CB8@volery.com>
References: <a99b7481f26138ea01de0d271e9aec2a525c0aed.camel@perches.com>
         <9A23770B-49B8-4DB1-8B45-22F3650E0CB8@volery.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 21:51 +0200, Sandro Volery wrote:
> > On 7 Sep 2019, at 21:27, Joe Perches <joe@perches.com> wrote:
[]
> > As long as git diff -w shows no difference and a compiled
> > object comparison before and after the change shows no
> > difference, I think it's fine.
> 
> My thoughts, too. I didn't feel comfortable arguing as a newbie tho
> so I'll see what I can do once I get home.

If you do that, it's important to mention both elements in
the commit message:

	1: git diff -w shows no difference
	2: pre and post compilation objects are identical

It is also good to verify that allyesconfig and defconfig
objects with the minimal CONFIG_ required for compilation
are also identical.

Whitespace only changes should only change horizontal
spacing and should not have vertical line changes.


