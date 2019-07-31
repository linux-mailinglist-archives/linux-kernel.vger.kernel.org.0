Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C957C7BB70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGaIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 04:20:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727360AbfGaIUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:20:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7FDAE5F03F7CD10F6D0F;
        Wed, 31 Jul 2019 16:20:11 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 16:20:03 +0800
Subject: Re: [PATCH 12/22] staging: erofs: refine erofs_allocpage()
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-13-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e0a7e012-813c-7313-fecf-3673562aa107@huawei.com>
Date:   Wed, 31 Jul 2019 16:20:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729065159.62378-13-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/29 14:51, Gao Xiang wrote:
> remove duplicated code in decompressor by introducing
> failable erofs_allocpage().
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/decompressor.c | 12 +++---------
>  drivers/staging/erofs/internal.h     |  2 +-
>  drivers/staging/erofs/utils.c        |  5 +++--
>  drivers/staging/erofs/zdata.c        |  2 +-
>  4 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
> index ee5762351f80..744c43a456e9 100644
> --- a/drivers/staging/erofs/decompressor.c
> +++ b/drivers/staging/erofs/decompressor.c
> @@ -74,15 +74,9 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  			victim = availables[--top];
>  			get_page(victim);
>  		} else {
> -			if (!list_empty(pagepool)) {
> -				victim = lru_to_page(pagepool);
> -				list_del(&victim->lru);
> -				DBG_BUGON(page_ref_count(victim) != 1);
> -			} else {
> -				victim = alloc_pages(GFP_KERNEL, 0);
> -				if (!victim)
> -					return -ENOMEM;
> -			}
> +			victim = erofs_allocpage(pagepool, GFP_KERNEL, false);
> +			if (unlikely(!victim))
> +				return -ENOMEM;
>  			victim->mapping = Z_EROFS_MAPPING_STAGING;
>  		}
>  		rq->out[i] = victim;
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index b206a85776b4..e35c7d8f75d2 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -517,7 +517,7 @@ int erofs_namei(struct inode *dir, struct qstr *name,
>  extern const struct file_operations erofs_dir_fops;
>  
>  /* utils.c / zdata.c */
> -struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
> +struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail);
>  
>  #if (EROFS_PCPUBUF_NR_PAGES > 0)
>  void *erofs_get_pcpubuf(unsigned int pagenr);
> diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
> index 0e86e44d60d0..260ea2970b4b 100644
> --- a/drivers/staging/erofs/utils.c
> +++ b/drivers/staging/erofs/utils.c
> @@ -9,15 +9,16 @@
>  #include "internal.h"
>  #include <linux/pagevec.h>
>  
> -struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
> +struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail)
>  {
>  	struct page *page;
>  
>  	if (!list_empty(pool)) {
>  		page = lru_to_page(pool);
> +		DBG_BUGON(page_ref_count(page) != 1);
>  		list_del(&page->lru);
>  	} else {
> -		page = alloc_pages(gfp | __GFP_NOFAIL, 0);
> +		page = alloc_pages(gfp | (nofail ? __GFP_NOFAIL : 0), 0);
>  	}
>  	return page;
>  }
> diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
> index bc478eebf509..02560b940558 100644
> --- a/drivers/staging/erofs/zdata.c
> +++ b/drivers/staging/erofs/zdata.c
> @@ -634,7 +634,7 @@ z_erofs_vle_work_iter_end(struct z_erofs_vle_work_builder *builder)
>  static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
>  					       gfp_t gfp)
>  {
> -	struct page *page = erofs_allocpage(pagepool, gfp);
> +	struct page *page = erofs_allocpage(pagepool, gfp, true);
>  
>  	if (unlikely(!page))
>  		return NULL;

Should remove it.

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
