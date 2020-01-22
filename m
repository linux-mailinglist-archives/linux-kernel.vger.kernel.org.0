Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06916145AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 18:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAVR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 12:28:02 -0500
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:55850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgAVR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:28:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 897D6182CED34;
        Wed, 22 Jan 2020 17:28:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2565:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3866:3867:3868:3870:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:7514:7974:8985:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21221:21325:21451:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: actor69_b97d50fdc604
X-Filterd-Recvd-Size: 2878
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Jan 2020 17:27:59 +0000 (UTC)
Message-ID: <e9de2dda118caca92e2cf678cccf76fa097cb734.camel@perches.com>
Subject: Re: [PATCH V2] checkpatch: fix minor typo and mixed space+tab in
 indentation
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 22 Jan 2020 09:26:58 -0800
In-Reply-To: <20200122163852.124417-2-borneo.antonio@gmail.com>
References: <20190508122721.7513-3-borneo.antonio@gmail.com>
         <20200122163852.124417-2-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-22 at 17:38 +0100, Antonio Borneo wrote:
> Fix spelling of "concatenation".
> Don't use tab after space in indentation.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>

I've no objection to any of these 3 patches.
Andrew, might you pick them up please?

https://lore.kernel.org/patchwork/patch/1183806/
https://lore.kernel.org/patchwork/patch/1183805/
https://lore.kernel.org/patchwork/patch/1183804/

> ---
> 
> v1 -> v2
> 	rebased
> 
> ---
>  scripts/checkpatch.pl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 30da08d9646a..4c1be774b0ed 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4582,7 +4582,7 @@ sub process {
>  					    ($op eq '>' &&
>  					     $ca =~ /<\S+\@\S+$/))
>  					{
> -					    	$ok = 1;
> +						$ok = 1;
>  					}
>  
>  					# for asm volatile statements
> @@ -4917,7 +4917,7 @@ sub process {
>  			# conditional.
>  			substr($s, 0, length($c), '');
>  			$s =~ s/\n.*//g;
> -			$s =~ s/$;//g; 	# Remove any comments
> +			$s =~ s/$;//g;	# Remove any comments
>  			if (length($c) && $s !~ /^\s*{?\s*\\*\s*$/ &&
>  			    $c !~ /}\s*while\s*/)
>  			{
> @@ -4956,7 +4956,7 @@ sub process {
>  # if and else should not have general statements after it
>  		if ($line =~ /^.\s*(?:}\s*)?else\b(.*)/) {
>  			my $s = $1;
> -			$s =~ s/$;//g; 	# Remove any comments
> +			$s =~ s/$;//g;	# Remove any comments
>  			if ($s !~ /^\s*(?:\sif|(?:{|)\s*\\?\s*$)/) {
>  				ERROR("TRAILING_STATEMENTS",
>  				      "trailing statements should be on next line\n" . $herecurr);
> @@ -5132,7 +5132,7 @@ sub process {
>  			{
>  			}
>  
> -			# Flatten any obvious string concatentation.
> +			# Flatten any obvious string concatenation.
>  			while ($dstat =~ s/($String)\s*$Ident/$1/ ||
>  			       $dstat =~ s/$Ident\s*($String)/$1/)
>  			{

