Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC10183F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 03:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMCUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 22:20:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbgCMCUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:20:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D61035BC6EF8D275A173;
        Fri, 13 Mar 2020 10:20:09 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 13 Mar
 2020 10:20:05 +0800
Subject: Re: [PATCH] f2fs: fix long latency due to discard during umount
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1584011671-20939-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fa7d88ee-01e2-e82c-6c79-f24b90fbd472@huawei.com>
Date:   Fri, 13 Mar 2020 10:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1584011671-20939-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/12 19:14, Sahitya Tummala wrote:
> F2FS already has a default timeout of 5 secs for discards that
> can be issued during umount, but it can take more than the 5 sec
> timeout if the underlying UFS device queue is already full and there
> are no more available free tags to be used. In that case, submit_bio()
> will wait for the already queued discard requests to complete to get
> a free tag, which can potentially take way more than 5 sec.
> 
> Fix this by submitting the discard requests with REQ_NOWAIT
> flags during umount. This will return -EAGAIN for UFS queue/tag full
> scenario without waiting in the context of submit_bio(). The FS can
> then handle these requests by retrying again within the stipulated
> discard timeout period to avoid long latencies.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/segment.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index fb3e531..a06bbac 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1124,10 +1124,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
>  					&(dcc->fstrim_list) : &(dcc->wait_list);
> -	int flag = dpolicy->sync ? REQ_SYNC : 0;
> +	int flag;
>  	block_t lstart, start, len, total_len;
>  	int err = 0;
>  
> +	flag = dpolicy->sync ? REQ_SYNC : 0;
> +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
> +
>  	if (dc->state != D_PREP)
>  		return 0;
>  
> @@ -1203,6 +1206,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		bio->bi_end_io = f2fs_submit_discard_endio;
>  		bio->bi_opf |= flag;
>  		submit_bio(bio);
> +		if ((flag & REQ_NOWAIT) && (dc->error == -EAGAIN)) {

If we want to update dc->state, we need to cover it with dc->lock.

> +			dc->state = D_PREP;

BTW, one dc can be referenced by multiple bios, so dc->state could be updated to
D_DONE later by f2fs_submit_discard_endio(), however we just relocate it to
pending list... which is inconsistent status.

Thanks,

> +			err = dc->error;
> +			break;
> +		}
>  
>  		atomic_inc(&dcc->issued_discard);
>  
> @@ -1510,6 +1518,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  			}
>  
>  			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> +			if (dc->error == -EAGAIN) {
> +				congestion_wait(BLK_RW_ASYNC, HZ/50);
> +				__relocate_discard_cmd(dcc, dc);
> +			}
>  
>  			if (issued >= dpolicy->max_requests)
>  				break;
> 
