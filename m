Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0512D51918
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 18:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfFXQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 12:54:17 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33883 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbfFXQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:54:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TV6jVAp_1561395249;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TV6jVAp_1561395249)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jun 2019 00:54:13 +0800
Subject: Re: [v3 PATCH 2/4] mm: move mem_cgroup_uncharge out of
 __page_cache_release()
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560376609-113689-3-git-send-email-yang.shi@linux.alibaba.com>
 <20190613113943.ahmqpezemdbwgyax@box>
 <2909ce59-86ba-ea0b-479f-756020fb32af@linux.alibaba.com>
Message-ID: <df469474-9b1c-6052-6aaa-be4558f7bd86@linux.alibaba.com>
Date:   Mon, 24 Jun 2019 09:54:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2909ce59-86ba-ea0b-479f-756020fb32af@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/19 10:13 AM, Yang Shi wrote:
>
>
> On 6/13/19 4:39 AM, Kirill A. Shutemov wrote:
>> On Thu, Jun 13, 2019 at 05:56:47AM +0800, Yang Shi wrote:
>>> The later patch would make THP deferred split shrinker memcg aware, but
>>> it needs page->mem_cgroup information in THP destructor, which is 
>>> called
>>> after mem_cgroup_uncharge() now.
>>>
>>> So, move mem_cgroup_uncharge() from __page_cache_release() to compound
>>> page destructor, which is called by both THP and other compound pages
>>> except HugeTLB.  And call it in __put_single_page() for single order
>>> page.
>>
>> If I read the patch correctly, it will change behaviour for pages with
>> NULL_COMPOUND_DTOR. Have you considered it? Are you sure it will not 
>> break
>> anything?
>

Hi Kirill,

Did this solve your concern? Any more comments on this series?

Thanks,
Yang

> So far a quick search shows NULL_COMPOUND_DTOR is not used by any type 
> of compound page. The HugeTLB code sets destructor to 
> NULL_COMPOUND_DTOR when freeing hugetlb pages via hugetlb specific 
> destructor.
>
> The prep_new_page() would call prep_compound_page() if __GFP_COMP is 
> used, which sets dtor to COMPOUND_PAGE_DTOR by default.  Just hugetlb 
> and THP set their specific dtors.
>
> And, it looks __put_compound_page() doesn't check if dtor is NULL or 
> not at all.
>
>>
>

