Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B709E163A89
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 03:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgBSCvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 21:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbgBSCvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:51:55 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4967207FD;
        Wed, 19 Feb 2020 02:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582080714;
        bh=/yXdGWmYsKqPX70bTTNAr64nklyYO6iG2lgGEie9/Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XR9V1FR5JQ/VnRmYbFVz1VJC0jUNv0LCv0L90Zs0t1FInM2sK6BPB89oh2nVAnsjz
         1j8gWFCFmU3WBZ3o9K+XChjUjepAn00v8laLChhyc8WbUiZBkikuMGO+kbtxc8yiWM
         DcYckPYwAfceieD0lL4raxeXnD9eOSbbAd3roLCk=
Date:   Tue, 18 Feb 2020 18:51:54 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: avoid unneeded barrier in do_checkpoint()
Message-ID: <20200219025154.GB96609@google.com>
References: <20200218102136.32150-1-yuchao0@huawei.com>
 <20200218102136.32150-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218102136.32150-3-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18, Chao Yu wrote:
> We don't need to wait all dirty page submitting IO twice,
> remove unneeded wait step.

What happens if checkpoint and other meta writs are reordered?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 751815cb4c2b..9c88fb3d255a 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1384,8 +1384,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	/* Flush all the NAT/SIT pages */
>  	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
> -	/* Wait for all dirty meta pages to be submitted for IO */
> -	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
>  
>  	/*
>  	 * modify checkpoint
> -- 
> 2.18.0.rc1
