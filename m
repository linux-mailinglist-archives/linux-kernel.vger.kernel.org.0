Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50A416B796
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 03:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgBYCNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 21:13:41 -0500
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:37047 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbgBYCNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:13:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A68A2182CED34;
        Tue, 25 Feb 2020 02:13:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2689:2693:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:4321:5007:10004:10400:10450:10455:10848:11026:11232:11658:11914:12297:12555:12740:12760:12895:13069:13255:13311:13357:13439:13618:14181:14659:14721:19904:19999:21080:21222:21451:21611:21627:21740:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: nest60_772b7ebd10559
X-Filterd-Recvd-Size: 2237
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 02:13:38 +0000 (UTC)
Message-ID: <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
From:   Joe Perches <joe@perches.com>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>
Date:   Mon, 24 Feb 2020 18:12:08 -0800
In-Reply-To: <20200224235824.126361-1-john.stultz@linaro.org>
References: <20200224235824.126361-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 23:58 +0000, John Stultz wrote:
> Quite often, the Change-Id may be between Signed-off-by: lines or
> at the end of them. Unfortunately checkpatch won't catch these
> cases as it disables in_commit_log when it catches the first
> Signed-off-by line.
> 
> This has bitten me many many times.

Hmm.  When is change-id used in your workflow?

> I suspect this patch will break other use cases, so it probably
> shouldn't be merged, but I wanted to share it just to help
> illustrate the problem.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Yes, I expect this will break things.

And it's probably better to not add a Signed-off-by: when
you intend this not to be merged.

> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a63380c6b0d2..a55340a9e3ea 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2609,7 +2609,8 @@ sub process {
>  # Check the patch for a signoff:
>  		if ($line =~ /^\s*signed-off-by:/i) {
>  			$signoff++;
> -			$in_commit_log = 0;
> +			#Disabling in_commit_log here breaks Change-Id checking in some cases
> +			#$in_commit_log = 0;
>  			if ($author ne '') {
>  				my $l = $line;
>  				$l =~ s/"//g;

