Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4032314AAC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 21:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgA0UED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 15:04:03 -0500
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:44179 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgA0UED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:04:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A8695100E7B47;
        Mon, 27 Jan 2020 20:04:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1028:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:7903:8660:8985:9010:9025:9040:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:12986:13095:13148:13230:13439:13618:14181:14659:14721:21080:21433:21451:21627:21811:21819:21939:30003:30022:30054:30070:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: toad58_400ed4d2d0058
X-Filterd-Recvd-Size: 4073
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jan 2020 20:04:00 +0000 (UTC)
Message-ID: <f73727fb0bb8b718366064901fbd7c13035ca50d.camel@perches.com>
Subject: Re: [PATCH] scripts/get_maintainer.pl: Deprioritize old Fixes:
 addresses
From:   Joe Perches <joe@perches.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Jan 2020 12:02:56 -0800
In-Reply-To: <20200127095001.1.I41fba9f33590bfd92cd01960161d8384268c6569@changeid>
References: <20200127095001.1.I41fba9f33590bfd92cd01960161d8384268c6569@changeid>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-27 at 09:50 -0800, Douglas Anderson wrote:
> Recently, I found that get_maintainer was causing me to send emails to
> the old addresses for maintainers.  Since I usually just trust the
> output of get_maintainer to know the right email address, I didn't
> even look carefully and fired off two patch series that went to the
> wrong place.  Oops.
> 
> The problem was introduced recently when trying to add signatures from
> Fixes.  The problem was that these email addresses were added too
> early in the process of compiling our list of places to send.  Things
> added to the list earlier are considered more canonical and when we
> later added maintainer entries we ended up deduplicating to the old
> address.
> 
> Here are two examples using mainline commits (to make it easier to
> replicate) for the two maintainers that I messed up recently:
> 
> $ git format-patch d8549bcd0529~..d8549bcd0529
> $ ./scripts/get_maintainer.pl 0001-clk-Add-clk_hw*.patch | grep Boyd
> Stephen Boyd <sboyd@codeaurora.org>...
> 
> $ git format-patch 6d1238aa3395~..6d1238aa3395
> $ ./scripts/get_maintainer.pl 0001-arm64-dts-qcom-qcs404*.patch | grep Andy
> Andy Gross <andy.gross@linaro.org>
> 
> Let's move the adding of addresses from Fixes: to the end since the
> email addresses from these are much more likely to be older.
> 
> After this patch the above examples get the right addresses for the
> two examples.
> 
> Fixes: 2f5bd343694e ("scripts/get_maintainer.pl: add signatures from Fixes: <badcommit> lines in commit message")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'm no expert at this script and no expert at Perl.  If moving this
> call like I'm doing is totally stupid then please let me know what a
> more proper fix is.  Thanks!

No, it's correct and I looked at exactly this
change after this email exchange but I haven't
posted it because there might a be better way to
restructure this to allow the deduplication to
be done properly.

https://lore.kernel.org/lkml/b72846874d5ee367bf86e787ca2152f90d814a34.camel@perches.com/

Anyway, for now, it's likely good enough so:

Acked-by: Joe Perches <joe@perches.com>

>  scripts/get_maintainer.pl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2..7a228681f89f 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -932,10 +932,6 @@ sub get_maintainers {
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
> @@ -974,6 +970,10 @@ sub get_maintainers {
>  	}
>      }
>  
> +    foreach my $fix (@fixes) {
> +	vcs_add_commit_signers($fix, "blamed_fixes");
> +    }
> +
>      my @to = ();
>      if ($email || $email_list) {
>  	if ($email) {

