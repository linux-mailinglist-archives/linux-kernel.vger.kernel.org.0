Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62FDA3C27
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfH3Qhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:37:55 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:40152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727914AbfH3Qhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:37:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C4F3018224D7B;
        Fri, 30 Aug 2019 16:37:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1963:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4362:5007:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12050:12297:12555:12740:12760:12895:12986:13069:13095:13181:13229:13311:13357:13439:14181:14659:14721:19904:19999:21080:21433:21627:21740:21741:30054:30064:30070:30080:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: wind21_a98b898a015f
X-Filterd-Recvd-Size: 2175
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 16:37:52 +0000 (UTC)
Message-ID: <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove obsolete period from "ambiguous
 SHA1" query
From:   Joe Perches <joe@perches.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 09:37:51 -0700
In-Reply-To: <20190830163103.15914-1-sean.j.christopherson@intel.com>
References: <20190830163103.15914-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 09:31 -0700, Sean Christopherson wrote:
> Git dropped the period from its "ambiguous SHA1" error message in commit
> 0c99171ad2 ("get_short_sha1: mark ambiguity error for translation"),
> circa 2016.  Drop the period from checkpatch's associated query so as to
> match both the old and new error messages.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edfe0f05..ef3642c53100 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -962,7 +962,7 @@ sub git_commit_info {
>  
>  	return ($id, $desc) if ($#lines < 0);
>  
> -	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
> +	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous/) {
>  # Maybe one day convert this block of bash into something that returns
>  # all matching commit ids, but it's very slow...
>  #

Thanks.

Did git ever change to actually support human readable
messages in multiple languages?

If so, this won't work for non-english output.

It probably doesn't matter though.

Acked-by: Joe Perches <joe@perches.com>


