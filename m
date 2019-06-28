Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63AA5A01D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF1P77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1P76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:59:58 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D871D20828;
        Fri, 28 Jun 2019 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561737596;
        bh=SlP82znV2OC7MdqO29KK1B36hJIqNFdblP/sjEhF12w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvEtN3iN2/OmgCD7y14qVBt9dGQwwnPg4NW0dqXv/w/HwM9UwkHzlpJUnDlRorJ7l
         Ny/1sWFpfpUwFKU6A/bLJVqlMassrzrcyBXXhE8q8zpn1fi0OY4yPKCEqqg8W3A4TL
         sqCnIrxI0arf5dsrM27rrSVoiAUiUYqgzol3e0sg=
Date:   Fri, 28 Jun 2019 08:59:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chao Yu <yuchao0@huawei.com>, Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix 32-bit linking
Message-ID: <20190628155956.GB27114@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190628104007.2721479-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628104007.2721479-1-arnd@arndb.de>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

If you don't mind, can I integrate this into the original patch in the queue?

Thanks,

On 06/28, Arnd Bergmann wrote:
> Not all architectures support get_user() with a 64-bit argument:
> 
> ERROR: "__get_user_bad" [fs/f2fs/f2fs.ko] undefined!
> 
> Use copy_from_user() here, this will always work.
> 
> Fixes: d2ae7494d043 ("f2fs: ioctl for removing a range from F2FS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/f2fs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 998affe31419..465853029b8e 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3066,7 +3066,8 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
>  	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
> -	if (get_user(block_count, (__u64 __user *)arg))
> +	if (copy_from_user(&block_count, (void __user *)arg,
> +			   sizeof(block_count)))
>  		return -EFAULT;
>  
>  	ret = f2fs_resize_fs(sbi, block_count);
> -- 
> 2.20.0
