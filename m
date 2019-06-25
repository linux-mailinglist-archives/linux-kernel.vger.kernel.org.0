Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B65513A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 16:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfFYOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 10:11:25 -0400
Received: from foss.arm.com ([217.140.110.172]:42712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfFYOLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:11:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B73F2B;
        Tue, 25 Jun 2019 07:11:24 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD24D3F718;
        Tue, 25 Jun 2019 07:11:22 -0700 (PDT)
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        natechancellor@gmail.com, ndesaulniers@google.com
References: <1561464964.5154.63.camel@lca.pw>
 <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
 <1561467369.5154.67.camel@lca.pw>
 <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
 <1561470705.5154.68.camel@lca.pw>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
Date:   Tue, 25 Jun 2019 15:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561470705.5154.68.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 25/06/2019 14:51, Qian Cai wrote:
> On Tue, 2019-06-25 at 14:40 +0100, Vincenzo Frascino wrote:
>> On 25/06/2019 13:56, Qian Cai wrote:
>>> On Tue, 2019-06-25 at 13:47 +0100, Vincenzo Frascino wrote:
>>>> Hi Qian,
>>>>
>>>> On 25/06/2019 13:16, Qian Cai wrote:
>>>>> The linux-next commit "arm64: vdso: Substitute gettimeofday() with C
>>>>> implementation" [1] breaks clang build.
>>>>>
>>>>> error: invalid value 'tiny' in '-mcode-model tiny'
>>>>> make[1]: *** [scripts/Makefile.build:279:
>>>>> arch/arm64/kernel/vdso/vgettimeofday.o] Error 1
>>>>> make[1]: *** Waiting for unfinished jobs....
>>>>> make: *** [arch/arm64/Makefile:180: vdso_prepare] Error 2
>>>>>
>>>>> [1] https://patchwork.kernel.org/patch/11009663/
>>>>>
>>>>
>>>> I am not sure what does exactly break from your report. Could you please
>>>> provide
>>>> more details?
>>>
>>> Here is the config to reproduce.
>>>
>>> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
>>>
>>> # make CC=clang -j $(nr_cpus)
>>>
>>> I can get it working again by removing "-mcmodel=tiny" in
>>> arch/arm64/kernel/vdso/Makefile
>>>
>>
>> With your defconfig I can't still reproduce the problem. Which version of
>> clang
>> are you using?
> 
> Compiler: clang version 7.0.1 (tags/RELEASE_701/final)
> 

I am using clang 8.0.0. Could you please try with it and see if the issue goes away?

Thanks,
Vincenzo

>>
>>>>
>>>> On my env:
>>>>
>>>> $ make mrproper && make defconfig && make CC=clang HOSTCC=clang -j$(nproc)
>>>>
>>>> ...
>>>>
>>>> arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT is clang, the compat vDSO
>>>> will
>>>> not
>>>> be built
>>>>
>>>> ...
>>>>
>>>>   LDS     arch/arm64/kernel/vdso/vdso.lds
>>>>   AS      arch/arm64/kernel/vdso/note.o
>>>>   AS      arch/arm64/kernel/vdso/sigreturn.o
>>>>   CC      arch/arm64/kernel/vdso/vgettimeofday.o
>>>>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>>>>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
>>>>   VDSOSYM include/generated/vdso-offsets.h
>>>>
>>>> ...
>>>>
>>>>   LD      vmlinux.o
>>>>   MODPOST vmlinux.o
>>>>   MODINFO modules.builtin.modinfo
>>>>   KSYM    .tmp_kallsyms1.o
>>>>   KSYM    .tmp_kallsyms2.o
>>>>   LD      vmlinux
>>>>   SORTEX  vmlinux
>>>>   SYSMAP  System.map
>>>>   Building modules, stage 2.
>>>>   OBJCOPY arch/arm64/boot/Image
>>>>   MODPOST 483 modules
>>>>
>>
>>

-- 
Regards,
Vincenzo
