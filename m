Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390E173644
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGXSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 14:03:40 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:45288 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbfGXSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:03:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 416D2182CF674;
        Wed, 24 Jul 2019 18:03:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3871:3872:3873:4321:4605:5007:6119:7903:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:21080:21221:21451:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: crush75_3ce39f3b86a14
X-Filterd-Recvd-Size: 2307
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 18:03:38 +0000 (UTC)
Message-ID: <4ce25249a42248e7762f22f40d6d9898365024ea.camel@perches.com>
Subject: Re: [PATCH 01/12] checkpatch: Add GENMASK tests
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 24 Jul 2019 11:03:35 -0700
In-Reply-To: <c5cf9dd30360a395b50514f8fece2231e0180ce1.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
         <c5cf9dd30360a395b50514f8fece2231e0180ce1.1562734889.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> This macro is easy to misuse as it's odd argument order.
> 
> If specified with simple decimal values, make sure the arguments are
> ordered high then low.
> 
> Also check if any argument is > 32 where instead of GENMASK,
> GENMASK_ULL should be used.

Hey Andrew, can you add this please.

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/checkpatch.pl | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6cb99ec62000..d37bbe33524b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6368,6 +6368,21 @@ sub process {
>  			     "switch default: should use break\n" . $herectx);
>  		}
>  
> +# check for misuses of GENMASK
> +		if ($line =~ /\b(GENMASK(?:_ULL)?)\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)/) {
> +			my $type = $1;
> +			my $high = $2;
> +			my $low = $3;
> +			if ($high < $low) {
> +				ERROR("GENMASK",
> +				      "$type argument order is high then low\n" . $herecurr);
> +			}
> +			if ($type eq "GENMASK" && ($high >= 32 || $low >= 32)) {
> +				ERROR("GENMASK",
> +				      "$type with arguments >= 32 should use GENMASK_ULL\n" . $herecurr);
> +			}
> +		}
> +
>  # check for gcc specific __FUNCTION__
>  		if ($line =~ /\b__FUNCTION__\b/) {
>  			if (WARN("USE_FUNC",

