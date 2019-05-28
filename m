Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACA2C375
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE1JpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 05:45:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfE1JpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:45:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E72DD669530DE55BEF17;
        Tue, 28 May 2019 17:45:20 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 17:45:15 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: fix i_blocks calculation
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190528023147.94117-2-gaoxiang25@huawei.com>
 <20190528023602.178923-1-gaoxiang25@huawei.com>
 <fe0ff7bb-b576-f949-d57a-2892d116b22f@huawei.com>
 <20190528065709.GY31203@kadam>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8bbeb607-a18b-aeee-1668-501ad65ba230@huawei.com>
Date:   Tue, 28 May 2019 17:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190528065709.GY31203@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/28 14:57, Dan Carpenter wrote:
> On Tue, May 28, 2019 at 11:02:12AM +0800, Chao Yu wrote:
>> On 2019/5/28 10:36, Gao Xiang wrote:
>>> For compressed files, i_blocks should not be calculated
>>> by using i_size. i_u.compressed_blocks is used instead.
>>>
>>> In addition, i_blocks was miscalculated for non-compressed
>>> files previously, fix it as well.
>>>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>> ---
>>> change log v2:
>>>  - fix description in commit message
>>>  - fix to 'inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK'
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>  drivers/staging/erofs/inode.c | 14 ++++++++++++--
>>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
>>> index 8da144943ed6..6e67e018784e 100644
>>> --- a/drivers/staging/erofs/inode.c
>>> +++ b/drivers/staging/erofs/inode.c
>>> @@ -20,6 +20,7 @@ static int read_inode(struct inode *inode, void *data)
>>>  	struct erofs_vnode *vi = EROFS_V(inode);
>>>  	struct erofs_inode_v1 *v1 = data;
>>>  	const unsigned int advise = le16_to_cpu(v1->i_advise);
>>> +	erofs_blk_t nblks = 0;
>>>  
>>>  	vi->data_mapping_mode = __inode_data_mapping(advise);
>>>  
>>> @@ -60,6 +61,10 @@ static int read_inode(struct inode *inode, void *data)
>>>  			le32_to_cpu(v2->i_ctime_nsec);
>>>  
>>>  		inode->i_size = le64_to_cpu(v2->i_size);
>>> +
>>> +		/* total blocks for compressed files */
>>> +		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
>>> +			nblks = v2->i_u.compressed_blocks;
>>
>> Xiang,
>>
>> It needs to use le32_to_cpu(). ;)
>>
> 
> I wonder it the kbuild bot is going to send an email about that...

0-day may do this a little later.

> Hopefully these sorts of bugs get detected with Sparse CF=-D__CHECK_ENDIAN__

Thanks, Dan, let's use this sparse flag more frequently to avoid such issue.

Thanks,

> 
> regards,
> dan carpenter
> 
> .
> 
