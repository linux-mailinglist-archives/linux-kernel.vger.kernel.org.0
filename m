Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC917D6F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 00:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgCHXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 19:07:08 -0400
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:60162 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbgCHXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:07:07 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id D00E018028203
        for <linux-kernel@vger.kernel.org>; Sun,  8 Mar 2020 23:07:06 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1F50C4FFA;
        Sun,  8 Mar 2020 23:07:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:3873:3874:4321:5007:6119:7514:7522:7903:10004:10400:10848:11232:11658:11914:12043:12048:12297:12555:12740:12760:12895:13069:13071:13161:13184:13229:13311:13357:13439:14096:14097:14180:14181:14659:14721:21080:21451:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: alarm80_77fb7776f6e04
X-Filterd-Recvd-Size: 2174
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 23:07:04 +0000 (UTC)
Message-ID: <f1327099b774e141bbeaa8abc47f98b9c6d49264.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8188eu: Add space around
 operators
From:   Joe Perches <joe@perches.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Date:   Sun, 08 Mar 2020 16:05:25 -0700
In-Reply-To: <20200308220004.9960-1-shreeya.patel23498@gmail.com>
References: <20200308220004.9960-1-shreeya.patel23498@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 03:30 +0530, Shreeya Patel wrote:
> Add space around operators for improving the code
> readability.

Hello again Shreeya.

The subject isn't really quite appropriate as you
are not doing this space around operator addition
for the entire subsystem.

IMO, the subject should be:

[PATCH] staging: rtl8188eu: rtw_mlme: Add spaces around operators

because you are only performing this change on this
single file.

If you were to do this for every single file in the
subsystem, you could have many individual patches with
the exact same subject line.

And it would be good to show in the changelog that you
have compiled the file pre and post patch without object
code change.

Also, it's good to show that git diff -w shows no source
file changes.

> Reported by checkpatch.pl
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme.c | 40 +++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

When I try this using checkpatch --fix-inplace, I get
21 changes against the latest -next tree.

What tree are you doing this against?


