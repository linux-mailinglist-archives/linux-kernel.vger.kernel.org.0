Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CEEBF094
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfIZKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 06:55:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfIZKzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:55:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EF751000;
        Thu, 26 Sep 2019 03:55:05 -0700 (PDT)
Received: from [192.168.1.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70CE83F67D;
        Thu, 26 Sep 2019 03:55:03 -0700 (PDT)
Subject: Re: [PATCH 1/4] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
 <20190926060353.54894-2-vincenzo.frascino@arm.com>
 <20190926080616.GB26802@iMac.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <0ff3d5f4-11c9-4207-c6ab-2f8e9ee7de5e@arm.com>
Date:   Thu, 26 Sep 2019 11:56:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926080616.GB26802@iMac.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 9:06 AM, Catalin Marinas wrote:
> On Thu, Sep 26, 2019 at 07:03:50AM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 37c610963eee..afe8c948b493 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -110,7 +110,7 @@ config ARM64
>>  	select GENERIC_STRNLEN_USER
>>  	select GENERIC_TIME_VSYSCALL
>>  	select GENERIC_GETTIMEOFDAY
>> -	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
>> +	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPAT_CC_IS_GCC)
>>  	select HANDLE_DOMAIN_IRQ
>>  	select HARDIRQS_SW_RESEND
>>  	select HAVE_PCI
>> @@ -313,6 +313,9 @@ config KASAN_SHADOW_OFFSET
>>  	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>>  	default 0xffffffffffffffff
>>  
>> +config COMPAT_CC_IS_GCC
>> +	def_bool $(success,$(CROSS_COMPILE_COMPAT)gcc --version | head -n 1 | grep -q arm)
> 
> Nitpick: I prefer COMPATCC instead of COMPAT_CC for consistency with
> HOSTCC.
>

Ok, will change this in v2.

> Now, could we not generate a COMPATCC in the Makefile and use
> $(COMPATCC) here instead of $(CROSS_COMPILE_COMPAT)gcc? It really
> doesn't make sense to check that gcc is gcc.
> 

All right, COMPATCC is already in the makefile, I will use it in here.

> A next step would be to check that COMPATCC can actually generate 32-bit
> objects. But it's not essential at this stage.
> 

We are already checking this making sure that arm is present in the triple (grep
-q arm).

>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 84a3d502c5a5..34f53eb11878 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -54,19 +54,8 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>>  endif
>>  
>>  ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>> -  CROSS_COMPILE_COMPAT ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
>> -
>> -  ifeq ($(CONFIG_CC_IS_CLANG), y)
>> -    $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
>> -  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
>> -    $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>> -  else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>> -    $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
>> -  else
>> -    export CROSS_COMPILE_COMPAT
>> -    export CONFIG_COMPAT_VDSO := y
>> -    compat_vdso := -DCONFIG_COMPAT_VDSO=1
>> -  endif
>> +  export CONFIG_COMPAT_VDSO := y
>> +  compat_vdso := -DCONFIG_COMPAT_VDSO=1
>>  endif
> 
> Has CONFIG_CROSS_COMPILE_COMPAT_VDSO actually been removed from
> lib/vdso/Kconfig? (I haven't checked the subsequent patches).
> 

-- 
Regards,
Vincenzo
