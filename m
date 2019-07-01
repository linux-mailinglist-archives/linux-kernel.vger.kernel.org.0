Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D55BE69
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfGAOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 10:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfGAOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:38:02 -0400
Received: from [192.168.0.101] (unknown [49.65.245.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E06214AE;
        Mon,  1 Jul 2019 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561991881;
        bh=IrdLVTrOJB2ZPFcpqaowq4zGKbhkhofEJFmL32P0KBU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aBiWDjZKdNqFrpKJq+ZiO6RvDMwCvDyEDsOEevo6/IAsx3uBTTQCKMFsgPYAiyZNm
         KbmFLxI6tA+lORHfeN704ea8l6t3zDFmYR3jvu3KPss3FQQzp3Gc46agKCiFmIyqEI
         M8oWsloKkY3vmSvEk7dpawlIdyYaQFNeoWLOkDmo=
Subject: Re: [f2fs-dev] [PATCH] f2fs: use multiplication instead of division
 in sanity_check_raw_super
To:     Liu Song <fishland@aliyun.com>, jaegeuk@kernel.org,
        yuchao0@huawei.com
Cc:     liu.song11@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190701133841.3201-1-fishland@aliyun.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <c02efb8b-0ee0-665f-4b33-08ee694cc659@kernel.org>
Date:   Mon, 1 Jul 2019 22:37:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190701133841.3201-1-fishland@aliyun.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 2019-7-1 21:38, Liu Song via Linux-f2fs-devel wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Use multiplication instead of division and be more
> consistent with f2fs_msg output information.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index af58b2cc21b8..eba4c0f9c347 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2489,7 +2489,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  		return 1;
>  	}
>  
> -	if ((segment_count / segs_per_sec) < total_sections) {

I think we use division intentionally to avoid potential overflow when doing
multiplication.

You can see the detailed commit message in below fixing patch:

0cfe75c5b011 ("f2fs: enhance sanity_check_raw_super() to avoid potential overflows")

Thanks,

> +	if (segment_count < (segs_per_sec * total_sections)) {
>  		f2fs_msg(sb, KERN_INFO,
>  			"Small segment_count (%u < %u * %u)",
>  			segment_count, segs_per_sec, total_sections);
> 
