Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43C79026
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfG2QBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfG2QBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:01:06 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEDE121773;
        Mon, 29 Jul 2019 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564416065;
        bh=zsjK32URpw9E8xLWXuq6yO1piXT5U7FJRiPetxczkY8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o8LQ/PbTkEysPkQh7s5MVgRkrgiRvXMDYlm8omA3B0CBInsniNIHXTNJ2PZJsNi1Z
         JueR51t44xI69CjyVNWrfVCorx+hK+Dn0qG5uc666cyg8aS3049O10gSFQDYEdpotu
         owo+G2PTA73CG0Z0jbYWREIAYkSdj950MAFQl9b0=
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix indefinite loop in f2fs_gc()
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
References: <1564377626-12898-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a5acb5cb-2e77-902f-0a5e-063f7cbd0643@kernel.org>
Date:   Tue, 30 Jul 2019 00:00:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1564377626-12898-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2019-7-29 13:20, Sahitya Tummala wrote:
> Policy - foreground GC, LFS mode and greedy GC mode.
> 
> Under this policy, f2fs_gc() loops forever to GC as it doesn't have
> enough free segements to proceed and thus it keeps calling gc_more
> for the same victim segment.  This can happen if the selected victim
> segment could not be GC'd due to failed blkaddr validity check i.e.
> is_alive() returns false for the blocks set in current validity map.
> 
> Fix this by not resetting the sbi->cur_victim_sec to NULL_SEGNO, when
> the segment selected could not be GC'd. This helps to select another
> segment for GC and thus helps to proceed forward with GC.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 8974672..7bbcc4a 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1303,7 +1303,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  		round++;
>  	}
>  
> -	if (gc_type == FG_GC)
> +	if (gc_type == FG_GC && seg_freed)
>  		sbi->cur_victim_sec = NULL_SEGNO;

In some cases, we may remain last victim in sbi->cur_victim_sec, and jump out of
GC cycle, then SSR can skip the last victim due to sec_usage_check()...

Thanks,

>  
>  	if (sync)
> 
