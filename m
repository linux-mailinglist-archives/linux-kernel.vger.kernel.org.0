Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15B29AA06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392529AbfHWIPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:15:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387613AbfHWIPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:15:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B9376584E140FA06078;
        Fri, 23 Aug 2019 16:15:12 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.186) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 16:15:02 +0800
Subject: Re: [PATCH v2 0/2] iommu/iova: enhance the rcache optimization
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        John Garry <john.garry@huawei.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Omer Peleg <omer@cs.technion.ac.il>,
        Adam Morrison <mad@cs.technion.ac.il>,
        Shaohua Li <shli@fb.com>, Ben Serebrin <serebrin@google.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190815121104.29140-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <297e3718-eb31-d92a-1eb9-d4999fcd20c5@huawei.com>
Date:   Fri, 23 Aug 2019 16:15:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190815121104.29140-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  Can anyone help review it?


On 2019/8/15 20:11, Zhen Lei wrote:
> v1 --> v2
> 1. I did not chagne the patches but added this cover-letter.
> 2. Add a batch of reviewers base on
>    9257b4a206fc ("iommu/iova: introduce per-cpu caching to iova allocation")
> 3. I described the problem I met in patch 2, but I hope below brief description
>    can help people to quickly understand.
>    Suppose there are six rcache sizes, each size can maximum hold 10000 IOVAs.
>    --------------------------------------------
>    |  4K   |  8K  | 16K  |  32K | 64K  | 128K |
>    --------------------------------------------
>    | 10000 | 9000 | 8500 | 8600 | 9200 | 7000 |
>    --------------------------------------------
>    As the above map displayed, the whole rcache buffered too many IOVAs. Now, the
>    worst case can be coming, suppose we need 20000 4K IOVAs at one time. That means
>    10000 IOVAs can be allocated from rcache, but another 10000 IOVAs should be 
>    allocated from RB tree base on alloc_iova() function. But the RB tree currently
>    have at least (9000 + 8500 + 8600 + 9200 + 7000) = 42300 nodes. The average speed
>    of RB tree traverse will be very slow. For my test scenario, the 4K size IOVAs are
>    frequently used, but others are not. So similarly, when the 20000 4K IOVAs are
>    continuous freed, the first 10000 IOVAs can be quickly buffered, but the other
>    10000 IOVAs can not.
> 
> Zhen Lei (2):
>   iommu/iova: introduce iova_magazine_compact_pfns()
>   iommu/iova: enhance the rcache optimization
> 
>  drivers/iommu/iova.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++----
>  include/linux/iova.h |   1 +
>  2 files changed, 95 insertions(+), 6 deletions(-)
> 

