Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D32160814
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 03:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgBQCWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 21:22:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgBQCWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:22:30 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 39052640039451A6E54E;
        Mon, 17 Feb 2020 10:22:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Feb
 2020 10:22:23 +0800
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: skip migration only when BG_GC is
 called
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
 <20200214185855.217360-3-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9c497f3e-3399-e4a6-f81c-6c4a1f35e5bb@huawei.com>
Date:   Mon, 17 Feb 2020 10:22:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200214185855.217360-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/15 2:58, Jaegeuk Kim wrote:
> FG_GC needs to move entire section more quickly.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index bbf4db3f6bb4..1676eebc8c8b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1203,7 +1203,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  
>  		if (get_valid_blocks(sbi, segno, false) == 0)
>  			goto freed;
> -		if (__is_large_section(sbi) &&
> +		if (gc_type == BG_GC && __is_large_section(sbi) &&
>  				migrated >= sbi->migration_granularity)

I knew migrating one large section is a more efficient way, but this can
increase long-tail latency of f2fs_balance_fs() occasionally, especially in
extreme fragmented space.

Thanks,

>  			goto skip;
>  		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
> 
