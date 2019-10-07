Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EFCDF0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfJGKQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 06:16:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbfJGKQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16169B1FF;
        Mon,  7 Oct 2019 10:16:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D86701E481A; Fri,  4 Oct 2019 10:12:15 +0200 (CEST)
Date:   Fri, 4 Oct 2019 10:12:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] quota: code cleanup for hash bits calculation
Message-ID: <20191004081215.GB13650@quack2.suse.cz>
References: <20190923135223.27674-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923135223.27674-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-09-19 21:52:23, Chengguang Xu wrote:
> Code cleanup for hash bits calculation by
> calling ilog2().
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks! I've queued your patch.

								Honza

> ---
> v1->v2:
> - Calculate hash bits by directly calling ilog2().
> 
>  fs/quota/dquot.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..fde1b94ea587 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2983,11 +2983,7 @@ static int __init dquot_init(void)
>  
>  	/* Find power-of-two hlist_heads which can fit into allocation */
>  	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
> -	dq_hash_bits = 0;
> -	do {
> -		dq_hash_bits++;
> -	} while (nr_hash >> dq_hash_bits);
> -	dq_hash_bits--;
> +	dq_hash_bits = ilog2(nr_hash);
>  
>  	nr_hash = 1UL << dq_hash_bits;
>  	dq_hash_mask = nr_hash - 1;
> -- 
> 2.21.0
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
