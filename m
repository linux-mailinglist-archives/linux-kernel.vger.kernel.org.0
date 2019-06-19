Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587D44C0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 20:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFSS1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 14:27:46 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:45050 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbfFSS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:27:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7531D100E806B;
        Wed, 19 Jun 2019 18:27:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:966:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2525:2561:2566:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3867:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4385:5007:6117:7514:7809:7903:8957:9010:9025:9405:10004:10400:10848:11232:11658:11914:12043:12295:12740:12760:12895:13069:13311:13357:13439:13846:14181:14659:14721:21080:21433:21451:21627:21820:30054:30060:30070:30075:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: boats69_7da522d121463
X-Filterd-Recvd-Size: 1956
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Jun 2019 18:27:43 +0000 (UTC)
Message-ID: <d4b42858366e50f92b133ceb6399e9f16a7cef88.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 11:27:42 -0700
In-Reply-To: <20190619181844.57696-1-ndesaulniers@google.com>
References: <20190619181844.57696-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-19 at 11:18 -0700, Nick Desaulniers wrote:
> Add keyword support so that our mailing list gets cc'ed for clang/llvm
> patches.

You'd also possibly get cc'd on patches that merely mention
clang or llvm like any change to clang-format.  It could be
many files that aren't interesting.

$ git grep -i -w -P --name-only '(?i:clang|llvm)' | wc -l
134

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3940,6 +3940,14 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>  S:	Maintained
>  F:	.clang-format
>  
> +CLANG/LLVM BUILD SUPPORT
> +L: clang-built-linux@googlegroups.com
> +W: https://clangbuiltlinux.github.io/
> +B: https://github.com/ClangBuiltLinux/linux/issues
> +C: irc://chat.freenode.net/clangbuiltlinux
> +S: Supported
> +K: \b(?i:clang|llvm)\b
> +

Please use a single tab after each : like below

CLANG/LLVM BUILD SUPPORT
L:	clang-built-linux@googlegroups.com
W:	https://clangbuiltlinux.github.io/
B:	https://github.com/ClangBuiltLinux/linux/issues
C:	irc://chat.freenode.net/clangbuiltlinux
S:	Supported
K:	\b(?i:clang|llvm)\b


