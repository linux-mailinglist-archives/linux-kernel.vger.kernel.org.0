Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD55153879
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 19:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBESrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 13:47:47 -0500
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:33938 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbgBESrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:47:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CAF25181D303C;
        Wed,  5 Feb 2020 18:47:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:967:968:973:981:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3870:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:7903:8985:9010:9025:10004:10400:11026:11232:11658:11854:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:13069:13072:13311:13357:13439:14181:14659:14721:14777:21080:21433:21611:21627:21740:21819:30003:30022:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: ray91_43a11b80f6a52
X-Filterd-Recvd-Size: 2496
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Feb 2020 18:47:44 +0000 (UTC)
Message-ID: <76267eda365d7c5c0adc7dd16681973c5378df8e.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Prefer MAINTAINER address over S-o-b
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Wed, 05 Feb 2020 10:46:32 -0800
In-Reply-To: <20200205152429.ejgx2on2z4hoycus@kili.mountain>
References: <20200205152429.ejgx2on2z4hoycus@kili.mountain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 18:24 +0300, Dan Carpenter wrote:
> The get_maintainer.pl script looks at git history to create the CC list,
> but unfortunately sometimes those email addresses are out of date.  The
> script also looks at the MAINTAINERS file, of course, but if it already
> found an email address for a maintainer in the git history then the
> deduplicate_email() function will remove the second address.
> 
> It should save the MAINTAINERS address first, before loading the commit
> signer addresses.

Yeah, thanks.  This has been submitted already.
https://lore.kernel.org/patchwork/patch/1186249/

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> We will have to add a special case if the Dan Williamses ever decide
> to work on the same subsystem.
> 
>  scripts/get_maintainer.pl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2..e5bdd3143a49 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -932,14 +932,14 @@ sub get_maintainers {
>  	}
>      }
>  
> -    foreach my $fix (@fixes) {
> -	vcs_add_commit_signers($fix, "blamed_fixes");
> -    }
> -
>      foreach my $email (@email_to, @list_to) {
>  	$email->[0] = deduplicate_email($email->[0]);
>      }
>  
> +    foreach my $fix (@fixes) {
> +	vcs_add_commit_signers($fix, "blamed_fixes");
> +    }
> +
>      foreach my $file (@files) {
>  	if ($email &&
>  	    ($email_git || ($email_git_fallback &&

