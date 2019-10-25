Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A866AE47B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394354AbfJYJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 05:45:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392769AbfJYJpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:45:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EE3213F827BF640EF8BF;
        Fri, 25 Oct 2019 17:45:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 17:45:31 +0800
Subject: Re: [PATCH] crypto: qat - remove redundant condition accel_dev->is_vf
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <qat-linux@intel.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <78b1532c-f8bf-48e4-d0a7-30ea0137d408@huawei.com>
 <CAKv+Gu_MVe8mEeC-fVVbbLfUv-rEEk5_eoxfHjTCMgAFmSHrJw@mail.gmail.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <0b95f573-548b-4cec-e433-ef0ef16229cf@huawei.com>
Date:   Fri, 25 Oct 2019 17:45:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_MVe8mEeC-fVVbbLfUv-rEEk5_eoxfHjTCMgAFmSHrJw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/25 17:33, Ard Biesheuvel wrote:
> On Fri, 25 Oct 2019 at 09:24, Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>>
>> Warning is found by the code analysis tool:
>>   "Redundant condition: accel_dev->is_vf"
>>
>> So remove the redundant condition accel_dev->is_vf.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  drivers/crypto/qat/qat_common/adf_dev_mgr.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/crypto/qat/qat_common/adf_dev_mgr.c b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
>> index 2d06409bd3c4..b54b8850fe20 100644
>> --- a/drivers/crypto/qat/qat_common/adf_dev_mgr.c
>> +++ b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
>> @@ -196,7 +196,7 @@ int adf_devmgr_add_dev(struct adf_accel_dev *accel_dev,
>>         atomic_set(&accel_dev->ref_count, 0);
>>
>>         /* PF on host or VF on guest */
>> -       if (!accel_dev->is_vf || (accel_dev->is_vf && !pf)) {
>> +       if (!accel_dev->is_vf || !pf) {
> 
> I disagree with this change. There is no bug here, and the way the
> condition is formulated self-documents the code, i.e.,
> 
> IF NOT is_vf
> OR (is_vf BUT NOT pf)
> 
> Using an automated tool to reduce every boolean expression to its
> minimal representation doesn't seem that useful to me, since the
> compiler is perfectly capable of doing that when generating the object
> code.
> 
ok, thanks, this modify just fix warning, and make code simple.

> 
> 
> 
>>                 struct vf_id_map *map;
>>
>>                 list_for_each(itr, &accel_table) {
>> @@ -292,7 +292,7 @@ void adf_devmgr_rm_dev(struct adf_accel_dev *accel_dev,
>>                        struct adf_accel_dev *pf)
>>  {
>>         mutex_lock(&table_lock);
>> -       if (!accel_dev->is_vf || (accel_dev->is_vf && !pf)) {
>> +       if (!accel_dev->is_vf || !pf) {
>>                 id_map[accel_dev->accel_id] = 0;
>>                 num_devices--;
>>         } else if (accel_dev->is_vf && pf) {
>> --
>> 2.7.4
>>
> 
> .
> 

