Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF36878C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfGOK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 06:58:51 -0400
Received: from foss.arm.com ([217.140.110.172]:47206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbfGOK6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:58:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E292B;
        Mon, 15 Jul 2019 03:58:50 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68BF3F59C;
        Mon, 15 Jul 2019 03:58:49 -0700 (PDT)
Subject: Re: [RFC v2 11/14] arm64: Move the ASID allocator code in a separate
 file
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        julien.thierry@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <20190620130608.17230-1-julien.grall@arm.com>
 <20190620130608.17230-12-julien.grall@arm.com>
 <3e6c6636-8522-ab4a-0183-ae0198a7a047@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <9e605949-4c3f-da9a-228c-25e694ced5df@arm.com>
Date:   Mon, 15 Jul 2019 11:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <3e6c6636-8522-ab4a-0183-ae0198a7a047@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2019 15:56, James Morse wrote:
> Hi Julien,

Hi James,

Thank you for the review.

> 
> On 20/06/2019 14:06, Julien Grall wrote:
>> We will want to re-use the ASID allocator in a separate context (e.g
>> allocating VMID). So move the code in a new file.
>>
>> The function asid_check_context has been moved in the header as a static
>> inline function because we want to avoid add a branch when checking if the
>> ASID is still valid.
> 
>> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
>> index 3df63a28856c..b745cf356fe1 100644
>> --- a/arch/arm64/mm/context.c
>> +++ b/arch/arm64/mm/context.c
>> @@ -23,46 +23,21 @@
> 
>> -#define ASID_FIRST_VERSION(info)	NUM_ASIDS(info)
> 
>> diff --git a/arch/arm64/lib/asid.c b/arch/arm64/lib/asid.c
>> new file mode 100644
>> index 000000000000..7252e4fdd5e9
>> --- /dev/null
>> +++ b/arch/arm64/lib/asid.c
>> @@ -0,0 +1,185 @@
> 
>> +#define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
> 
> (oops!)

Good catch, I will fix it in the next version.

> 
> 
>> @@ -344,7 +115,7 @@ static int asids_init(void)
>>   	if (!asid_allocator_init(&asid_info, bits, ASID_PER_CONTEXT,
>>   				 asid_flush_cpu_ctxt))
>>   		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
>> -		      1UL << bits);
>> +		      NUM_ASIDS(&asid_info));
> 
> Could this go in the patch that adds NUM_ASIDS()?

Actually this change is potentially wrong. This relies on asid_allocator_init() 
to set asid_info.bits even if the function fails.

So I think it would be best to keep 1UL << bits here.

Cheers,

-- 
Julien Grall
