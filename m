Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68BE044F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfJVM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 08:57:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730684AbfJVM5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:57:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C59296D3148C1257A736;
        Tue, 22 Oct 2019 20:57:39 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 22 Oct 2019
 20:57:36 +0800
Subject: Re: [RFC PATCH -next] mm/vmstat: Fix build error without
 CONFIG_VM_EVENT_COUNTERS
To:     <sfr@canb.auug.org.au>, <khlebnikov@yandex-team.ru>,
        <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <hannes@cmpxchg.org>, <vbabka@suse.cz>, <jannh@google.com>,
        <gregkh@linuxfoundation.org>, <janne.huttunen@nokia.com>,
        <arunks@codeaurora.org>
References: <20191022125124.32812-1-yuehaibing@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <8929a502-96d3-fef6-8c5c-885da60d60b2@huawei.com>
Date:   Tue, 22 Oct 2019 20:57:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191022125124.32812-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this, seems has fixed.

https://lore.kernel.org/linux-mm/cd1c42ae-281f-c8a8-70ac-1d01d417b2e1@infradead.org/T/#u

On 2019/10/22 20:51, YueHaibing wrote:
> If CONFIG_VM_EVENT_COUNTERS is n but CONFIG_MEMCG is y,
> vmstat_text is not equal stat_items_size:
> 
> mm/vmstat.c: In function vmstat_start:
> ./include/linux/compiler.h:350:38: error: call to __compiletime_assert_1659 declared
>  with attribute error: BUILD_BUG_ON failed: stat_items_size != ARRAY_SIZE(vmstat_text) * sizeof(unsigned long)
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 2fdf561910a9 ("mm/memcontrol: use vmstat names for printing statistics")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  mm/vmstat.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b2fd344..a19ed6e 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1655,8 +1655,6 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
>  	stat_items_size += sizeof(struct vm_event_state);
>  #endif
>  
> -	BUILD_BUG_ON(stat_items_size !=
> -		     ARRAY_SIZE(vmstat_text) * sizeof(unsigned long));
>  	v = kmalloc(stat_items_size, GFP_KERNEL);
>  	m->private = v;
>  	if (!v)
> 

