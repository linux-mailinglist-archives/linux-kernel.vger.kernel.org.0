Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9143AAC35B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406168AbfIFXsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 19:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405441AbfIFXsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:48:10 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1C620842;
        Fri,  6 Sep 2019 23:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567813689;
        bh=YaTVDRKaWZp6RtZVWL7bD2dch2Eb2d4uXQ0xopsEZSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKG6gBsYXRoodg6TXLwPJ0ERZ57ieDDf0M0hfRwkNClvG6iJDRgcUtfI+nZfsJhem
         bUj5rEwZHZIMACq3HZmc/H3689dIyRdJyRBaC3JCjg4msPyOqKreuOHo4K7oApOp9p
         odNdszgFPA3IoHoi/PePG68AQu64WPepnxTwH9CQ=
Date:   Fri, 6 Sep 2019 16:48:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized field of
 inode page in is_alive()
Message-ID: <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190906105426.109151-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906105426.109151-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06, Chao Yu wrote:
> If inode is newly created, inode page may not synchronize with inode cache,
> so fields like .i_inline or .i_extra_isize could be wrong, in below call
> path, we may access such wrong fields, result in failing to migrate valid
> target block.

If data is valid, how can we get new inode page?

> 
> - gc_data_segment
>  - is_alive
>   - datablock_addr
>    - offset_in_addr
> 
> Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 765f13354d3f..b1840852967e 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>  		if (IS_ERR(page))
>  			return page;
>  
> +		/* synchronize inode page's data from inode cache */
> +		f2fs_update_inode(inode, page);
> +
>  		if (S_ISDIR(inode->i_mode)) {
>  			/* in order to handle error case */
>  			get_page(page);
> -- 
> 2.18.0.rc1
