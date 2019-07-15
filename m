Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07D669F97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 01:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfGOXvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 19:51:46 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:32797 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727379AbfGOXvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 19:51:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TX0PJ-d_1563234700;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX0PJ-d_1563234700)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 07:51:42 +0800
Subject: Re: [v2 PATCH 0/2] mm: mempolicy: fix mbind()'s inconsistent behavior
 for unmovable pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190715152255.027e2e368e16eb0a862eb9df@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <600c7713-2a6a-efce-69e6-9519d6aafaf1@linux.alibaba.com>
Date:   Mon, 15 Jul 2019 16:51:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190715152255.027e2e368e16eb0a862eb9df@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/19 3:22 PM, Andrew Morton wrote:
> On Sat, 22 Jun 2019 08:20:07 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Changelog
>> v2: * Fixed the inconsistent behavior by not aborting !vma_migratable()
>>        immediately by a separate patch (patch 1/2), and this is also the
>>        preparation for patch 2/2. For the details please see the commit
>>        log.  Per Vlastimil.
>>      * Not abort immediately if unmovable page is met. This should handle
>>        non-LRU movable pages and temporary off-LRU pages more friendly.
>>        Per Vlastimil and Michal Hocko.
>>
>> Yang Shi (2):
>>        mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
>>        mm: mempolicy: handle vma with unmovable pages mapped correctly in mbind
>>
> I'm seeing no evidence of review on these two.  Could we please take a
> look?  2/2 fixes a kernel crash so let's please also think about the
> -stable situation.

Thanks for following up this. It seems I have a few patches stalled due 
to lack of review.

BTW, this would not crash post-4.9 kernel since that BUG_ON had been 
removed. But, that behavior is definitely problematic as the commit log 
elaborated.

>
> I have a note here that Vlastimil had an issue with [1/2] but I seem to
> hae misplaced that email :(

