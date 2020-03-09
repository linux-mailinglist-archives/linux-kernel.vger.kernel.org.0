Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77817EBAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 23:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCIWIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 18:08:19 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:55902 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgCIWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:08:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 47DD518021B9F;
        Mon,  9 Mar 2020 22:08:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2194:2199:2393:2525:2561:2564:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7875:7903:7974:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12297:12438:12555:12696:12737:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21325:21451:21627:21811:21939:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: boy57_657be7daf1149
X-Filterd-Recvd-Size: 2634
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 22:08:17 +0000 (UTC)
Message-ID: <524e6933c4082608895184dbb956f6ce0bb9226d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check proper licensing of Devicetree
 bindings
From:   Joe Perches <joe@perches.com>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 15:06:37 -0700
In-Reply-To: <20200309215153.38824-1-lkundrak@v3.sk>
References: <20200309215153.38824-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 22:51 +0100, Lubomir Rintel wrote:
> According to Devicetree maintainers (see Link: below), the Devicetree
> binding documents are preferrably licensed (GPL-2.0-only OR
> BSD-2-Clause).
> 
> Let's check that. The actual check is a bit more relaxed, to allow more
> liberal but compatible licensing (e.g. GPL-2.0-or-later OR
> BSD-2-Clause).
> 
> Link: https://lore.kernel.org/lkml/20200108142132.GA4830@bogus/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Fine by me.
Andrew, please pick this up.

cheers, Joe

> ---
> Changes since v1:
> - Downgrade severity to CHECK when running against existing files [Joe
>   Perches]
> - Add --fix support [Joe Perches]
> Both changes are taken from here: https://lore.kernel.org/lkml/39042657067088e4ca960f630a7d222fc48f947a.camel@perches.com/
> ---
>  scripts/checkpatch.pl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e2976c3fe5ff8..642e897f46e5c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3111,6 +3111,17 @@ sub process {
>  						WARN("SPDX_LICENSE_TAG",
>  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
>  					}
> +					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> +					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
> +						my $msg_level = \&WARN;
> +						$msg_level = \&CHK if ($file);
> +						if (&{$msg_level}("SPDX_LICENSE_TAG",
> +
> +								  "DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)\n" . $herecurr) &&
> +						    $fix) {
> +							$fixed[$fixlinenr] =~ s/SPDX-License-Identifier: .*/SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)/;
> +						}
> +					}
>  				}
>  			}
>  		}

