Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239671318AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 20:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgAFT0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 14:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFT0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:26:33 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1921207FD;
        Mon,  6 Jan 2020 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578338792;
        bh=VqTyU2RlTLgSzL+Ruz0hd8I1VqsH4XlXPDI9GzRjKhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF9AnPuV6xe29dgVNaLfENYinKREP1vSQDAaZWjLgGFPhSoqUnN0bhj+HJ5afJxrS
         WZfDIS4wgMj2ume86S5efZdD+t929q+QSrFDG7mCvvm5EZxDesnrbib/PBNaPbB1e5
         uLFXiybTwHT11AS9w6i6oeREiY8YwQTejY6xI0Bw=
Date:   Mon, 6 Jan 2020 11:26:31 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 2/4] f2fs: compress: revert error path fix
Message-ID: <20200106192631.GF50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
 <20200106080144.52363-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106080144.52363-2-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Could you please check this out?
https://github.com/jaegeuk/f2fs/commits/g-dev-test

Thanks,

On 01/06, Chao Yu wrote:
> Revert incorrect fix in ("TEMP: f2fs: support data compression - fix1")
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index f993b4ce1970..fc4510729654 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -601,7 +601,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  							fgp_flag, GFP_NOFS);
>  		if (!page) {
>  			ret = -ENOMEM;
> -			goto release_pages;
> +			goto unlock_pages;
>  		}
>  
>  		if (PageUptodate(page))
> @@ -616,13 +616,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
>  						&last_block_in_bio, false);
>  		if (ret)
> -			goto unlock_pages;
> +			goto release_pages;
>  		if (bio)
>  			f2fs_submit_bio(sbi, bio, DATA);
>  
>  		ret = f2fs_init_compress_ctx(cc);
>  		if (ret)
> -			goto unlock_pages;
> +			goto release_pages;
>  	}
>  
>  	for (i = 0; i < cc->cluster_size; i++) {
> -- 
> 2.18.0.rc1
