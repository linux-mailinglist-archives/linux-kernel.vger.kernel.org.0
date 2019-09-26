Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED711BF0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIZK55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 06:57:57 -0400
Received: from foss.arm.com ([217.140.110.172]:45936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfIZK55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:57:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D79FE1000;
        Thu, 26 Sep 2019 03:57:56 -0700 (PDT)
Received: from [192.168.1.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46CDC3F67D;
        Thu, 26 Sep 2019 03:57:55 -0700 (PDT)
Subject: Re: [PATCH 2/4] arm64: vdso32: Detect binutils support for dmb ishld
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
 <20190926060353.54894-3-vincenzo.frascino@arm.com>
 <20190926083039.GC26802@iMac.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d4483638-cba6-eedc-df85-ffe8b0895c89@arm.com>
Date:   Thu, 26 Sep 2019 11:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926083039.GC26802@iMac.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 9:30 AM, Catalin Marinas wrote:
> On Thu, Sep 26, 2019 at 07:03:51AM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
>> index fb60a88b5ed4..3fd8fd6d8fc2 100644
>> --- a/arch/arm64/include/asm/vdso/compat_barrier.h
>> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
>> @@ -20,7 +20,7 @@
>>  
>>  #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
>>  
>> -#if __LINUX_ARM_ARCH__ >= 8
>> +#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
>>  #define aarch32_smp_mb()	dmb(ish)
>>  #define aarch32_smp_rmb()	dmb(ishld)
>>  #define aarch32_smp_wmb()	dmb(ishst)
>> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
>> index 1fba0776ed40..1a3299d901b1 100644
>> --- a/arch/arm64/kernel/vdso32/Makefile
>> +++ b/arch/arm64/kernel/vdso32/Makefile
>> @@ -55,6 +55,9 @@ endif
>>  VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
>>  VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
>>  
>> +# Check for binutils support for dmb ishld
>> +dmbinstr := $(call as-instr,dmb ishld,-DCONFIG_AS_DMB_ISHLD=1)
> 
> Is this check for the compat gas or the native one? Looking at
> scripts/Kbuild.include, as-instr uses CC but you'd need a COMPATCC here
> instead.
> 
> I may have missed something but I don't think this fixes the issue
> Will's issue since he reported the problem with an old compat binutils.
> 

Good catch I thought that it was sufficient to put it in the correct makefile,
but I missed that COMPATCC != CC. This selects the wrong binutils.

Need to add something in Kbuild for that.

-- 
Regards,
Vincenzo
