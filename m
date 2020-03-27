Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3911195E90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgC0TYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 15:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0TYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:24:13 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A713206E6;
        Fri, 27 Mar 2020 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585337052;
        bh=qt6SbvEQShuKIl/6a/6slI+vmFBgRwo48MnklEokrOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxARzqqdtgKfS3KjIlCaVHSzxYdqXgoeK01ef4pGrKZHx7IBEWmP6//vU0itLS1ZA
         /3s2iEbTmyJe1ek/xLn0FpWvYOyLvO8Obm3GNc+HhIJVHUYCCezTpT/nVdQG7C/asF
         J/pDGPCYUWB0WCHDi1+29HrTPxs9kR/XaxyFIaGQ=
Date:   Fri, 27 Mar 2020 12:24:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: prevent meta updates while checkpoint is in
 progress
Message-ID: <20200327192412.GA186975@google.com>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 03/26, Sahitya Tummala wrote:
> allocate_segment_for_resize() can cause metapage updates if
> it requires to change the current node/data segments for resizing.
> Stop these meta updates when there is a checkpoint already
> in progress to prevent inconsistent CP data.

Doesn't freeze|thaw_bdev(sbi->sb->s_bdev); work for you?

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/gc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5bca560..6122bad 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1399,8 +1399,10 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
>  	int err = 0;
>  
>  	/* Move out cursegs from the target range */
> +	f2fs_lock_op(sbi);
>  	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
>  		allocate_segment_for_resize(sbi, type, start, end);
> +	f2fs_unlock_op(sbi);
>  
>  	/* do GC to move out valid blocks in the range */
>  	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
