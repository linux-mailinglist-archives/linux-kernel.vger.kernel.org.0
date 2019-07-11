Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3165370
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfGKJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 05:04:15 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:35214 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfGKJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:04:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B2D398368F12;
        Thu, 11 Jul 2019 09:04:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3867:3868:3870:3871:3872:3874:4321:4362:5007:7903:9545:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:13095:13439:14181:14659:14721:21080:21221:21433:21451:21611:21627:30054:30070:30080:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: cows26_7c1a6094d865d
X-Filterd-Recvd-Size: 3022
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jul 2019 09:04:12 +0000 (UTC)
Message-ID: <bcba757ac112bab9287632400ce8b3508c955572.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch.pl: warn on invalid commit id
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Thu, 11 Jul 2019 02:04:11 -0700
In-Reply-To: <20190711001640.13398-1-mcroce@redhat.com>
References: <20190711001640.13398-1-mcroce@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 02:16 +0200, Matteo Croce wrote:
> It can happen that a commit message refers to an invalid commit id, because
> the referenced hash changed following a rebase, or simply by mistake.
> Add a check in checkpatch.pl which checks that an hash referenced by
> a Fixes tag, or just cited in the commit message, is a valid commit id.

Thanks Matteo, this seems sensible.

>     $ scripts/checkpatch.pl <<'EOF'
>     Subject: [PATCH] test commit
> 
>     Sample test commit to test checkpatch.pl
>     Commit 1da177e4c3f4 ("Linux-2.6.12-rc2") really exists,
>     commit 0bba044c4ce7 ("tree") is valid but not a commit,
>     while commit b4cc0b1c0cca ("unknown") is invalid.
> 
>     Fixes: f0cacc14cade ("unknown")
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>     EOF
>     WARNING: Unknown commit id '0bba044c4ce7', maybe rebased or not pulled?
>     #8:
>     commit 0bba044c4ce7 ("tree") is valid but not a commit,
> 
>     WARNING: Unknown commit id 'b4cc0b1c0cca', maybe rebased or not pulled?
>     #9:
>     while commit b4cc0b1c0cca ("unknown") is invalid.
> 
>     WARNING: Unknown commit id 'f0cacc14cade', maybe rebased or not pulled?
>     #11:
>     Fixes: f0cacc14cade ("unknown")
> 
>     total: 0 errors, 3 warnings, 4 lines checked
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  scripts/checkpatch.pl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a6d436809bf5..3b77279df13b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2898,6 +2898,17 @@ sub process {
>  			}
>  		}
>  
> +# check for invalid commit id
> +		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
> +			my $id;
> +			my $description;
> +			($id, $description) = git_commit_info($2, undef, undef);
> +			if (!defined($id)) {
> +				WARN("UNKNOWN_COMMIT_ID",
> +				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);
> +			}
> +		}
> +
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =~ /^-/);
>  

