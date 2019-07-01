Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8931A4B91E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfFSMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 08:52:07 -0400
Received: from foss.arm.com ([217.140.110.172]:38258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731328AbfFSMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:52:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E27360;
        Wed, 19 Jun 2019 05:52:06 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EDE23F738;
        Wed, 19 Jun 2019 05:52:03 -0700 (PDT)
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, aou@eecs.berkeley.edu,
        gary@garyguo.net, Atish.Patra@wdc.com, hch@infradead.org,
        paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <aafb3478-ce7b-3771-c03a-58510261f01c@arm.com>
Date:   Wed, 19 Jun 2019 13:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On 19/06/2019 12:51, Guo Ren wrote:
> On Wed, Jun 19, 2019 at 4:54 PM Julien Grall <julien.grall@arm.com> wrote:
>>
>>
>>
>> On 6/19/19 9:07 AM, Guo Ren wrote:
>>> Hi Julien,
>>
>> Hi,
>>
>>>
>>> You forgot CCing C-SKY folks :P
>>
>> I wasn't aware you could be interested :).
>>
>>>
>>> Move arm asid allocator code in a generic one is a agood idea, I've
>>> made a patchset for C-SKY and test is on processing, See:
>>> https://lore.kernel.org/linux-csky/1560930553-26502-1-git-send-email-guoren@kernel.org/
>>>
>>> If you plan to seperate it into generic one, I could co-work with you.
>>
>> Was the ASID allocator work out of box on C-Sky?
> Almost done, but one question:
> arm64 remove the code in switch_mm:
>    cpumask_clear_cpu(cpu, mm_cpumask(prev));
>    cpumask_set_cpu(cpu, mm_cpumask(next));


> 
> Why? Although arm64 cache operations could affect all harts with CTC
> method of interconnect, I think we should
> keep these code for primitive integrity in linux. Because cpu_bitmap
> is in mm_struct instead of mm->context.

I will let Will answer to this.

[...]

>> If so, I can easily move the code in a generic place (maybe lib/asid.c).
> I think it's OK.

Will emits concern to move the code in lib. So I will stick with what I 
currently have.

Cheers,

-- 
Julien Grall
