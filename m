Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6FA2FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfH3GZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:25:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbfH3GZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:25:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 60F2F1550EE73DC9E70F;
        Fri, 30 Aug 2019 14:25:55 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 14:25:49 +0800
Subject: Re: [PATCH v3 7/7] erofs: redundant assignment in
 __erofs_get_meta_page()
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Joe Perches" <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-7-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <82a5a7e0-eee2-0b57-f22f-1771b82a16f7@huawei.com>
Date:   Fri, 30 Aug 2019 14:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190830033643.51019-7-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/30 11:36, Gao Xiang wrote:
> As Joe Perches suggested [1],
>  		err = bio_add_page(bio, page, PAGE_SIZE, 0);
> -		if (unlikely(err != PAGE_SIZE)) {
> +		if (err != PAGE_SIZE) {
>  			err = -EFAULT;
>  			goto err_out;
>  		}
> 
> The initial assignment to err is odd as it's not
> actually an error value -E<FOO> but a int size
> from a unsigned int len.
> 
> Here the return is either 0 or PAGE_SIZE.
> 
> This would be more legible to me as:
> 
> 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
> 			err = -EFAULT;
> 			goto err_out;
> 		}
> 
> [1] https://lore.kernel.org/r/74c4784319b40deabfbaea92468f7e3ef44f1c96.camel@perches.com/
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
