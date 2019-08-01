Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654C67D2DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 03:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfHABbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 21:31:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3285 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfHABbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:31:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E2944ED38F34723C517A;
        Thu,  1 Aug 2019 09:31:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 09:31:23 +0800
Subject: Re: [PATCH 07/22] staging: erofs: remove redundant #include
 "internal.h"
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-8-gaoxiang25@huawei.com>
 <bae5fc5b-b2e1-0d74-6374-b1ae5835cbb9@huawei.com>
 <52072867-a9ae-5730-0ce4-47dd8dcb2d8c@huawei.com>
 <b261d2bf-bdc0-a418-1cac-dc142c7dc467@huawei.com>
 <14ac0fe7-1742-875b-b01a-78b49cae303a@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <efc9e26a-1a01-af2b-0e48-90b255b98348@huawei.com>
Date:   Thu, 1 Aug 2019 09:31:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <14ac0fe7-1742-875b-b01a-78b49cae303a@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/31 20:54, Gao Xiang wrote:
> 
> 
> On 2019/7/31 20:07, Chao Yu wrote:
>> Hi Xiang,
>>
>> On 2019/7/31 15:08, Gao Xiang wrote:
>>> Hi Chao,
>>>
>>> On 2019/7/31 15:03, Chao Yu wrote:
>>>> On 2019/7/29 14:51, Gao Xiang wrote:
>>>>> Because #include "internal.h" is included in xattr.h
>>>>
>>>> I think it would be better to remove "internal.h" in xattr.h, and include them
>>>> both in .c file in where we need xattr definition.
>>>
>>> It seems that all xattr related source files needing internal.h,
>>> and we need "EROFS_V(inode)", "struct erofs_sb_info", ... stuffs in xattr.h,
>>> which is defined in internal.h...
>>
>> Since I checked f2fs', it looks it's okay to don't include internal.h for
>> xattr.h, if .c needs xattr.h, we can just include interanl.h and xattr.h in the
>> head of it, it's safe.
> 
> I think xattr.h should be used independently (all dependencies of xattr.h should
> be included in xattr.h, most of include files behave like that)... Maybe it is
> not a good way to follow f2fs...

Yes, I've confirmed it's fine to do this, let's go ahead. :)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Thanks,
>>>>
>>> .
>>>
> .
> 
