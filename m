Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466C1EC581
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfKAPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 11:18:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbfKAPSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:18:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 961C413E6977BD12071A;
        Fri,  1 Nov 2019 23:18:34 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 23:18:33 +0800
Message-ID: <5DBC4CC8.2080003@huawei.com>
Date:   Fri, 1 Nov 2019 23:18:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     Borislav Petkov <bp@alien8.de>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>  <20191031110304.GE21133@nazgul.tnic> <5DBAC74E.5080001@huawei.com> <be4803c67e2e1f9e91e59bfd7b23f938619f66e8.camel@perches.com>
In-Reply-To: <be4803c67e2e1f9e91e59bfd7b23f938619f66e8.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 20:00, Joe Perches wrote:
> On Thu, 2019-10-31 at 19:36 +0800, zhong jiang wrote:
>> On 2019/10/31 19:03, Borislav Petkov wrote:
>>> On Wed, Oct 30, 2019 at 04:57:18PM +0800, zhong jiang wrote:
>>>> WARN_ONCE is more clear and simpler. Just replace it.
> []
>>>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> []
>>>> @@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>>>  		return NULL;
>>>>  
>>>>  	if (!phys_addr_valid(phys_addr)) {
>>>> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
>>>> -		       (unsigned long long)phys_addr);
>>>> -		WARN_ON_ONCE(1);
>>>> +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
>>>> +			  (unsigned long long)phys_addr);
>>> Does
>>> 	WARN_ONCE(!phys_addr_valid(phys_addr),
>>> 		  "ioremap: invalid physical address %llx\n",
>>> 		  (unsigned long long)phys_addr);
>>>
>>> work too?
>>>
>> Thanks, That is better. Will repost.
> Perhaps this is not good patch concept as now each
> invalid physical address will not be emitted.
>
> Before:
> 	each invalid physical address printed
> 	one stack dump
>
> After:
> 	one stck dump with first invalid physical address.
>
I misunderstand your meaning.  You're right.  My patch change its logical.
Thanks for your reminder.

Sincerely,
zhong jiang
>
> .
>


