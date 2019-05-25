Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBD62A4C2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfEYN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 09:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfEYN44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 09:56:56 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373352168B;
        Sat, 25 May 2019 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558792616;
        bh=pwh+PE1rIFMiucNrJB1PXbcLOVclHdgZZ2LaqpxP554=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ilAebpZH2hacVJgxmI6tRgAWR5NN7XkrnbFU8biTFZu1/IMcbGp2uQleO0CpufcU2
         A1dGHalWwmwLBZKVqarucf9nLmCU3fjfFnAirjMI7tACOjcjhaJx7xGxQnJFiflz1+
         Rgg3LEEHKTY5XxDMXdFx7MKzIFsqXFZhad9FkmZI=
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Make sanity_check_curseg static
To:     YueHaibing <yuehaibing@huawei.com>, jaegeuk@kernel.org,
        yuchao0@huawei.com
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190525124809.17424-1-yuehaibing@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <33f73a57-285d-e37e-f911-6f3ad5cc6e01@kernel.org>
Date:   Sat, 25 May 2019 21:56:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190525124809.17424-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haibing,

Thanks for the patch, there is a similar report from 0-day project, but I forget
to fix my v1 patch.

Anyway, I prefer to merge this into original patch which has not upstreamed yet. :)

Thanks,

On 2019-5-25 20:48, YueHaibing wrote:
> Fix sparse warning:
> 
> fs/f2fs/segment.c:4246:5: warning:
>  symbol 'sanity_check_curseg' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1a83115284b9..51f57393ad5b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4243,7 +4243,7 @@ static int build_dirty_segmap(struct f2fs_sb_info *sbi)
>  	return init_victim_secmap(sbi);
>  }
>  
> -int sanity_check_curseg(struct f2fs_sb_info *sbi)
> +static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>  {
>  	int i;
>  
> 
