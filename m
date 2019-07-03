Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0C5DB57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 04:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfGCCHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 22:07:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGCCHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:07:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 457DCBC5A1295040C698;
        Wed,  3 Jul 2019 10:07:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 10:07:03 +0800
Subject: Re: [PATCH v2] f2fs: avoid out-of-range memory access
To:     Ocean Chen <oceanchen@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190702080503.175149-1-oceanchen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cfcd3737-3b03-87fe-39e8-566e545cab3a@huawei.com>
Date:   Wed, 3 Jul 2019 10:07:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190702080503.175149-1-oceanchen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ocean,

If filesystem is corrupted, it should fail mount due to below check in
f2fs_sanity_check_ckpt(), so we are safe in read_compacted_summaries() to access
entries[0,blk_off], right?

	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
			return 1;

Thanks,

On 2019/7/2 16:05, Ocean Chen wrote:
> blk_off might over 512 due to fs corrupt.
> Use ENTRIES_IN_SUM to protect invalid memory access.
> 
> v2:
> - fix typo
> Signed-off-by: Ocean Chen <oceanchen@google.com>
> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8dee063c833f..a5e8af0bd62e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>  
>  		for (j = 0; j < blk_off; j++) {
>  			struct f2fs_summary *s;
> +			if (j >= ENTRIES_IN_SUM)
> +				return -EFAULT;
>  			s = (struct f2fs_summary *)(kaddr + offset);
>  			seg_i->sum_blk->entries[j] = *s;
>  			offset += SUMMARY_SIZE;
> 
