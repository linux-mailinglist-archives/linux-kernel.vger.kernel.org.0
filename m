Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19B91867E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEIIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 04:03:48 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:40533 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfEIIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:03:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A754C180A8437;
        Thu,  9 May 2019 08:03:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3871:3876:4321:5007:6299:8603:10004:10400:10848:11026:11658:11914:12048:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21740:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: crown87_3c409a1aa411
X-Filterd-Recvd-Size: 1325
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 May 2019 08:03:45 +0000 (UTC)
Message-ID: <3d1911051672d4d84b46dfa229b8c82c4a41813b.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add command-line option for TAB size
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 09 May 2019 01:03:44 -0700
In-Reply-To: <20190509072104.18734-1-borneo.antonio@gmail.com>
References: <20190509072104.18734-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-09 at 09:21 +0200, Antonio Borneo wrote:
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2224,7 +2229,7 @@ sub string_find_replace {
>  sub tabify {
>  	my ($leading) = @_;
>  
> -	my $source_indent = 8;
> +	my $source_indent = $tabsize;
>  	my $max_spaces_before_tab = $source_indent - 1;

I didn't test this.

Does this work properly if --tab-size=1 ?
Maybe die if ($tabsize < 2); is necessary?


