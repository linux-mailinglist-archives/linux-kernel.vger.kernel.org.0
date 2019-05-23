Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DB3274A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 04:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfEWC6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 22:58:20 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:49209 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727305AbfEWC6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:58:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 04C33100E86C0;
        Thu, 23 May 2019 02:58:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:4250:4321:5007:7901:10004:10400:10848:11232:11658:11914:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21795:30054:30060:30070:30090:30091,0,RBL:172.56.44.57:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:38,LUA_SUMMARY:none
X-HE-Tag: care15_2aae51fa10659
X-Filterd-Recvd-Size: 1955
Received: from XPS-9350 (unknown [172.56.44.57])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 May 2019 02:58:12 +0000 (UTC)
Message-ID: <4857dce766f161a643eb3340dfee6a2dec7eb2e5.camel@perches.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Date:   Wed, 22 May 2019 19:57:41 -0700
In-Reply-To: <CAK7LNAQ=M0ejV3C8bgjuMxdRR9v=2-GRdXeUjFR6URrrtYPCnA@mail.gmail.com>
References: <20190521133257.GA21471@kroah.com>
         <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
         <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
         <CAK7LNAQ=M0ejV3C8bgjuMxdRR9v=2-GRdXeUjFR6URrrtYPCnA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 11:49 +0900, Masahiro Yamada wrote:
> On Wed, May 22, 2019 at 3:37 PM Joe Perches <joe@perches.com> wrote:
[]
> > I could also wire up a patch to checkpatch and docs to
> > remove the /* */ requirement for .h files and prefer
> > the generic // form for both .c and .h files as the
> > current minimum tooling versions now all allow //
> > comments
> > .
> 
> We have control for minimal tool versions for building the kernel,
> so I think // will be OK for in-kernel headers.
> 
> 
> On the other hand, I am not quite sure about UAPI headers.
> We cannot define minimum tool versions
> for building user-space.
> Perhaps, using // in UAPI headers causes a problem
> if an ancient compiler is used?

Good point. Thanks.


