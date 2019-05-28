Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905B92D278
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 01:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfE1XkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 19:40:11 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:49715 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbfE1XkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:40:11 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 06BE01802F4BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 23:40:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 29600837F24C;
        Tue, 28 May 2019 23:40:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:4321:5007:8603:10004:10400:10848:11026:11232:11658:11914:12296:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: wind74_7597841c10f1a
X-Filterd-Recvd-Size: 1440
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 23:40:07 +0000 (UTC)
Message-ID: <7cf0e30a7309008a81cc65e692511a1e8e6b544f.camel@perches.com>
Subject: Re: [PATCH] lib: test_overflow: Avoid taining the kernel and fix
 wrap size
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 16:40:06 -0700
In-Reply-To: <201905281550.4E3CB258F@keescook>
References: <201905281550.4E3CB258F@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 15:51 -0700, Kees Cook wrote:
> This adds __GFP_NOWARN to the kmalloc()-portions of the overflow test to
> avoid tainting the kernel. Additionally fixes up the math on wrap size
> to be architecture and page size agnostic.
[]
> diff --git a/lib/test_overflow.c b/lib/test_overflow.c
[]
> @@ -486,16 +486,17 @@ static int __init test_overflow_shift(void)
[]
> +#define alloc_GFP		 (GFP_KERNEL | __GFP_NOWARN)
[]
> +#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP | __GFP_NOWARN)

seems redundant.


