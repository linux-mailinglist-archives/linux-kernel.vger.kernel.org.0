Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8A642D54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfFLRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 13:20:27 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39276 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbfFLRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:20:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TU.Zjat_1560360018;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU.Zjat_1560360018)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jun 2019 01:20:22 +0800
Subject: Re: [PATCH 4/4] mm: shrinker: make shrinker not depend on memcg kmem
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559887659-23121-5-git-send-email-yang.shi@linux.alibaba.com>
 <20190612025257.7fv55qmx6p45hz7o@box>
 <a8f6f119-fd72-9a93-de99-fc7bea6404c0@linux.alibaba.com>
 <20190612101104.7rmjzmfy5owhqcif@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <aa4fd2f3-daf4-3c25-8f51-1527db8f743b@linux.alibaba.com>
Date:   Wed, 12 Jun 2019 10:20:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190612101104.7rmjzmfy5owhqcif@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/19 3:11 AM, Kirill A. Shutemov wrote:
> On Tue, Jun 11, 2019 at 10:07:54PM -0700, Yang Shi wrote:
>>
>> On 6/11/19 7:52 PM, Kirill A. Shutemov wrote:
>>> On Fri, Jun 07, 2019 at 02:07:39PM +0800, Yang Shi wrote:
>>>> Currently shrinker is just allocated and can work when memcg kmem is
>>>> enabled.  But, THP deferred split shrinker is not slab shrinker, it
>>>> doesn't make too much sense to have such shrinker depend on memcg kmem.
>>>> It should be able to reclaim THP even though memcg kmem is disabled.
>>>>
>>>> Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker,
>>>> i.e. THP deferred split shrinker.  When memcg kmem is disabled, just
>>>> such shrinkers can be called in shrinking memcg slab.
>>> Looks like it breaks bisectability. It has to be done before makeing
>>> shrinker memcg-aware, hasn't it?
>> No, it doesn't break bisectability. But, THP shrinker just can be called
>> with kmem charge enabled without this patch.
> So, if kmem is disabled, it will not be called, right? Then it is
> regression in my opinion. This patch has to go in before 2/4.

I don't think this is a regression. "regression" should mean something 
used to work, but it is broken now. Actually, deferred split shrinker 
never works with memcg.

Anyway, either before 2/4 or after 2/4 looks ok.

>

