Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5AB180393
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCJQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgCJQck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:32:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DBD20848;
        Tue, 10 Mar 2020 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583857959;
        bh=/2iPAON56KiKp4VwG3w8X0u28X5Zi54HWAvPebGYCEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rb36kZ2IbhnZyB3p1V4V9GfgNg6bejDxx1CE6wjMZfT6YUH/psCRAb2RrJkPjMgH2
         Go0BJJKKyZ5lTjS5QhXBu42kon1eWwEY210z/9Ec+pBRGEjfzfyFtu+GiWsT6Os2CD
         XunWcletPjGcSg/F8kGYtouEaW6O5e0gn8UznE8s=
Date:   Tue, 10 Mar 2020 09:32:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 2/5] f2fs: force compressed data into warm area
Message-ID: <20200310163239.GC240315@google.com>
References: <20200310125009.12966-1-yuchao0@huawei.com>
 <20200310125009.12966-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310125009.12966-2-yuchao0@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Chao Yu wrote:
> Generally, data shows better continuity in warm data area as its
> default allocation direction is right, in order to enhance
> sequential read/write performance of compress inode, let's force
> compress data into warm area.

Not quite sure tho, compressed blocks are logically cold, no?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 601d67e72c50..ab1bc750712a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3037,9 +3037,10 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  	if (fio->type == DATA) {
>  		struct inode *inode = fio->page->mapping->host;
>  
> -		if (is_cold_data(fio->page) || file_is_cold(inode) ||
> -				f2fs_compressed_file(inode))
> +		if (is_cold_data(fio->page) || file_is_cold(inode))
>  			return CURSEG_COLD_DATA;
> +		if (f2fs_compressed_file(inode))
> +			return CURSEG_WARM_DATA;
>  		if (file_is_hot(inode) ||
>  				is_inode_flag_set(inode, FI_HOT_DATA) ||
>  				f2fs_is_atomic_file(inode) ||
> -- 
> 2.18.0.rc1
