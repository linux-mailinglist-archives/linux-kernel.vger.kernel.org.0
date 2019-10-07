Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241A5CDBF7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfJGGwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 02:52:05 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:41828 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726960AbfJGGwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:52:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F2040182CED5B;
        Mon,  7 Oct 2019 06:52:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2895:2911:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4425:4605:5007:6119:7974:9025:10004:10400:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21433:21627:21740:30054:30060:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: drain01_11f090bc8a144
X-Filterd-Recvd-Size: 1962
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 06:52:03 +0000 (UTC)
Message-ID: <b5b363ef96a1bfad6965c4b01c8737990b8f4e91.camel@perches.com>
Subject: Re: checkpatch: false positive "does MAINTAINERS need updating?"
 warning
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 06 Oct 2019 23:52:02 -0700
In-Reply-To: <CAK7LNARKUAoHDFzGJ3snAy2XeQshTqmzDMUC7qqU8=L-p=+LNg@mail.gmail.com>
References: <CAK7LNARKUAoHDFzGJ3snAy2XeQshTqmzDMUC7qqU8=L-p=+LNg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 13:44 +0900, Masahiro Yamada wrote:
> Hi Joe,
> 
> 
> I ran checkpatch.pl against the following:
> https://lore.kernel.org/patchwork/patch/1136334/
> 
> 
> I did update MAINTAINERS, but I still get
> "does MAINTAINERS need updating?" warning.
> Why?

Because checkpatch is not able to determine
that you updated MAINTAINERS correctly.

Ignore checkpatch output when you know better.

> 
> 
> $ scripts/checkpatch.pl
> 0001-doc-move-namespaces.rst-out-of-kbuild-directory.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #18:
>  Documentation/{kbuild => admin-guide}/namespaces.rst | 0
> 
> total: 0 errors, 1 warnings, 14 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-doc-move-namespaces.rst-out-of-kbuild-directory.patch has style
> problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 

