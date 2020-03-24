Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6619140A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgCXPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:17:25 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:55732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727168AbgCXPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:17:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8D6D1182CED2A;
        Tue, 24 Mar 2020 15:17:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7522:9025:10004:10400:10848:11232:11658:11914:12043:12295:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: chair87_65693e825c5c
X-Filterd-Recvd-Size: 1739
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Mar 2020 15:17:23 +0000 (UTC)
Message-ID: <fb5a17c67f504f5761069ee446cc1b703dd8b54f.camel@perches.com>
Subject: Re: [PATCH] rearrange the output text, cosmetic changes
From:   Joe Perches <joe@perches.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, linux@leemhuis.info,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 24 Mar 2020 08:15:33 -0700
In-Reply-To: <20200324084513.18237-1-unixbhaskar@gmail.com>
References: <20200324084513.18237-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-24 at 14:15 +0530, Bhaskar Chowdhury wrote:
> As the subject like says, purely cosmetic changes to read cleanly.
> Jumbled up the line.

Subject line should show tools or kernel-chktaint

and:

> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
[]
> @@ -195,8 +195,9 @@ else
>  	echo " * kernel was built with the struct randomization plugin (#17)"
>  fi
> 
> -echo "For a more detailed explanation of the various taint flags see"
> -echo " Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel sources"
> -echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
>  echo "Raw taint value as int/string: $taint/'$out'"
> +echo
> +echo "For a more detailed explanation of the various taint flags see below pointers:"
> +echo "1) Documentation/admin-guide/tainted-kernels.rst in  the Linux kernel sources"

One extra space between "in  the"


