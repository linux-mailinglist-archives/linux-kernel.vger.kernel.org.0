Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D508C4E538
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFUJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 05:58:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfFUJ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:58:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 173B27541006DC4FEB6F;
        Fri, 21 Jun 2019 17:58:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 17:58:31 +0800
Subject: Re: [PATCH] fsf2: Use DIV_ROUND_UP() instead of open-coding
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190620144208.28151-1-geert@linux-m68k.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <39883399-6a4d-7b61-5b8a-d5e39790c769@huawei.com>
Date:   Fri, 21 Jun 2019 17:58:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620144208.28151-1-geert@linux-m68k.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsf2: Use DIV_ROUND_UP() instead of open-coding

fsf2 -> f2fs

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

On 2019/6/20 22:42, Geert Uytterhoeven wrote:
> Replace the open-coded divisions with round-up by calls to the
> DIV_ROUND_UP() helper macro.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  fs/f2fs/f2fs.h    | 4 ++--
>  fs/f2fs/file.c    | 6 +++---
>  fs/f2fs/segment.h | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9afe15675dbbd369..52f477eaaee93bc3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -480,8 +480,8 @@ static inline int get_inline_xattr_addrs(struct inode *inode);
>  #define NR_INLINE_DENTRY(inode)	(MAX_INLINE_DATA(inode) * BITS_PER_BYTE / \
>  				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
>  				BITS_PER_BYTE + 1))
> -#define INLINE_DENTRY_BITMAP_SIZE(inode)	((NR_INLINE_DENTRY(inode) + \
> -					BITS_PER_BYTE - 1) / BITS_PER_BYTE)
> +#define INLINE_DENTRY_BITMAP_SIZE(inode) \
> +	DIV_ROUND_UP(NR_INLINE_DENTRY(inode), BITS_PER_BYTE)
>  #define INLINE_RESERVED_SIZE(inode)	(MAX_INLINE_DATA(inode) - \
>  				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
>  				NR_INLINE_DENTRY(inode) + \
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1180eca879331eba..fc00d8bdc31c18b0 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1211,7 +1211,7 @@ static int __exchange_data_block(struct inode *src_inode,
>  static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> +	pgoff_t nrpages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
>  	pgoff_t start = offset >> PAGE_SHIFT;
>  	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>  	int ret;
> @@ -1464,7 +1464,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  	pg_start = offset >> PAGE_SHIFT;
>  	pg_end = (offset + len) >> PAGE_SHIFT;
>  	delta = pg_end - pg_start;
> -	idx = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> +	idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
>  
>  	/* avoid gc operation during block exchange */
>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> @@ -2362,7 +2362,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  	if (!fragmented)
>  		goto out;
>  
> -	sec_num = (total + BLKS_PER_SEC(sbi) - 1) / BLKS_PER_SEC(sbi);
> +	sec_num = DIV_ROUND_UP(total, BLKS_PER_SEC(sbi));
>  
>  	/*
>  	 * make sure there are enough free section for LFS allocation, this can
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 166ac0f07a4e472d..2ae6df03b9982d12 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -109,7 +109,7 @@
>  #define	START_SEGNO(segno)		\
>  	(SIT_BLOCK_OFFSET(segno) * SIT_ENTRY_PER_BLOCK)
>  #define SIT_BLK_CNT(sbi)			\
> -	((MAIN_SEGS(sbi) + SIT_ENTRY_PER_BLOCK - 1) / SIT_ENTRY_PER_BLOCK)
> +	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK)
>  #define f2fs_bitmap_size(nr)			\
>  	(BITS_TO_LONGS(nr) * sizeof(unsigned long))
>  
> 
