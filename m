Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8587C0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfGaMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:07:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfGaMHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:07:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7ED71FC8A3E7D1975919;
        Wed, 31 Jul 2019 20:07:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 20:07:03 +0800
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
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b261d2bf-bdc0-a418-1cac-dc142c7dc467@huawei.com>
Date:   Wed, 31 Jul 2019 20:07:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52072867-a9ae-5730-0ce4-47dd8dcb2d8c@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2019/7/31 15:08, Gao Xiang wrote:
> Hi Chao,
> 
> On 2019/7/31 15:03, Chao Yu wrote:
>> On 2019/7/29 14:51, Gao Xiang wrote:
>>> Because #include "internal.h" is included in xattr.h
>>
>> I think it would be better to remove "internal.h" in xattr.h, and include them
>> both in .c file in where we need xattr definition.
> 
> It seems that all xattr related source files needing internal.h,
> and we need "EROFS_V(inode)", "struct erofs_sb_info", ... stuffs in xattr.h,
> which is defined in internal.h...

Since I checked f2fs', it looks it's okay to don't include internal.h for
xattr.h, if .c needs xattr.h, we can just include interanl.h and xattr.h in the
head of it, it's safe.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
> .
> 
