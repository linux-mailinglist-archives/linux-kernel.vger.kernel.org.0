Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D96E1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 09:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfGSHhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 03:37:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52418 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbfGSHhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:37:00 -0400
X-UUID: 7273c3cb0d474fd1aa6b0e4a94ef9eaf-20190719
X-UUID: 7273c3cb0d474fd1aa6b0e4a94ef9eaf-20190719
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 636699458; Fri, 19 Jul 2019 15:36:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 19 Jul 2019 15:36:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Jul 2019 15:36:50 +0800
Message-ID: <1563521810.8881.3.camel@mtkswgap22>
Subject: Re: [PATCH v3] checkpatch: add several Kconfig default value tests
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andy Whitcroft <apw@canonical.com>
CC:     Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Date:   Fri, 19 Jul 2019 15:36:50 +0800
In-Reply-To: <20190705031626.13859-1-miles.chen@mediatek.com>
References: <20190705031626.13859-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-05 at 11:16 +0800, Miles Chen wrote:
> This change adds 3 Kconfig default value tests.

Hi Joe,

I was wondering if this patch looks good to you?

Miles
> 
> 1. discourage default n cases:
> e.g.,
> default n
> 
> 2. discourage default "[ynm]" cases:
> e.g.,
> arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
> arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
> arch/powerpc/Kconfig:   default "n"
> drivers/auxdisplay/Kconfig:     default "n"
> drivers/crypto/Kconfig: default "m"
> drivers/rapidio/devices/Kconfig:        default "n"
> 
> 3. discourage default EXPERT or default !EXPERT cases:
> e.g.,
> drivers/hid/Kconfig:    default !EXPERT
> 
> tested cases:
> default m
> default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
> default y if ALPHA_QEMU
> default n if PPC_POWERNV
> default n
> default EXPERT
> default !EXPERT
> default "m"
> default "n"
> default "y" if EXPERT
> default "y" if PPC_POWERNV
> 
> test result:
> WARNING: 'default n' is the default value, no need to write it explicitly
> +       default n
> 
> WARNING: Avoid using default EXPERT
> +       default EXPERT
> 
> WARNING: Avoid using default EXPERT
> +       default !EXPERT
> 
> WARNING: Use 'default m' not 'default "m"'
> +       default "m"
> 
> WARNING: Use 'default n' not 'default "n"'
> +       default "n"
> 
> WARNING: Use 'default y' not 'default "y"'
> +       default "y" if EXPERT
> 
> WARNING: Use 'default y' not 'default "y"'
> +       default "y" if PPC_POWERNV
> 
> test --fix capability:
> default n => delete line
> default "m" => default m
> default "n" => default n
> default "y" if EXPERT => default y if EXPERT
> default "y" if PPC_POWERNV => default y if PPC_POWERNV
> default !EXPERT => no change
> default EXPERT => no change
> 
> Change since v1:
> discourage default n$
> discourage default "[ynm]"
> discourage default \!?EXPERT
> 
> Change since v2:
> (Joe has provided the whole patch and I just post it)
> test Kconfig in a single block
> print precise message such as 'default "m"', not 'default "[ynm]"'
> provide --fix capability
> 
> Cc: Joe Perches <joe@perches.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  scripts/checkpatch.pl | 139 ++++++++++++++++++++++++++----------------
>  1 file changed, 85 insertions(+), 54 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 342c7c781ba5..94799f23339c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2932,60 +2932,98 @@ sub process {
>  				      "Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.\n" . $herevet)
>  		}
>  
> -# check for Kconfig help text having a real description
> -# Only applies when adding the entry originally, after that we do not have
> -# sufficient context to determine whether it is indeed long enough.
> -		if ($realfile =~ /Kconfig/ &&
> -		    # 'choice' is usually the last thing on the line (though
> -		    # Kconfig supports named choices), so use a word boundary
> -		    # (\b) rather than a whitespace character (\s)
> -		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
> -			my $length = 0;
> -			my $cnt = $realcnt;
> -			my $ln = $linenr + 1;
> -			my $f;
> -			my $is_start = 0;
> -			my $is_end = 0;
> -			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
> -				$f = $lines[$ln - 1];
> -				$cnt-- if ($lines[$ln - 1] !~ /^-/);
> -				$is_end = $lines[$ln - 1] =~ /^\+/;
> -
> -				next if ($f =~ /^-/);
> -				last if (!$file && $f =~ /^\@\@/);
> -
> -				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
> -					$is_start = 1;
> -				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
> -					if ($lines[$ln - 1] =~ "---help---") {
> -						WARN("CONFIG_DESCRIPTION",
> -						     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
> +# Kconfig tests
> +		if ($realfile =~ /Kconfig/) {
> +			# check for Kconfig help text having a real description
> +			# Only applies when adding the entry originally, after
> +			# that we do not have sufficient context to determine
> +			# whether it is indeed long enough.
> +			# 'choice' is usually the last thing on the line (though
> +			# Kconfig supports named choices), so use a word
> +			# boundary (\b) rather than a whitespace character (\s)
> +			if ($line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
> +				my $length = 0;
> +				my $cnt = $realcnt;
> +				my $ln = $linenr + 1;
> +				my $f;
> +				my $is_start = 0;
> +				my $is_end = 0;
> +				for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
> +					$f = $lines[$ln - 1];
> +					$cnt-- if ($lines[$ln - 1] !~ /^-/);
> +					$is_end = $lines[$ln - 1] =~ /^\+/;
> +
> +					next if ($f =~ /^-/);
> +					last if (!$file && $f =~ /^\@\@/);
> +
> +					if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
> +						$is_start = 1;
> +					} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
> +						if ($lines[$ln - 1] =~ "---help---") {
> +							WARN("CONFIG_DESCRIPTION",
> +							     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
> +						}
> +						$length = -1;
> +					}
> +
> +					$f =~ s/^.//;
> +					$f =~ s/#.*//;
> +					$f =~ s/^\s+//;
> +					next if ($f =~ /^$/);
> +
> +					# This only checks context lines in the patch
> +					# and so hopefully shouldn't trigger false
> +					# positives, even though some of these are
> +					# common words in help texts
> +					if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
> +							   if|endif|menu|endmenu|source)\b/x) {
> +						$is_end = 1;
> +						last;
>  					}
> -					$length = -1;
> +					$length++;
> +				}
> +				if ($is_start && $is_end && $length < $min_conf_desc_length) {
> +					WARN("CONFIG_DESCRIPTION",
> +					     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
>  				}
> +				#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
> +			}
>  
> -				$f =~ s/^.//;
> -				$f =~ s/#.*//;
> -				$f =~ s/^\s+//;
> -				next if ($f =~ /^$/);
> -
> -				# This only checks context lines in the patch
> -				# and so hopefully shouldn't trigger false
> -				# positives, even though some of these are
> -				# common words in help texts
> -				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
> -						  if|endif|menu|endmenu|source)\b/x) {
> -					$is_end = 1;
> -					last;
> +# discourage the use of boolean for type definition attributes
> +			if ($line =~ /^\+\s*\bboolean\b/) {
> +				if (WARN("CONFIG_TYPE_BOOLEAN",
> +					 "Use of boolean is deprecated, please use bool instead\n" . $herecurr) &&
> +				    $fix) {
> +					$fixed[$fixlinenr] =~ s/\bboolean\b/bool/;
> +				}
> +			}
> +
> +# Kconfig: discourage redundant 'default n'
> +			if ($line =~ /^\+\s*default\s+n$/) {
> +				if (WARN("CONFIG_DEFAULT_VALUE_STYLE",
> +					 "'default n' is the default value, no need to write it explicitly\n" . $herecurr) &&
> +				    $fix) {
> +					fix_delete_line($fixlinenr, $rawline);
>  				}
> -				$length++;
>  			}
> -			if ($is_start && $is_end && $length < $min_conf_desc_length) {
> -				WARN("CONFIG_DESCRIPTION",
> -				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
> +
> +# Kconfig: discourage quoted defaults: use default [ynm], not default "[ynm]"
> +			if ($rawline =~ /^\+\s*default\s+"([ynm])"/) {
> +				if (WARN("CONFIG_DEFAULT_VALUE_STYLE",
> +					 "Use 'default $1' not 'default \"$1\"'\n" . $herecurr) &&
> +				    $fix) {
> +					$fixed[$fixlinenr] =~ s/\b(default\s+)"(.)"/$1$2/;
> +				}
> +			}
> +
> +# Kconfig: discourage using default EXPERT or !EXPERT
> +			if ($line =~ /^\+\s*default\s+\!?\s*EXPERT\b/) {
> +				WARN("CONFIG_DEFAULT_VALUE_STYLE",
> +				     "Avoid using default EXPERT\n" . $herecurr);
>  			}
> -			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
>  		}
> +# End of Kconfig tests
> +
>  
>  # check for MAINTAINERS entries that don't have the right form
>  		if ($realfile =~ /^MAINTAINERS$/ &&
> @@ -2998,13 +3036,6 @@ sub process {
>  			}
>  		}
>  
> -# discourage the use of boolean for type definition attributes of Kconfig options
> -		if ($realfile =~ /Kconfig/ &&
> -		    $line =~ /^\+\s*\bboolean\b/) {
> -			WARN("CONFIG_TYPE_BOOLEAN",
> -			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
> -		}
> -
>  		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
>  		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
>  			my $flag = $1;


