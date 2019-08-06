Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE16E82964
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 03:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfHFBrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 21:47:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728870AbfHFBrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:47:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B115AA66B9263ACAED0;
        Tue,  6 Aug 2019 09:47:06 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 09:47:00 +0800
Subject: Re: [PATCH resend v2] lib: scatterlist: Fix to support no mapped sg
To:     <robert.jarzmik@free.fr>, <axboe@fb.com>, <axboe@kernel.dk>,
        <gregkh@linuxfoundation.org>
References: <1563940463-95597-1-git-send-email-wangzhou1@hisilicon.com>
 <5D3E4F91.4020605@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5D48DC13.1020802@hisilicon.com>
Date:   Tue, 6 Aug 2019 09:46:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5D3E4F91.4020605@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/29 9:44, Zhou Wang wrote:
> On 2019/7/24 11:54, Zhou Wang wrote:
>> In function sg_split, the second sg_calculate_split will return -EINVAL
>> when in_mapped_nents is 0.
>>
>> Indeed there is no need to do second sg_calculate_split and sg_split_mapped
>> when in_mapped_nents is 0, as in_mapped_nents indicates no mapped entry in
>> original sgl.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>> v2: Just add Acked-by from Robert.
>>
>>  lib/sg_split.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/sg_split.c b/lib/sg_split.c
>> index 9982c63..60a0bab 100644
>> --- a/lib/sg_split.c
>> +++ b/lib/sg_split.c
>> @@ -176,11 +176,13 @@ int sg_split(struct scatterlist *in, const int in_mapped_nents,
>>  	 * The order of these 3 calls is important and should be kept.
>>  	 */
>>  	sg_split_phys(splitters, nb_splits);
>> -	ret = sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
>> -				 split_sizes, splitters, true);
>> -	if (ret < 0)
>> -		goto err;
>> -	sg_split_mapped(splitters, nb_splits);
>> +	if (in_mapped_nents) {
>> +		ret = sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
>> +					 split_sizes, splitters, true);
>> +		if (ret < 0)
>> +			goto err;
>> +		sg_split_mapped(splitters, nb_splits);
>> +	}
>>  
>>  	for (i = 0; i < nb_splits; i++) {
>>  		out[i] = splitters[i].out_sg;
>>
> 
> Hi Jens,
> 
> I saw you are the committer of sg_splite.c, could you help to take this patch?
> 
> Many thanks,
> Zhou
>

Anyone can help to take this fix?

Best,
Zhou

