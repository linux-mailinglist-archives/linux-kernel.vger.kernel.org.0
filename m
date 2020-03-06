Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2D17B8A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 09:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCFIv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 03:51:29 -0500
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:38779 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgCFIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:51:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BFF21837F24C;
        Fri,  6 Mar 2020 08:51:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:3872:4250:4321:5007:6119:7903:8603:10004:10400:10848:11026:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21990:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: can51_63e0f7d79f449
X-Filterd-Recvd-Size: 1688
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Mar 2020 08:51:26 +0000 (UTC)
Message-ID: <58c6e6dafabea52e5b030d18b83c13e4f43ab8e3.camel@perches.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   Joe Perches <joe@perches.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org
Cc:     shakeelb@google.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Date:   Fri, 06 Mar 2020 00:49:51 -0800
In-Reply-To: <20200305211632.15369-2-dxu@dxuuu.xyz>
References: <20200305211632.15369-1-dxu@dxuuu.xyz>
         <20200305211632.15369-2-dxu@dxuuu.xyz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 13:16 -0800, Daniel Xu wrote:
> It's not really necessary to have contiguous physical memory for xattr
> values. We no longer need to worry about higher order allocations
> failing with kvmalloc, especially because the xattr size limit is at
> 64K.

So why use vmalloc memory at all?

> diff --git a/fs/xattr.c b/fs/xattr.c
']
> @@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	if (len < sizeof(*new_xattr))
>  		return NULL;
>  
> -	new_xattr = kmalloc(len, GFP_KERNEL);
> +	new_xattr = kvmalloc(len, GFP_KERNEL);

Why is this sensible?
vmalloc memory is a much more limited resource.

Also, it seems as if the function should set
new_xattr->name to NULL before the return.


