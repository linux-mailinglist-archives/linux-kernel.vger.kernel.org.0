Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2252FBB37A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394048AbfIWMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 08:17:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393971AbfIWMRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:17:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4E86DE395609669D645;
        Mon, 23 Sep 2019 20:17:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 23 Sep
 2019 20:17:09 +0800
Subject: Re: [PATCH v2] erofs: fix erofs_get_meta_page locking by a cleanup
To:     Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20190921073035.209811-1-gaoxiang25@huawei.com>
 <20190921184355.149928-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f77eb3c9-37c0-24a1-1d04-784baf181ff2@huawei.com>
Date:   Mon, 23 Sep 2019 20:16:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190921184355.149928-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/22 2:43, Gao Xiang wrote:
> After doing more drop_caches stress test on
> our products, I found the mistake introduced by
> a very recent cleanup [1].
> 
> The current rule is that "erofs_get_meta_page"
> should be returned with page locked (although
> it's mostly unnecessary for read-only fs after
> pages are PG_uptodate), but a fix should be
> done for this.
> 
> [1] https://lore.kernel.org/r/20190904020912.63925-26-gaoxiang25@huawei.com
> Fixes: 618f40ea026b ("erofs: use read_cache_page_gfp for erofs_get_meta_page")
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
