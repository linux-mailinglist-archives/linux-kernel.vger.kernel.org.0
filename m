Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4B2BCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 03:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfE1BXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 21:23:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbfE1BXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 21:23:02 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6612BE665F8B3F37B701;
        Tue, 28 May 2019 09:22:59 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 09:22:55 +0800
Subject: Re: [PATCH v2] f2fs: ratelimit recovery messages
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <94025a6d-f485-3811-5521-ed5c9b4d1d77@huawei.com>
Date:   Tue, 28 May 2019 09:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2019/5/27 21:10, Sahitya Tummala wrote:
> Ratelimit the recovery logs, which are expected in case
> of sudden power down and which could result into too
> many prints.

FYI

https://lore.kernel.org/patchwork/patch/973837/

IMO, we need those logs to provide evidence during trouble-shooting of file data
corruption or file missing problem...

So I suggest we can keep log as it is in recover_dentry/recover_inode, and for
the log in do_recover_data, we can record recovery info [isize_kept,
recovered_count, err ...] into struct fsync_inode_entry, and print them in
batch, how do you think?

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v2:
>  - fix minor formatting and add new line for printk
> 
>  fs/f2fs/recovery.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index e04f82b..60d7652 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
>  		name = "<encrypted>";
>  	else
>  		name = raw_inode->i_name;
> -	f2fs_msg(inode->i_sb, KERN_NOTICE,
> -			"%s: ino = %x, name = %s, dir = %lx, err = %d",
> +	printk_ratelimited(KERN_NOTICE
> +			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
>  			__func__, ino_of_node(ipage), name,
>  			IS_ERR(dir) ? 0 : dir->i_ino, err);
>  	return err;
> @@ -292,8 +292,8 @@ static int recover_inode(struct inode *inode, struct page *page)
>  	else
>  		name = F2FS_INODE(page)->i_name;
>  
> -	f2fs_msg(inode->i_sb, KERN_NOTICE,
> -		"recover_inode: ino = %x, name = %s, inline = %x",
> +	printk_ratelimited(KERN_NOTICE
> +			"recover_inode: ino = %x, name = %s, inline = %x\n",
>  			ino_of_node(page), name, raw->i_inline);
>  	return 0;
>  }
> @@ -642,11 +642,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  err:
>  	f2fs_put_dnode(&dn);
>  out:
> -	f2fs_msg(sbi->sb, KERN_NOTICE,
> -		"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
> -		inode->i_ino,
> -		file_keep_isize(inode) ? "keep" : "recover",
> -		recovered, err);
> +	printk_ratelimited(KERN_NOTICE
> +			"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d\n",
> +			inode->i_ino,
> +			file_keep_isize(inode) ? "keep" : "recover",
> +			recovered, err);
>  	return err;
>  }
>  
> 
