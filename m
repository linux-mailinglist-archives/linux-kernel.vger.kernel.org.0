Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85200B7194
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 04:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfISC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 22:29:23 -0400
Received: from aliyun-cloud.icoremail.net ([47.90.88.91]:24308 "HELO
        aliyun-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1730669AbfISC3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:29:22 -0400
Received: from localhost.localdomain (unknown [218.85.123.226])
        by app1 (Coremail) with SMTP id xjNnewDnybbs5YJdNFQBAA--.26S2;
        Thu, 19 Sep 2019 10:20:30 +0800 (CST)
Subject: Re: [PATCH] [RFC] vmscan.c: add a sysctl entry for controlling memory
 reclaim IO congestion_wait length
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        ktkhai@virtuozzo.com, hannes@cmpxchg.org
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
 <3fbb428e-9466-b56b-0be8-c0f510e3aa99@wangsu.com>
 <20190918113859.GA9880@bombadil.infradead.org>
From:   Lin Feng <linf@wangsu.com>
Message-ID: <afb916d8-2c19-f4b7-649f-0d819c2f7e08@wangsu.com>
Date:   Thu, 19 Sep 2019 10:20:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190918113859.GA9880@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: xjNnewDnybbs5YJdNFQBAA--.26S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45GF15WFyxZFWUJrW3Awb_yoW8tw17pF
        y8tFsFgF4qyr93tr92va47Kw1Ut3yUGrW7Jry3X34Uu3s8JF92vF4IgayY9asxurn3Gry2
        vr4j934kZrWYvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8GwAv
        7VCY1x0262k0Y48FwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r4U
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUfIJmUUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/18/19 19:38, Matthew Wilcox wrote:
> On Wed, Sep 18, 2019 at 11:21:04AM +0800, Lin Feng wrote:
>>> Adding a new tunable is not the right solution.  The right way is
>>> to make Linux auto-tune itself to avoid the problem.  For example,
>>> bdi_writeback contains an estimated write bandwidth (calculated by the
>>> memory management layer).  Given that, we should be able to make an
>>> estimate for how long to wait for the queues to drain.
>>>
>>
>> Yes, I had ever considered that, auto-tuning is definitely the senior AI way.
>> While considering all kinds of production environments hybird storage solution
>> is also common today, servers' dirty pages' bdi drivers can span from high end
>> ssds to low end sata disk, so we have to think of a *formula(AI core)* by using
>> the factors of dirty pages' amount and bdis' write bandwidth, and this AI-core
>> will depend on if the estimated write bandwidth is sane and moreover the to be
>> written back dirty pages is sequential or random if the bdi is rotational disk,
>> it's likey to give a not-sane number and hurt guys who dont't want that, while
>> if only consider ssd is relatively simple.
>>
>> So IMHO it's not sane to brute force add a guessing logic into memory writeback
>> codes and pray on inventing a formula that caters everyone's need.
>> Add a sysctl entry may be a right choice that give people who need it and
>> doesn't hurt people who don't want it.
> 
> You're making this sound far harder than it is.  All the writeback code
> needs to know is "How long should I sleep for in order for the queues
> to drain a substantial amount".  Since you know the bandwidth and how
> many pages you've queued up, it's a simple calculation.
> 

Ah, I should have read more of the writeback codes ;-)
Based on Michal's comments:
 > the underlying problem. Both congestion_wait and wait_iff_congested
 > should wake up early if the congestion is handled. Is this not the case?
If process is waken up once bdi congested is clear, this timeout length's role
seems not that important. I need to trace more if I can reproduce this issue
without online network traffic. But still weird thing is that once I set the
people-disliked-tunable iowait drop down instantly, they are contradictory.

Anyway, thanks a lot for your suggestions!
linfeng

