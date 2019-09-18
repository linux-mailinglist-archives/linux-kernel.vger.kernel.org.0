Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2273B5F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfIRIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:34:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:58664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfIRIeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:34:19 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B5078A00FAE7FCD80D5B;
        Wed, 18 Sep 2019 16:34:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Sep 2019 16:34:15 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 18 Sep 2019 16:34:15 +0800
Date:   Wed, 18 Sep 2019 16:33:08 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] erofs: fix return value check in
 erofs_read_superblock()
Message-ID: <20190918083308.GA30134@architecture4>
References: <20190918083033.47780-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190918083033.47780-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongjun,

On Wed, Sep 18, 2019 at 08:30:33AM +0000, Wei Yongjun wrote:
> In case of error, the function read_mapping_page() returns
> ERR_PTR() not NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> Fixes: fe7c2423570d ("erofs: use read_mapping_page instead of sb_bread")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>


Right... That is my mistake on recent killing bh
transformation...

I have no idea this patch could be merged for -rc1
since I don't know Greg could still accept patches
or freezed...

Since it's an error handling path and trivial, if
it's some late, could I submit this later after
erofs is merged into mainline (if it's ok) for -rc1?
(or maybe -rc2?)

Thanks,
Gao Xiang

> ---
>  fs/erofs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index caf9a95173b0..0e369494f2f2 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -105,9 +105,9 @@ static int erofs_read_superblock(struct super_block *sb)
>  	int ret;
>  
>  	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
> -	if (!page) {
> +	if (IS_ERR(page)) {
>  		erofs_err(sb, "cannot read erofs superblock");
> -		return -EIO;
> +		return PTR_ERR(page);
>  	}
>  
>  	sbi = EROFS_SB(sb);
> 
> 
> 
