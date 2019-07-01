Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79491E7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 07:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEOFTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 01:19:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfEOFTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:19:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3CBD5226CBCBF91AF1A7;
        Wed, 15 May 2019 13:19:01 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 15 May
 2019 13:18:53 +0800
Subject: Re: [PATCH] staging: erofs: drop unneeded -Wall addition
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>
References: <20190515043123.9106-1-yamada.masahiro@socionext.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <1a69420a-95c1-bd96-4382-229bcae391b0@huawei.com>
Date:   Wed, 15 May 2019 13:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190515043123.9106-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/15 12:31, Masahiro Yamada wrote:
> The top level Makefile adds -Wall globally:
> 
>   KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
> 
> I see two "-Wall" added for compiling objects in drivers/staging/erofs/.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Looks good to me and sorry about adding this flag...

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
> 
>  drivers/staging/erofs/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
> index 38ab344a285e..a34248a2a16a 100644
> --- a/drivers/staging/erofs/Makefile
> +++ b/drivers/staging/erofs/Makefile
> @@ -2,7 +2,7 @@
>  
>  EROFS_VERSION = "1.0pre1"
>  
> -ccflags-y += -Wall -DEROFS_VERSION=\"$(EROFS_VERSION)\"
> +ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
>  
>  obj-$(CONFIG_EROFS_FS) += erofs.o
>  # staging requirement: to be self-contained in its own directory
> 
