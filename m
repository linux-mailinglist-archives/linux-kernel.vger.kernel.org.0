Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96D268166
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 00:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfGNWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 18:10:10 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:56762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728719AbfGNWKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 18:10:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 69D428368EE2;
        Sun, 14 Jul 2019 22:10:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:4321:5007:7974:9586:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21325:21451:21627:30054:30056:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: leaf79_1e302ccefaa00
X-Filterd-Recvd-Size: 1840
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Jul 2019 22:10:07 +0000 (UTC)
Message-ID: <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add new entry for pidfd api
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org
Date:   Sun, 14 Jul 2019 15:10:06 -0700
In-Reply-To: <20190714193344.29100-1-christian@brauner.io>
References: <20190714193344.29100-1-christian@brauner.io>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-14 at 21:33 +0200, Christian Brauner wrote:
> Add me as a maintainer for pidfd stuff. This way we can easily see when
> changes come in and people know who to yell at.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
> []
> @@ -12567,6 +12567,18 @@ F:	arch/arm/boot/dts/picoxcell*
>  F:	arch/arm/mach-picoxcell/
>  F:	drivers/crypto/picoxcell*
>  
> +PIDFD API
> +M:	Christian Brauner <christian@brauner.io>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> +F:	samples/pidfd/
> +F:	tools/testing/selftests/pidfd/
> +K:	(?i)pidfd
> +K:	(?i)clone3

These seem fairly specific without false positives.

> +K:	\b(clone_args|kernel_clone_args)\b
> +N:	pidfd

This one I'd suggest using 2 F: patterns instead
as the patterns are more comprehensive and do not
use git history when looked up with get_maintainer

F:	samples/pidfd/
F:	tools/testing/selftests/pidfd/


