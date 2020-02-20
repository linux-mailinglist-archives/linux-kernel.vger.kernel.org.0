Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8D165903
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 09:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBTIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 03:20:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbgBTIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:20:03 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 70D15595F2CA640EE134;
        Thu, 20 Feb 2020 16:20:00 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 20 Feb
 2020 16:19:50 +0800
Subject: Re: [PATCH v3] erofs: convert workstn to XArray
To:     Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>
References: <20200220024642.91529-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c3372d97-ec77-6928-719e-39195c8c33f8@huawei.com>
Date:   Thu, 20 Feb 2020 16:19:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200220024642.91529-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/20 10:46, Gao Xiang wrote:
> XArray has friendly APIs and it will replace the old radix
> tree in the near future.
> 
> This convert makes use of __xa_cmpxchg when inserting on
> a just inserted item by other thread. In detail, instead
> of totally looking up again as what we did for the old
> radix tree, it will try to legitimize the current in-tree
> item in the XArray therefore more effective.
> 
> In addition, naming is rather a challenge for non-English
> speaker like me. The basic idea of workstn is to provide
> a runtime sparse array with items arranged in the physical
> block number order. Such items (was called workgroup) can be
> used to record compress clusters or for later new features.
> 
> However, both workgroup and workstn seem not good names from
> whatever point of view, so I'd like to rename them as pslot
> and managed_pslots to stand for physical slots. This patch
> handles the second as a part of the radix tree convert.
> 
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
