Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64796F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 04:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHUC0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 22:26:51 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:34080 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbfHUC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:26:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C9874181D33FC;
        Wed, 21 Aug 2019 02:26:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:4321:4605:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:14721:21080:21627:21740:21944:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: actor10_3b6f480e7015b
X-Filterd-Recvd-Size: 2398
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Aug 2019 02:26:48 +0000 (UTC)
Message-ID: <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
From:   Joe Perches <joe@perches.com>
To:     Caitlyn <caitlynannefinn@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Aug 2019 19:26:46 -0700
In-Reply-To: <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
         <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> Balanced braces to fix some checkpath warnings in inode.c and
> unzip_vle.c
[]
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
[]
> @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
>  	mutex_lock(&work->lock);
>  	nr_pages = work->nr_pages;
>  
> -	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> +	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
>  		pages = pages_onstack;
> -	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> -		 mutex_trylock(&z_pagemap_global_lock))
> +	} else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> +		 mutex_trylock(&z_pagemap_global_lock)) {

Extra space after tab

>  		pages = z_pagemap_global;
> -	else {
> +	} else {
>  repeat:
>  		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
>  				       GFP_KERNEL);
>  
>  		/* fallback to global pagemap for the lowmem scenario */
>  		if (unlikely(!pages)) {
> -			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
> +			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES) {
>  				goto repeat;
> -			else {
> +			} else {

Unnecessary else

>  				mutex_lock(&z_pagemap_global_lock);
>  				pages = z_pagemap_global;
>  			}


