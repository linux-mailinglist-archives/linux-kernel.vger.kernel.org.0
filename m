Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD8E30600
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 02:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEaAzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 20:55:31 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:53010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbfEaAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:55:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5ADDA837F252;
        Fri, 31 May 2019 00:55:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3870:3871:4321:5007:6119:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21221:21505:21627:30054:30070:30079:30091,0,RBL:172.58.27.55:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:34,LUA_SUMMARY:none
X-HE-Tag: watch56_12886697fdd3c
X-Filterd-Recvd-Size: 1865
Received: from XPS-9350 (unknown [172.58.27.55])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 00:55:27 +0000 (UTC)
Message-ID: <685e8554eed17eebc731d62336ef30eb44bd14f7.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Warn on duplicate sysctl local variable
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 30 May 2019 17:54:57 -0700
In-Reply-To: <20190530235101.3248-1-mcroce@redhat.com>
References: <20190530235101.3248-1-mcroce@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-31 at 01:51 +0200, Matteo Croce wrote:
> Commit 6a33853c5773 ("proc/sysctl: add shared variables for range check")
> adds some shared const variables to be used instead of a local copy in
> each source file.
> Warn when a chunk duplicates one of these values in a ctl_table struct:
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6639,6 +6639,13 @@ sub process {
>  				     "unknown module license " . $extracted_string . "\n" . $herecurr);
>  			}
>  		}
> +
> +# check for sysctl duplicate constants
> +		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
> +			my $extracted_string = get_quoted_string($line, $rawline);
> +			WARN("DUPLICATED_SYSCTL_CONST",
> +				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h" . $extracted_string . "\n" . $herecurr);
> +		}

why is $extracted_string used here?


