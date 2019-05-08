Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FA17B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfEHOTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 10:19:34 -0400
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:47807 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbfEHOTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:19:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CAE7F180A885B;
        Wed,  8 May 2019 14:19:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3874:4321:5007:7903:10004:10400:10848:11232:11658:11914:12296:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:32,LUA_SUMMARY:none
X-HE-Tag: slip08_190566b4c9f11
X-Filterd-Recvd-Size: 1834
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 14:19:31 +0000 (UTC)
Message-ID: <b76eb950365b27848dfb0cfc851255d9af97ac90.camel@perches.com>
Subject: Re: [PATCH 2/4] checkpatch: add --fix for warning LINE_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 07:19:29 -0700
In-Reply-To: <20190508122721.7513-2-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
         <20190508122721.7513-2-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 14:27 +0200, Antonio Borneo wrote:
> The warning LINE_CONTINUATIONS does not offer a --fix.
> 
> Add the trivial --fix.
> In case of consecutive lines with the same issue, this will
> fix only the first line.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5207,8 +5207,11 @@ sub process {
>  			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
>  			    $line !~ /^\+.*\b(__asm__|asm)\b.*\\$/ &&	# asm
>  			    $line =~ /^\+.*\\$/) {
> -				WARN("LINE_CONTINUATIONS",
> -				     "Avoid unnecessary line continuations\n" . $herecurr);
> +				if (WARN("LINE_CONTINUATIONS",
> +					 "Avoid unnecessary line continuations\n" . $herecurr) &&

I prefer to not apply this.

Problem here is that these should generally be fixed by hand
as the automated fix isn't very good style either.

> +				    $fix) {
> +					$fixed[$fixlinenr] =~ s/\s*\\$//;
> +				}
>  			}
>  		}
>  

