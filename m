Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713B9137C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 09:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAKIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 03:40:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728620AbgAKIky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 03:40:54 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F1D7B65198CD1FD69F7;
        Sat, 11 Jan 2020 16:40:52 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 11 Jan 2020
 16:40:45 +0800
Subject: Re: [PATCH] ubifs: Fix deadlock in concurrent bulk-read and writepage
To:     Zhihao Cheng <chengzhihao1@huawei.com>, <richard@nod.at>,
        <s.hauer@pengutronix.de>, <ext-adrian.hunter@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1578663215-146583-1-git-send-email-chengzhihao1@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <d7f23b19-9bf2-014c-2d19-e39cb6c1db9a@huawei.com>
Date:   Sat, 11 Jan 2020 16:40:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578663215-146583-1-git-send-email-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zhihao

Not sure the side effects of dropping ui->ui_mutex in ubifs_bulk_read(),
the inode->i_size may be incorrect due to the concurrent truncate?

I think it's better to pass FGP_NOWAIT when invoking pagecache_get_page()
and stop bulk read when we failed to lock the page, thoughts?

Yi.

On 2020/1/10 21:33, Zhihao Cheng wrote:
> In ubifs, concurrent execution of writepage and bulk read on the same file
> may cause ABBA deadlock, for example (Reproduce method see Link):
> 
> Process A(Bulk-read starts from page4)         Process B(write page4 back)
>   vfs_read                                       wb_workfn or fsync
>   ...                                            ...
>   generic_file_buffered_read                     write_cache_pages
>     ubifs_readpage                                 LOCK(page4)
> 
>       ubifs_bulk_read                              ubifs_writepage
>         LOCK(ui->ui_mutex)                           ubifs_write_inode
> 
> 	  ubifs_do_bulk_read                           LOCK(ui->ui_mutex)
> 	    find_or_create_page(alloc page4)                  ↑
> 	      LOCK(page4)                   <--     ABBA deadlock occurs!
> 
> In order to ensure the serialization execution of bulk read, we can't
> remove the big lock 'ui->ui_mutex' in ubifs_bulk_read(). Instead, we add
> a new mutex lock for bulk read in ubifs_inode. ubifs_bulk_read() will be
> protected by the new mutex lock which replaces ui_mutex.
> It is confirmed that bulk-read (bulk read data member and process) and
> other members (which are protected by the ui_mutex in ubifs_inode) are
> independent of each other, including attr, dirty ("clean <-> dirty"
> transitions), ui_size (truncate process), etc.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Cc: <Stable@vger.kernel.org>
> Fixes: 4793e7c5e1c ("UBIFS: add bulk-read facility")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206153
> ---
>  fs/ubifs/file.c  | 21 +++++++++++++++++----
>  fs/ubifs/super.c |  1 +
>  fs/ubifs/ubifs.h |  7 +++++--
>  3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index cd52585..3e15c27 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -836,10 +836,23 @@ static int ubifs_bulk_read(struct page *page)
>  		return 0;
>  
>  	/*
> -	 * Bulk-read is protected by @ui->ui_mutex, but it is an optimization,
> -	 * so don't bother if we cannot lock the mutex.
> +	 * Bulk-read is protected by @ui->ui_bulk_read_mutex, ubifs_readpage()
> +	 * will all come here. If there are other concurrent read tasks during
> +	 * bulk-read, deadlock may occur, such as:
> +	 * Process A(Bulk-read starts from page4)   Process B(Read page4)
> +	 *   vfs_read                                 vfs_read
> +	 *     ...                                      ...
> +	 *     ubifs_readpage                           find_get_page(alloc page4)
> +	 *                                                add_to_page_cache_lru
> +	 *       ubifs_bulk_read                            LOCK(page4)
> +	 *         LOCK(ui->ui_bulk_read_mutex)         ubifs_readpage
> +	 *           ubifs_do_bulk_read                   ubifs_bulk_read
> +	 *                                                  LOCK(ui->ui_bulk_read_mutex)
> +	 *             find_or_create_page                         ↑
> +	 *               LOCK(page4)		       <-- ABBA deadlock occurs!
> +	 * So don't bother if we cannot lock the mutex.
>  	 */
> -	if (!mutex_trylock(&ui->ui_mutex))
> +	if (!mutex_trylock(&ui->ui_bulk_read_mutex))
>  		return 0;
>  
>  	if (index != last_page_read + 1) {
> @@ -884,7 +897,7 @@ static int ubifs_bulk_read(struct page *page)
>  		kfree(bu);
>  
>  out_unlock:
> -	mutex_unlock(&ui->ui_mutex);
> +	mutex_unlock(&ui->ui_bulk_read_mutex);
>  	return err;
>  }
>  
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 5e1e8ec..c4415b3 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -257,6 +257,7 @@ static struct inode *ubifs_alloc_inode(struct super_block *sb)
>  	memset((void *)ui + sizeof(struct inode), 0,
>  	       sizeof(struct ubifs_inode) - sizeof(struct inode));
>  	mutex_init(&ui->ui_mutex);
> +	mutex_init(&ui->ui_bulk_read_mutex);
>  	spin_lock_init(&ui->ui_lock);
>  	return &ui->vfs_inode;
>  };
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index c55f212..2ad596e 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -354,8 +354,10 @@ struct ubifs_gced_idx_leb {
>   * @xattr: non-zero if this is an extended attribute inode
>   * @bulk_read: non-zero if bulk-read should be used
>   * @ui_mutex: serializes inode write-back with the rest of VFS operations,
> - *            serializes "clean <-> dirty" state changes, serializes bulk-read,
> - *            protects @dirty, @bulk_read, @ui_size, and @xattr_size
> + *            serializes "clean <-> dirty" state changes,
> + *            protects @dirty, @ui_size, and @xattr_size
> + * @ui_bulk_read_mutex: serializes bulk-read, protects @bulk_read,
> + *                      @last_page_read and @read_in_a_row
>   * @ui_lock: protects @synced_i_size
>   * @synced_i_size: synchronized size of inode, i.e. the value of inode size
>   *                 currently stored on the flash; used only for regular file
> @@ -409,6 +411,7 @@ struct ubifs_inode {
>  	unsigned int bulk_read:1;
>  	unsigned int compr_type:2;
>  	struct mutex ui_mutex;
> +	struct mutex ui_bulk_read_mutex;
>  	spinlock_t ui_lock;
>  	loff_t synced_i_size;
>  	loff_t ui_size;
> 

