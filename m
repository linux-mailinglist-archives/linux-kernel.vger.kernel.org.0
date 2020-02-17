Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61F160F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 11:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgBQKBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 05:01:06 -0500
Received: from foss.arm.com ([217.140.110.172]:33120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQKBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:01:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 578C730E;
        Mon, 17 Feb 2020 02:01:05 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 473883F6CF;
        Mon, 17 Feb 2020 02:01:02 -0800 (PST)
Subject: Re: [PATCH v17 21/23] arm64: mm: Convert mm/dump.c to use
 walk_page_range()
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <James.Morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20191218162402.45610-1-steven.price@arm.com>
 <20191218162402.45610-22-steven.price@arm.com>
 <CAKv+Gu8Hed9jGiqdgaqJ93JhErJA5OfGRpiarU=YKXb6vQUyMQ@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ee4f53ec-601b-3698-1479-f7aeaada38ad@arm.com>
Date:   Mon, 17 Feb 2020 10:01:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8Hed9jGiqdgaqJ93JhErJA5OfGRpiarU=YKXb6vQUyMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2020 16:25, Ard Biesheuvel wrote:
> On Wed, 18 Dec 2019 at 17:25, Steven Price <steven.price@arm.com> wrote:
>>
>> Now walk_page_range() can walk kernel page tables, we can switch the
>> arm64 ptdump code over to using it, simplifying the code.
>>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> I did not realize this at the time, but this patch removes the ability
> to dump the EFI page tables on 32-bit ARM. Was that intentional?

No that wasn't intentional, but I can't instantly see how this change
affects 32-bit ARM.

<snip (files in arch/arm64)>
>> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
>> index 899b803842bb..9dda2602c862 100644
>> --- a/drivers/firmware/efi/arm-runtime.c
>> +++ b/drivers/firmware/efi/arm-runtime.c
>> @@ -27,7 +27,7 @@
>>
>>  extern u64 efi_system_table;
>>
>> -#ifdef CONFIG_ARM64_PTDUMP_DEBUGFS
>> +#if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)

The previous define was *ARM64* so should never have been true when
building for arm. The new condition should be equivalent (arm64 &&
ptdump enabled).

Am I missing something?

Steve
