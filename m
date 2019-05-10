Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991D11A077
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfEJPtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 11:49:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52822 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbfEJPtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:49:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TRMCMo-_1557503341;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TRMCMo-_1557503341)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 May 2019 23:49:04 +0800
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     William Kucharski <william.kucharski@oracle.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     hannes@cmpxchg.org, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
 <1fb73973-f409-1411-423b-c48895d3dde8@linux.alibaba.com>
 <87tve3j9jf.fsf@yhuang-dev.intel.com>
 <640160C2-4579-45FC-AABB-B60185A2348D@oracle.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b8930783-ec73-7330-903f-93a81efb2cd3@linux.alibaba.com>
Date:   Fri, 10 May 2019 08:48:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <640160C2-4579-45FC-AABB-B60185A2348D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/19 9:33 PM, William Kucharski wrote:
>
>> On May 9, 2019, at 9:03 PM, Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Yang Shi <yang.shi@linux.alibaba.com> writes:
>>
>>> On 5/9/19 7:12 PM, Huang, Ying wrote:
>>>> How about to change this to
>>>>
>>>>
>>>>          nr_reclaimed += hpage_nr_pages(page);
>>> Either is fine to me. Is this faster than "1 << compound_order(page)"?
>> I think the readability is a little better.  And this will become
>>
>>         nr_reclaimed += 1
>>
>> if CONFIG_TRANSPARENT_HUAGEPAGE is disabled.
> I find this more legible and self documenting, and it avoids the bit shift
> operation completely on the majority of systems where THP is not configured.

Yes, I do agree. Thanks for the suggestion.
>

