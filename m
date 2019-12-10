Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1085118B91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 15:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfLJOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 09:53:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727420AbfLJOxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:53:30 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F08F0B0D3C4BB7E5B4A8;
        Tue, 10 Dec 2019 14:53:26 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Dec 2019 14:53:26 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 14:53:26 +0000
Subject: Re: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5d517a33-2e5a-529c-578c-707ae0a40e88@huawei.com>
Date:   Tue, 10 Dec 2019 14:53:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 21:38, Cong Wang wrote:
> This patchset contains three small optimizations for the global spinlock
> contention in IOVA cache. Our memcache perf test shows this reduced its
> p999 latency down by 45% on AMD when IOMMU is enabled.
> 
> Cong Wang (3):
>    iommu: avoid unnecessary magazine allocations
>    iommu: optimize iova_magazine_free_pfns()
>    iommu: avoid taking iova_rbtree_lock twice
> ---
>   drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
>   1 file changed, 45 insertions(+), 30 deletions(-)
> 

I retested, and got a ~1.1% gain in throughput for my storage test - 
results here if interested https://pastebin.com/dSQxYpN8

Thanks,
John
