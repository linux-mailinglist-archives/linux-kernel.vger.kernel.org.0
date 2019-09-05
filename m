Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF4A9A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfIEGZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 02:25:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731231AbfIEGZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:25:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 04943DFB539C480715D5;
        Thu,  5 Sep 2019 14:09:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 14:09:26 +0800
Message-ID: <5D70A695.60706@huawei.com>
Date:   Thu, 5 Sep 2019 14:09:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <vbabka@suse.cz>, <mhocko@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: Unsigned 'nr_pages' always larger than zero
References: <1567649871-60594-1-git-send-email-zhongjiang@huawei.com> <20190905031252.GN29434@bombadil.infradead.org>
In-Reply-To: <20190905031252.GN29434@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/5 11:12, Matthew Wilcox wrote:
> On Thu, Sep 05, 2019 at 10:17:51AM +0800, zhong jiang wrote:
>> With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages'
>> compare with zero. And __gup_longterm_locked pass an long local variant
>> 'rc' to check_and_migrate_cma_pages. Hence it is nicer to change the
>> parameter to long to fix the issue.
> I think this patch is right, but I have concerns about this cocci grep.
>
> The code says:
>
>                 if ((nr_pages > 0) && migrate_allow) {
>
> There's nothing wrong with this (... other than the fact that nr_pages might
> happen to be a negative errno).  nr_pages might be 0, and this would be
> exactly the right test for that situation.  I suppose some might argue
> that this should be != 0 instead of > 0, but it depends on the situation
> which one would read better.
>
> So please don't blindly make these changes; you're right this time.
Thanks for your affirmation.  but Andrew come up with anther fix,  using an local long variant
to store the nr_pages.  which one do you prefer ?

Thanks,
zhong jiang

