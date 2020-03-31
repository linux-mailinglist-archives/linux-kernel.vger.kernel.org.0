Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BDF199DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCaSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 14:22:05 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:33610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgCaSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:22:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0E3D5180286D8;
        Tue, 31 Mar 2020 18:22:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7903:8660:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12895:13069:13095:13148:13230:13311:13357:13894:14659:14721:21063:21080:21433:21451:21627:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: ice31_864618078355f
X-Filterd-Recvd-Size: 2749
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Mar 2020 18:22:02 +0000 (UTC)
Message-ID: <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
From:   Joe Perches <joe@perches.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
Date:   Tue, 31 Mar 2020 11:20:07 -0700
In-Reply-To: <20200331112637.25047-1-vegard.nossum@oracle.com>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:
> compiletime_assert() uses __LINE__ to create a unique function name.
> This means that if you have more than one BUILD_BUG_ON() in the same
> source line (which can happen if they appear e.g. in a macro), then
> the error message from the compiler might output the wrong condition.
> 
> For this source file:
> 
> 	#include <linux/build_bug.h>
> 
> 	#define macro() \
> 		BUILD_BUG_ON(1); \
> 		BUILD_BUG_ON(0);
> 
> 	void foo()
> 	{
> 		macro();
> 	}
> 
> gcc would output:
> 
> ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_9’ declared with attribute error: BUILD_BUG_ON failed: 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> 
> However, it was not the BUILD_BUG_ON(0) that failed, so it should say 1
> instead of 0. With this patch, we use __COUNTER__ instead of __LINE__, so
> each BUILD_BUG_ON() gets a different function name and the correct
> condition is printed:
> 
> ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_0’ declared with attribute error: BUILD_BUG_ON failed: 1
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
[]
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
[]
> @@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
>   * compiler has support to do so.
>   */
>  #define compiletime_assert(condition, msg) \
> -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

This might be better using something like __LINE__ ## _ ## __COUNTER__

as line # is somewhat useful to identify the specific assert in a file.


