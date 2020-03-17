Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4E188E00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 20:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQT3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 15:29:41 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59995 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQT3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:29:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TsuLFfP_1584473375;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TsuLFfP_1584473375)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Mar 2020 03:29:37 +0800
Subject: Re: [v3 PATCH 1/2] mm: swap: make page_evictable() inline
To:     Matthew Wilcox <willy@infradead.org>
Cc:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200317192136.GE22433@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <65617abd-d7b7-5e1c-46a3-77e9cddcc514@linux.alibaba.com>
Date:   Tue, 17 Mar 2020 12:29:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200317192136.GE22433@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 12:21 PM, Matthew Wilcox wrote:
> On Wed, Mar 18, 2020 at 01:42:50AM +0800, Yang Shi wrote:
>> -static inline int mapping_unevictable(struct address_space *mapping)
>> +static inline bool mapping_unevictable(struct address_space *mapping)
>>   {
>>   	if (mapping)
>>   		return test_bit(AS_UNEVICTABLE, &mapping->flags);
> Shouldn't this be:
>
> -static inline int mapping_unevictable(struct address_space *mapping)
> +static inline bool mapping_unevictable(struct address_space *mapping)
>   {
> -       if (mapping)
> -               return test_bit(AS_UNEVICTABLE, &mapping->flags);
> -       return !!mapping;
> +       return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);

Looks neater. Will take it in thew new version.

>   }

