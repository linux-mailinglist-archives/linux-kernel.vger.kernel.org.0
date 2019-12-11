Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD779119FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 01:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfLKACD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 19:02:03 -0500
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:45817 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfLKACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:02:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2F575182CF666;
        Wed, 11 Dec 2019 00:02:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3350:3622:3865:3867:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4470:4560:5007:8985:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12555:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:21060:21080:21627:21788:21939:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: loaf54_4b49ceef1b95b
X-Filterd-Recvd-Size: 1455
Received: from XPS-9350 (unknown [66.178.38.77])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Dec 2019 00:01:56 +0000 (UTC)
Message-ID: <4f3e350d0fcef89e25350f7d68ea96f33dc4e3f0.camel@perches.com>
Subject: Re: get_maintainer.pl produces non-deterministic results
From:   Joe Perches <joe@perches.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Tue, 10 Dec 2019 16:01:15 -0800
In-Reply-To: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
References: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-10 at 14:47 +0100, Dmitry Vyukov wrote:
> Hi Joe,
> 
> scripts/get_maintainer.pl fs/proc/task_mmu.c
> non-deterministically gives me from 13 to 16 results, different number
> every time (on upstream 6794862a). Perl v5.28.1. Michael confirmed
> this with v5.28.2.
> Vergard suggested to check PERL_HASH_SEED=0. Indeed it fixes
> non-determinism. But I guess it's not the right solution, there should
> be some logical problem.
> My perl-fo is weak, I appreciate if somebody with proper perl-fo takes a look.
> 
> Thanks

https://lkml.org/lkml/2017/7/13/789


