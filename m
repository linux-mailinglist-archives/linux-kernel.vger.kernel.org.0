Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C226AFD234
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 02:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKOBGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 20:06:50 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55212 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbfKOBGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:06:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ti6Dufq_1573780006;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Ti6Dufq_1573780006)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Nov 2019 09:06:47 +0800
Subject: Re: [PATCH] mm/vmalloc: Fix regression caused by needless
 vmalloc_sync_all()
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191113095530.228959-1-shile.zhang@linux.alibaba.com>
 <20191114171231.GA21753@suse.de>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <88a7e8d5-84bc-46b1-573e-9da18218ef57@linux.alibaba.com>
Date:   Fri, 15 Nov 2019 09:06:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114171231.GA21753@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/15 01:12, Joerg Roedel wrote:
> On Wed, Nov 13, 2019 at 05:55:30PM +0800, Shile Zhang wrote:
>> +#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
>>   	/*
>>   	 * First make sure the mappings are removed from all page-tables
>>   	 * before they are freed.
>> +	 *
>> +	 * This is only needed on x86-32 with !SHARED_KERNEL_PMD, which is
>> +	 * the case on a PAE kernel with PTI enabled.
>>   	 */
>> -	vmalloc_sync_all();
>> +	if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
>> +		vmalloc_sync_all();
>> +#endif
> I already submitted another fix for this quite some time ago:
>
> 	https://lore.kernel.org/lkml/20191009124418.8286-1-joro@8bytes.org/
>
> Regards,
>
> 	Joerg
Oh, sorry for I missed that, good job and thanks for your work!
