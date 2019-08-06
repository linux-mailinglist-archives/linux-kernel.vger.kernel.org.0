Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F341682FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfHFKZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 06:25:43 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:42741 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732418AbfHFKZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:25:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 54D5A100E86C5;
        Tue,  6 Aug 2019 10:25:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3870:3874:4321:4605:5007:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21796:30036:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: brake63_1474f17b51038
X-Filterd-Recvd-Size: 2055
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Aug 2019 10:25:40 +0000 (UTC)
Message-ID: <0de744027ce487b20c3c585f67133b9ad1c996ab.camel@perches.com>
Subject: Re: [PATCH] checkpatch: exclude sizeof sub-expressions from
 MACRO_ARG_REUSE
From:   Joe Perches <joe@perches.com>
To:     Brendan Jackman <brendan.jackman@bluwireless.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 06 Aug 2019 03:25:37 -0700
In-Reply-To: <20190806065910.22600-1-brendan.jackman@bluwireless.co.uk>
References: <20190806065910.22600-1-brendan.jackman@bluwireless.co.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 06:59 +0000, Brendan Jackman wrote:
> The arguments of sizeof are not evaluated so arguments are safe to
> re-use in that context. Excludeing sizeof sub-expressions means
> macros like ARRAY_SIZE can pass checkpatch.

Seems sensible, thanks.

> Signed-off-by: Brendan Jackman <brendan.jackman@bluwireless.co.uk>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edfe0f05..907a8e8d80ae 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5191,7 +5191,7 @@ sub process {
>  			        next if ($arg =~ /\.\.\./);
>  			        next if ($arg =~ /^type$/i);
>  				my $tmp_stmt = $define_stmt;
> -				$tmp_stmt =~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
> +				$tmp_stmt =~ s/\b(sizeof|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
>  				$tmp_stmt =~ s/\#+\s*$arg\b//g;
>  				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
>  				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;

