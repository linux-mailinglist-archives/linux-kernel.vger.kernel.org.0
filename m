Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA810C13F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 02:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfK1BFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 20:05:39 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:54653 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbfK1BFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:05:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 87FC31801AA99;
        Thu, 28 Nov 2019 01:05:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21221:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fang91_13c5142831d3f
X-Filterd-Recvd-Size: 2213
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Nov 2019 01:05:35 +0000 (UTC)
Message-ID: <34b6c8637bfe636b2b4880e536a190627bb1ee91.camel@perches.com>
Subject: Re: [PATCH 4/4] checkpatch: Drop pr_warning check
From:   Joe Perches <joe@perches.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, pmladek@suse.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, arnd@arndb.de,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Andy Whitcroft <apw@canonical.com>
Date:   Wed, 27 Nov 2019 17:05:08 -0800
In-Reply-To: <20191128004752.35268-5-wangkefeng.wang@huawei.com>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
         <20191128004752.35268-5-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-28 at 08:47 +0800, Kefeng Wang wrote:
> All pr_warning are removed from kernel, let's cleanup pr_warning
> check in checkpatch.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Assuming the other bits go in:

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 64890be3c8fd..447c0050eec0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4113,15 +4113,6 @@ sub process {
>  			     "Prefer [subsystem eg: netdev]_$level2([subsystem]dev, ... then dev_$level2(dev, ... then pr_$level(...  to printk(KERN_$orig ...\n" . $herecurr);
>  		}
>  
> -		if ($line =~ /\bpr_warning\s*\(/) {
> -			if (WARN("PREFER_PR_LEVEL",
> -				 "Prefer pr_warn(... to pr_warning(...\n" . $herecurr) &&
> -			    $fix) {
> -				$fixed[$fixlinenr] =~
> -				    s/\bpr_warning\b/pr_warn/;
> -			}
> -		}
> -
>  		if ($line =~ /\bdev_printk\s*\(\s*KERN_([A-Z]+)/) {
>  			my $orig = $1;
>  			my $level = lc($orig);

