Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A517BA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGaHJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 03:09:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfGaHJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:09:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 29B0120612329D04C2D0;
        Wed, 31 Jul 2019 15:09:04 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 15:08:58 +0800
Subject: Re: [PATCH 07/22] staging: erofs: remove redundant #include
 "internal.h"
To:     Chao Yu <yuchao0@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-8-gaoxiang25@huawei.com>
 <bae5fc5b-b2e1-0d74-6374-b1ae5835cbb9@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <52072867-a9ae-5730-0ce4-47dd8dcb2d8c@huawei.com>
Date:   Wed, 31 Jul 2019 15:08:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <bae5fc5b-b2e1-0d74-6374-b1ae5835cbb9@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2019/7/31 15:03, Chao Yu wrote:
> On 2019/7/29 14:51, Gao Xiang wrote:
>> Because #include "internal.h" is included in xattr.h
> 
> I think it would be better to remove "internal.h" in xattr.h, and include them
> both in .c file in where we need xattr definition.

It seems that all xattr related source files needing internal.h,
and we need "EROFS_V(inode)", "struct erofs_sb_info", ... stuffs in xattr.h,
which is defined in internal.h...

Thanks,
Gao Xiang

> 
> Thanks,
> 
