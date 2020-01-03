Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6912F4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 07:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgACGtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 01:49:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgACGtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 01:49:15 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 70FA47B18BC9E4094F38;
        Fri,  3 Jan 2020 14:49:13 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 Jan 2020
 14:49:10 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: cover f2fs_lock_op in expand_inode_data
 case
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191218195324.17360-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <020ba9a5-7ebb-6b5f-d45c-5e8fd372569d@huawei.com>
Date:   Fri, 3 Jan 2020 14:49:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191218195324.17360-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/19 3:53, Jaegeuk Kim wrote:
> We were missing to cover f2fs_lock_op in this case.

Jaegeuk,

generic/269 will hang with this patch, and also bugzilla reports android
with last code will hang with the same stack.

Could you check this patch?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4ea9bf9e8701..0b74f94ac8ee 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1646,12 +1646,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  			if (err && err != -ENODATA && err != -EAGAIN)
>  				goto out_err;
>  		}
> -
> +		f2fs_lock_op(sbi);
>  		down_write(&sbi->pin_sem);
>  		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
>  		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
>  		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
>  		up_write(&sbi->pin_sem);
> +		f2fs_unlock_op(sbi);
>  
>  		done += map.m_len;
>  		len -= map.m_len;
> @@ -1661,7 +1662,9 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  
>  		map.m_len = done;
>  	} else {
> +		f2fs_lock_op(sbi);
>  		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
> +		f2fs_unlock_op(sbi);
>  	}
>  out_err:
>  	if (err) {
> 
