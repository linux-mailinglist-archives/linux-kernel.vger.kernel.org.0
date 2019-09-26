Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8CBF0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 13:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfIZLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 07:01:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfIZLB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:01:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D7861000;
        Thu, 26 Sep 2019 04:01:57 -0700 (PDT)
Received: from [192.168.1.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F1F3F67D;
        Thu, 26 Sep 2019 04:01:55 -0700 (PDT)
Subject: Re: [PATCH 3/4] arm64: vdso32: Fix compilation warning
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
 <20190926060353.54894-4-vincenzo.frascino@arm.com>
 <20190926083217.GD26802@iMac.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <25676f5c-0c95-82b4-8d09-a313f812bb01@arm.com>
Date:   Thu, 26 Sep 2019 12:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926083217.GD26802@iMac.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 9:32 AM, Catalin Marinas wrote:
> On Thu, Sep 26, 2019 at 07:03:52AM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index b61b50bf68b1..b1c8c43234c5 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -228,11 +228,16 @@ static inline unsigned long kaslr_offset(void)
>>  #define __tag_get(addr)		0
>>  #endif /* CONFIG_KASAN_SW_TAGS */
>>  
>> +#ifdef __aarch64__
>>  static inline const void *__tag_set(const void *addr, u8 tag)
>>  {
>>  	u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>>  	return (const void *)(__addr | __tag_shifted(tag));
>>  }
>> +#else
>> +/* Unused in 32 bit mode */
>> +#define __tag_set(addr, tag) 0
>> +#endif
> 
> I'm fine with this as a temporary workaround (or hack). But please add a
> better comment on what the 32-bit mode is about - the compat vDSO.
> 

Ok, I will do in v2, to avoid confusion.

-- 
Regards,
Vincenzo
