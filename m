Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18611801C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCJP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 11:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgCJP1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:27:19 -0400
Received: from [192.168.0.107] (unknown [117.89.210.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559CA20578;
        Tue, 10 Mar 2020 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583854039;
        bh=zkJ/Qq9oLoVH+s4+41brSYvvL5jdsRF7cJDAHbNUSRE=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=1yEkke95RfXMVwnDFxPRDOWM7JJXcFL82SV7/dpNGtu1Fg9IWsWE8OWU3gknzl4m6
         /ZfukMh03tIZhU8+1uk8DLWkVwjaU0axChTUs7cRCLYilFL/qx6okU1snmiPKX69dR
         20AKqlQFigPpdJxyI9a4At04pTxlI6eQk5q5ZH+A=
Subject: Re: [PATCH] f2fs: fix to check i_compr_blocks correctly
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
References: <20200225102646.43367-1-yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
Message-ID: <3525f924-7d65-c005-a7e6-d315cf14aab2@kernel.org>
Date:   Tue, 10 Mar 2020 23:26:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200225102646.43367-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2020-2-25 18:26, Chao Yu wrote:
> inode.i_blocks counts based on 512byte sector, we need to convert
> to 4kb sized block count before comparing to i_compr_blocks.
>
> In addition, add to print message when sanity check on inode
> compression configs failed.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 156cc5ef3044..299611562f7e 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -291,13 +291,30 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  			fi->i_flags & F2FS_COMPR_FL &&
>  			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
>  						i_log_cluster_size)) {
> -		if (ri->i_compress_algorithm >= COMPRESS_MAX)
> +		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> +				"compress algorithm: %u, run fsck to fix",
> +				  __func__, inode->i_ino,
> +				  ri->i_compress_algorithm);
>  			return false;
> -		if (le64_to_cpu(ri->i_compr_blocks) > inode->i_blocks)
> +		}
> +		if (le64_to_cpu(ri->i_compr_blocks) >
> +				SECTOR_TO_BLOCK(inode->i_blocks)) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) hash inconsistent "

This is a typo: hash -> has

Could you please manually fix this in your tree?

Thanks

> +				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
> +				  __func__, inode->i_ino,
> +				  le64_to_cpu(ri->i_compr_blocks),
> +				  SECTOR_TO_BLOCK(inode->i_blocks));
>  			return false;
> +		}
>  		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> -			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE)
> +			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> +				"log cluster size: %u, run fsck to fix",
> +				  __func__, inode->i_ino,
> +				  ri->i_log_cluster_size);
>  			return false;
> +		}
>  	}
>
>  	return true;
>
