Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90A6C3850
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbfJAO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 10:58:03 -0400
Received: from foss.arm.com ([217.140.110.172]:51790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389029AbfJAO6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:58:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B41E1000;
        Tue,  1 Oct 2019 07:58:02 -0700 (PDT)
Received: from [10.37.8.149] (unknown [10.37.8.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5A73F71A;
        Tue,  1 Oct 2019 07:58:00 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        tglx@linutronix.de
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
 <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
 <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com>
 <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7306ead0-a9b6-98d0-e775-c677eeeb55a5@arm.com>
Date:   Tue, 1 Oct 2019 15:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 3:43 PM, Will Deacon wrote:
> On Tue, Oct 01, 2019 at 03:37:49PM +0100, Vincenzo Frascino wrote:
>> On 10/1/19 3:20 PM, Will Deacon wrote:
>>> On Tue, Oct 01, 2019 at 03:20:35PM +0100, Vincenzo Frascino wrote:
>>>> On 10/1/19 2:27 PM, Catalin Marinas wrote:
>>>>> On Tue, Oct 01, 2019 at 02:14:23PM +0100, Will Deacon wrote:
>>>>>> On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
>>>>>>> +config COMPATCC_IS_ARM_GCC
>>>>>>> +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
>>>>>>
>>>>>> I've seen toolchains where the first part of the tuple is "armv7-", so they
>>>>>> won't get detected here. However, do we really need to detect this? If
>>>>>> somebody passes a duff compiler, then the build will fail in the same way as
>>>>>> if they passed it to CROSS_COMPILE=.
>>>>>
>>>>> Not sure what happens if we pass an aarch64 compiler. Can we end up with
>>>>> a 64-bit compat vDSO?
>>>>>
>>>>
>>>> I agree with Catalin here. The problem is not only when you pass and aarch64
>>>> toolchain but even an x86 and so on.
>>>
>>> I disagree. What happens if you do:
>>>
>>> $ make ARCH=arm64 CROSS_COMPILE=x86_64-linux-gnu-
>>>
>>> on your x86 box?
>>>
>>
>> The kernel compilation breaks as follows:
>>
>> x86_64-linux-gnu-gcc: error: unrecognized command line option ‘-mlittle-endian’;
>> did you mean ‘-fconvert=little-endian’?
>> /data1/Projects/LinuxKernel/linux/scripts/Makefile.build:265: recipe for target
>> 'scripts/mod/empty.o' failed
>> make[2]: *** [scripts/mod/empty.o] Error 1
>> /data1/Projects/LinuxKernel/linux/Makefile:1128: recipe for target 'prepare0' failed
>> make[1]: *** [prepare0] Error 2
>> make[1]: Leaving directory '/data1/Projects/LinuxKernel/linux-out'
>> Makefile:179: recipe for target 'sub-make' failed
>> make: *** [sub-make] Error 2
>>
>> Similar issue in the compat vdso library compilation if I do (without the check):
>>
>> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>> CROSS_COMPILE_COMPAT=x86_64-linux-gnu-
>>
>> With this check the compilation completes correctly but the compat vdso does not
>> get built (unless my environment is playing me tricks ;) ).
> 
> My point was that we don't attempt to sanitise the compiler passed via
> CROSS_COMPILE, so I don't think we should do anything special for COMPATCC
> either.
>

I agree on this, but the point I was trying to make is that the kernel should
still be able to build even if the compiler for compat vdso is not correct.

I do not have a strong opinion though.

> Will
> 

-- 
Regards,
Vincenzo
