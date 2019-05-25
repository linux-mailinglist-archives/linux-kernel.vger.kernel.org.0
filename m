Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7A2A330
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfEYGjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 02:39:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfEYGjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 02:39:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A65D8E51DCCD4520424E;
        Sat, 25 May 2019 14:39:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 14:39:19 +0800
Subject: =?UTF-8?Q?Re:_[PATCH_net]_staging:_Remove_set_but_not_used_variable?=
 =?UTF-8?B?IOKAmHN0YXR1c+KAmQ==?=
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20190525042642.78482-1-maowenan@huawei.com>
 <20190525050113.GB18684@kroah.com>
CC:     <jeremy@azazel.net>, <devel@driverdev.osuosl.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <68a66947-928c-d2e6-be2b-aa412613f90c@huawei.com>
Date:   Sat, 25 May 2019 14:39:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190525050113.GB18684@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/25 13:01, Greg KH wrote:
> On Sat, May 25, 2019 at 12:26:42PM +0800, Mao Wenan wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/staging/kpc2000/kpc_spi/spi_driver.c: In function
>> ‘kp_spi_transfer_one_message’:
>> drivers/staging/kpc2000/kpc_spi/spi_driver.c:282:9: warning: variable
>> ‘status’ set but not used [-Wunused-but-set-variable]
>>      int status = 0;
>>          ^~~~~~
>> The variable 'status' is not used any more, remve it.
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  drivers/staging/kpc2000/kpc_spi/spi_driver.c | 3 ---
>>  1 file changed, 3 deletions(-)
> 
> What is [PATCH net] in the subject for?  This is not a networking driver
> :(
Sorry, this is my mistake.
> 
> 
> .
> 

