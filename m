Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71659192D96
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 16:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCYP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 11:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbgCYP6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:58:07 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0202073E;
        Wed, 25 Mar 2020 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585151887;
        bh=yuKPw9zHwSe4jPNUbVFEbNmFqcIFFFDut0JgQS3oKmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+62TTJEnnakM8FVs3+TfAH+O1aXF1HvMmeMiJl/SqXlqkbVYSu62irvYLvhOUN74
         9ev7B2Xcdw4Owa+w+k2grU+BoD5RMypGl7iUXrhiOEp6YankzEDZfP3nlJ56BPJpPl
         /sEtWZSo85MnjUDhIvS/bwuNA1k8K0yE3Prk7BcM=
Date:   Wed, 25 Mar 2020 08:58:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH RFC] f2fs: don't inline compressed inode
Message-ID: <20200325155806.GC65658@google.com>
References: <20200325092754.63411-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325092754.63411-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25, Chao Yu wrote:
> f2fs_may_inline_data() only check compressed flag on current inode
> rather than on parent inode, however at this time compressed flag
> has not been inherited yet.

When write() or other allocation happens, it'll be reset.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> 
> Jaegeuk,
> 
> I'm not sure about this, whether inline_data flag can be compatible with
> compress flag, thoughts?
> 
>  fs/f2fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index f54119da2217..3807d1b4c4bc 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -86,7 +86,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>  	if (test_opt(sbi, INLINE_XATTR))
>  		set_inode_flag(inode, FI_INLINE_XATTR);
>  
> -	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
> +	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode) &&
> +					!f2fs_compressed_file(dir))
>  		set_inode_flag(inode, FI_INLINE_DATA);
>  	if (f2fs_may_inline_dentry(inode))
>  		set_inode_flag(inode, FI_INLINE_DENTRY);
> -- 
> 2.18.0.rc1
