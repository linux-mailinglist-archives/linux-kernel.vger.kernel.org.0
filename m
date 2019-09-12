Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1413AB15B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfILVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 17:09:07 -0400
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:38089 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728249AbfILVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:09:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 529AE180A884F;
        Thu, 12 Sep 2019 21:09:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3871:4321:4605:5007:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12291:12297:12683:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: fog75_4f3e7db1c3c36
X-Filterd-Recvd-Size: 2110
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 21:09:04 +0000 (UTC)
Message-ID: <e4f60b3f68bd214261b946f34ea0459098da00c3.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Don't complain about nominal authors if
 there isn't one
From:   Joe Perches <joe@perches.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Sep 2019 14:09:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909121651180.1305-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1909121651180.1305-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 16:55 -0400, Alan Stern wrote:
> checkpatch.pl shouldn't warn about a "Missing Signed-off-by: line by
> nominal patch author" if there is no nominal patch author.  Without
> this change, checkpatch always gives me the following warning:
> 
>         WARNING: Missing Signed-off-by: line by nominal patch author ''

When/how does this occur?  Example please.

> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
>  scripts/checkpatch.pl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: usb-devel/scripts/checkpatch.pl
> ===================================================================
> --- usb-devel.orig/scripts/checkpatch.pl
> +++ usb-devel/scripts/checkpatch.pl
> @@ -6673,7 +6673,7 @@ sub process {
>                 if ($signoff == 0) {
>                         ERROR("MISSING_SIGN_OFF",
>                               "Missing Signed-off-by: line(s)\n");
> -               } elsif (!$authorsignoff) {
> +               } elsif ($author ne '' && !$authorsignoff) {
>                         WARN("NO_AUTHOR_SIGN_OFF",
>                              "Missing Signed-off-by: line by nominal patch author '$author'\n");
>                 }
> 

