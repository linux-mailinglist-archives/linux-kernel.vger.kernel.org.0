Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3629217F62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 19:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfEHR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 13:56:11 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:56949 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727020AbfEHR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:56:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E9A7D180A8452;
        Wed,  8 May 2019 17:56:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:2:41:69:355:379:599:800:960:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:2197:2199:2393:2525:2561:2564:2682:2685:2687:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4117:4250:4321:4362:4605:4823:5007:6691:7514:7860:7903:7904:8599:8603:8957:9010:9025:9040:9121:9388:10004:10049:10848:11026:11232:11233:11473:11658:11914:12043:12294:12296:12346:12438:12555:12740:12776:12895:12986:13439:13894:14659:21080:21221:21433:21451:21505:21627:21795:30012:30034:30051:30054:30062:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: knot98_189857d02d93b
X-Filterd-Recvd-Size: 6426
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 17:56:08 +0000 (UTC)
Message-ID: <e9cccc6630eb2fd273e7aa47a635717041b92d05.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add command-line option for TAB size
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 10:56:07 -0700
In-Reply-To: <20190508174356.13952-1-borneo.antonio@gmail.com>
References: <20190508174356.13952-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 19:43 +0200, Antonio Borneo wrote:
> The size of 8 characters used for both TAB and indentation is
> embedded as magic value allover the checkpatch script, and this
> makes the script less readable.

I doubt this bit of the commit message is proper.

Tabs _are_ 8 in the linux-kernel sources and checkpatch
was written for the linux-kernel.

Using a variable _could_ reasonably be described as an
improvement, but readability wasn't and isn't really an
issue here.

Other than that, the patch seems fine.

thanks,  Joe

> Replace the magic value 8 with a variable.
> From the context of the code it's clear if it is used for
> indentation or tabulation, so no need to use two separate
> variables.
> 
> Add a command-line option "--tab-size" to let the user select a
> TAB size value other than 8.
> This makes easy to reuse this script by other projects with
> different requirements in their coding style (e.g. OpenOCD [1]
> requires TAB size of 4 characters [2]).
> 
> [1] http://openocd.org/
> [2] http://openocd.org/doc/doxygen/html/stylec.html#styleformat
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> Signed-off-by: Erik Ahlén <erik.ahlen@avalonenterprise.com>
> Signed-off-by: Spencer Oliver <spen@spen-soft.co.uk>
> ---
> V1 -> V2
> 	add the command line option
> 
>  scripts/checkpatch.pl | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 916a3fbd4d47..90f641bf1895 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -62,6 +62,7 @@ my $conststructsfile = "$D/const_structs.checkpatch";
>  my $typedefsfile = "";
>  my $color = "auto";
>  my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
> +my $tabsize = 8;
>  
>  sub help {
>  	my ($exitcode) = @_;
> @@ -96,6 +97,7 @@ Options:
>    --show-types               show the specific message type in the output
>    --max-line-length=n        set the maximum line length, if exceeded, warn
>    --min-conf-desc-length=n   set the min description length, if shorter, warn
> +  --tab-size=n               set the number of spaces for tab (default 8)
>    --root=PATH                PATH to the kernel tree root
>    --no-summary               suppress the per-file summary
>    --mailback                 only produce a report in case of warnings/errors
> @@ -213,6 +215,7 @@ GetOptions(
>  	'list-types!'	=> \$list_types,
>  	'max-line-length=i' => \$max_line_length,
>  	'min-conf-desc-length=i' => \$min_conf_desc_length,
> +	'tab-size=i'	=> \$tabsize,
>  	'root=s'	=> \$root,
>  	'summary!'	=> \$summary,
>  	'mailback!'	=> \$mailback,
> @@ -1211,7 +1214,7 @@ sub expand_tabs {
>  		if ($c eq "\t") {
>  			$res .= ' ';
>  			$n++;
> -			for (; ($n % 8) != 0; $n++) {
> +			for (; ($n % $tabsize) != 0; $n++) {
>  				$res .= ' ';
>  			}
>  			next;
> @@ -2224,7 +2227,7 @@ sub string_find_replace {
>  sub tabify {
>  	my ($leading) = @_;
>  
> -	my $source_indent = 8;
> +	my $source_indent = $tabsize;
>  	my $max_spaces_before_tab = $source_indent - 1;
>  	my $spaces_to_tab = " " x $source_indent;
>  
> @@ -3153,7 +3156,7 @@ sub process {
>  		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
>  
>  # at the beginning of a line any tabs must come first and anything
> -# more than 8 must use tabs.
> +# more than $tabsize must use tabs.
>  		if ($rawline =~ /^\+\s* \t\s*\S/ ||
>  		    $rawline =~ /^\+\s*        \s*/) {
>  			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
> @@ -3172,7 +3175,7 @@ sub process {
>  				"please, no space before tabs\n" . $herevet) &&
>  			    $fix) {
>  				while ($fixed[$fixlinenr] =~
> -					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
> +					   s/(^\+.*) {$tabsize,$tabsize}\t/$1\t\t/) {}
>  				while ($fixed[$fixlinenr] =~
>  					   s/(^\+.*) +\t/$1\t/) {}
>  			}
> @@ -3194,11 +3197,11 @@ sub process {
>  		if ($perl_version_ok &&
>  		    $sline =~ /^\+\t+( +)(?:$c90_Keywords\b|\{\s*$|\}\s*(?:else\b|while\b|\s*$)|$Declare\s*$Ident\s*[;=])/) {
>  			my $indent = length($1);
> -			if ($indent % 8) {
> +			if ($indent % $tabsize) {
>  				if (WARN("TABSTOP",
>  					 "Statements should start on a tabstop\n" . $herecurr) &&
>  				    $fix) {
> -					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/8)@e;
> +					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/$tabsize)@e;
>  				}
>  			}
>  		}
> @@ -3216,8 +3219,8 @@ sub process {
>  				my $newindent = $2;
>  
>  				my $goodtabindent = $oldindent .
> -					"\t" x ($pos / 8) .
> -					" "  x ($pos % 8);
> +					"\t" x ($pos / $tabsize) .
> +					" "  x ($pos % $tabsize);
>  				my $goodspaceindent = $oldindent . " "  x $pos;
>  
>  				if ($newindent ne $goodtabindent &&
> @@ -3688,11 +3691,11 @@ sub process {
>  			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sindent> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> stat_real<$stat_real> stat<$stat>\n";
>  
>  			if ($check && $s ne '' &&
> -			    (($sindent % 8) != 0 ||
> +			    (($sindent % $tabsize) != 0 ||
>  			     ($sindent < $indent) ||
>  			     ($sindent == $indent &&
>  			      ($s !~ /^\s*(?:\}|\{|else\b)/)) ||
> -			     ($sindent > $indent + 8))) {
> +			     ($sindent > $indent + $tabsize))) {
>  				WARN("SUSPECT_CODE_INDENT",
>  				     "suspect code indent for conditional statements ($indent, $sindent)\n" . $herecurr . "$stat_real\n");
>  			}

