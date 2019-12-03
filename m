Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5F10FE78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 14:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLCNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 08:13:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38946 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLCNNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:13:06 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0A6C04729755A59EEE63;
        Tue,  3 Dec 2019 21:13:03 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 21:13:01 +0800
Subject: Re: [PATCH] UBI: fix use after free in ubi_remove_volume()
To:     Wen Yang <wenyang@linux.alibaba.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <xlpang@linux.alibaba.com>
References: <20191130093317.31352-1-wenyang@linux.alibaba.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <65b49705-e28c-e077-c0de-c5167e34d1c5@huawei.com>
Date:   Tue, 3 Dec 2019 21:13:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20191130093317.31352-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Hou Tao <houtao1@huawei.com>

On 2019/11/30 17:33, Wen Yang wrote:
> We can't use "vol" after it has been freed.
> 
> Fixes: 493cfaeaa0c9 ("mtd: utilize new cdev_device_add helper function")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mtd/ubi/vmt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 139ee13..8ff1478 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -375,7 +375,6 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
>  	}
>  
>  	cdev_device_del(&vol->cdev, &vol->dev);
> -	put_device(&vol->dev);
>  
>  	spin_lock(&ubi->volumes_lock);
>  	ubi->rsvd_pebs -= reserved_pebs;
> @@ -388,6 +387,8 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
>  	if (!no_vtbl)
>  		self_check_volumes(ubi);
>  
> +	put_device(&vol->dev);
> +
>  	return 0;
>  
>  out_err:
> 

