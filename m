Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C35FD2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfGDSzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 14:55:43 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:35395 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbfGDSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:55:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id EE55F180A8158;
        Thu,  4 Jul 2019 18:55:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 64,4,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2332:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:4321:5007:7875:7903:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21220:21451:21627:30012:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: spy10_4eb8e4a98aa28
X-Filterd-Recvd-Size: 1962
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jul 2019 18:55:40 +0000 (UTC)
Message-ID: <7f2c01da182551a043a049bb0b367924ee073358.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add *_NOTIFIER_HEAD as var definition
From:   Joe Perches <joe@perches.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jul 2019 11:55:39 -0700
In-Reply-To: <20190704104457.30045-1-gilad@benyossef.com>
References: <20190704104457.30045-1-gilad@benyossef.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 13:44 +0300, Gilad Ben-Yossef wrote:
> Add *_NOTIFIER_HEAD as variable definition to avoid code like this:
> 
> ATOMIC_NOTIFIER_HEAD(foo);
> EXPORT_SYMBOL_GPL(foo);
> 
> From triggering the the following warning:
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
> 
> Changes from v1:
> - Better RegExp as suggested by Joe Perches.

Seems fine thanks.

>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 342c7c781ba5..9cadda7024ae 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3864,6 +3864,7 @@ sub process {
>  				^.DEFINE_$Ident\(\Q$name\E\)|
>  				^.DECLARE_$Ident\(\Q$name\E\)|
>  				^.LIST_HEAD\(\Q$name\E\)|
> +				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
>  				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
>  				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=|\[|\()
>  			    )/x) {

