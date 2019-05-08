Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506D817C87
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 16:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfEHOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 10:51:48 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:53653 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbfEHOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:51:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7138C180A813C;
        Wed,  8 May 2019 14:51:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:2919:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3874:4321:5007:7903:10004:10400:10450:10455:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:19904:19999:21080:21324:21433:21451:21627:30029:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: ray83_ee8e93ad3e2b
X-Filterd-Recvd-Size: 2043
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 14:51:42 +0000 (UTC)
Message-ID: <4517dfca6c4692b28c4914410f475d3f521cd230.camel@perches.com>
Subject: Re: [PATCH 1/4] checkpatch: fix multiple const * types
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 07:51:40 -0700
In-Reply-To: <20190508122721.7513-1-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 14:27 +0200, Antonio Borneo wrote:
> Commit 1574a29f8e76 ("checkpatch: allow multiple const * types")
> claims to support repetition of pattern "const *", but it actually
> allows only one extra instance.
> Check the following lines
> 	int a(char const * const x[]);
> 	int b(char const * const *x);
> 	int c(char const * const * const x[]);
> 	int d(char const * const * const *x);
> with command
> 	./scripts/checkpatch.pl --show-types -f filename
> to find that only the first line passes the test, while a warning
> is triggered by the other 3 lines:
> 	WARNING:FUNCTION_ARGUMENTS: function definition argument
> 	'char const * const' should also have an identifier name
> The reason is that the pattern match halts at the second asterisk
> in the line, thus the remaining text starting with asterisk fails
> to match a valid name for a variable.
> 
> Fixed by replacing "?" (Match 1 or 0 times) with "*" (Match 0 or
> more times) in the regular expression.
> Fix also the similar test for types in unusual order.

It might be better to use a max match like {0,4} instead of *

perl is pretty memory intensive at multiple unrestricted matches
of somewhat complex patterns.


