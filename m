Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC751A3A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH3P0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:26:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3961 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbfH3P0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:26:03 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id DFDBD2D2AD8F25ECC514;
        Fri, 30 Aug 2019 23:26:00 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 23:26:00 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 30 Aug 2019 23:25:59 +0800
Date:   Fri, 30 Aug 2019 23:25:11 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v3 1/7] erofs: on-disk format should have explicitly
 assigned numbers
Message-ID: <20190830152511.GA39008@architecture4>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830033643.51019-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:36:37AM +0800, Gao Xiang wrote:
> As Christoph claimed [1], on-disk format should have
> explicitly assigned numbers. I have to change it.
> 
> [1] https://lore.kernel.org/r/20190829095954.GB20598@infradead.org/
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

...ignore this patchset. I will resend another incremental
patchset to address what Christoph suggested yesterday...

Thanks,
Gao Xiang

> ---
> no change
> 
>  fs/erofs/erofs_fs.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index afa7d45ca958..2447ad4d0920 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -52,10 +52,10 @@ struct erofs_super_block {
>   * 4~7 - reserved
>   */
>  enum {
> -	EROFS_INODE_FLAT_PLAIN,
> -	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
> -	EROFS_INODE_FLAT_INLINE,
> -	EROFS_INODE_FLAT_COMPRESSION,
> +	EROFS_INODE_FLAT_PLAIN			= 0,
> +	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
> +	EROFS_INODE_FLAT_INLINE			= 2,
> +	EROFS_INODE_FLAT_COMPRESSION		= 3,
>  	EROFS_INODE_LAYOUT_MAX
>  };
>  
> @@ -181,7 +181,7 @@ struct erofs_xattr_entry {
>  
>  /* available compression algorithm types */
>  enum {
> -	Z_EROFS_COMPRESSION_LZ4,
> +	Z_EROFS_COMPRESSION_LZ4	= 0,
>  	Z_EROFS_COMPRESSION_MAX
>  };
>  
> @@ -239,10 +239,10 @@ struct z_erofs_map_header {
>   *                (di_advise could be 0, 1 or 2)
>   */
>  enum {
> -	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN,
> -	Z_EROFS_VLE_CLUSTER_TYPE_HEAD,
> -	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD,
> -	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED,
> +	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
> +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
> +	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
> +	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
>  	Z_EROFS_VLE_CLUSTER_TYPE_MAX
>  };
>  
> -- 
> 2.17.1
> 
