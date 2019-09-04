Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D137A973E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 01:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfIDXfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 19:35:02 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:41904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728008AbfIDXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:35:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4B4EA18224D7C;
        Wed,  4 Sep 2019 23:35:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:69:355:379:421:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2525:2559:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:7903:9010:9025:10004:10400:10848:10946:10967:11232:11658:11914:12043:12296:12297:12438:12555:12683:12740:12760:12895:13019:13069:13311:13357:13439:13548:14180:14181:14659:14721:14819:21060:21080:21451:21627:30054:30070:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: kiss88_e7d1a863eb12
X-Filterd-Recvd-Size: 2051
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Sep 2019 23:34:59 +0000 (UTC)
Message-ID: <6806d25a240cd80ebd265fcf5f02496852027bed.camel@perches.com>
Subject: Re: [GIT PULL] clang-format for v5.3-rc8
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 16:34:58 -0700
In-Reply-To: <20190904182949.GA22025@gmail.com>
References: <20190904182949.GA22025@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 20:29 +0200, Miguel Ojeda wrote:
> Hi Linus,
> 
> Please pull this trivial update for the .clang-format file.
> 
> Cheers,
> Miguel
> 
> The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:
> 
>   Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8
> 
> for you to fetch changes up to 52d083472e0b64d1da5b6469ed3defb1ddc45929:
> 
>   clang-format: Update with the latest for_each macro list (2019-08-31 10:00:51 +0200)
> 
> ----------------------------------------------------------------
> clang-format update for 5.3
> 
> ----------------------------------------------------------------
> Miguel Ojeda (1):
>       clang-format: Update with the latest for_each macro list
> 
>  .clang-format | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

It's a long, long list.

$ git grep -P -h '^\s*#\s*define\s+\w*for_each\w*' | \
  grep -P -oh '\w+for_each\w*' | sort | uniq | wc -l
491

Isn't there some way to regexes or automate this?

Maybe just:
$ git grep -P -h '^\s*#\s*define\s+\w*for_each\w*' | \
  grep -P -oh '\w+for_each\w*' | sort | uniq > somefile...



