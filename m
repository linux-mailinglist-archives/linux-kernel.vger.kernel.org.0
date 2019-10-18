Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3DDCAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436697AbfJRQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:20:59 -0400
Received: from [217.140.110.172] ([217.140.110.172]:44984 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2389074AbfJRQU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:20:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98337C8F;
        Fri, 18 Oct 2019 09:20:35 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B9163F718;
        Fri, 18 Oct 2019 09:20:32 -0700 (PDT)
Subject: Re: [PATCH v12 07/22] riscv: mm: Add p?d_leaf() definitions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Alexandre Ghiti <alex@ghiti.fr>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191018101248.33727-1-steven.price@arm.com>
 <20191018101248.33727-8-steven.price@arm.com>
 <20191018155743.GG25386@infradead.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <fe6a0fe4-e789-fb4b-4481-b3934234e16f@arm.com>
Date:   Fri, 18 Oct 2019 17:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018155743.GG25386@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2019 16:57, Christoph Hellwig wrote:
>> +	return pud_present(pud)
>> +		&& (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
>> +}
> 
> The operators always need to go before the line break, not after it
> per linux coding style.  There are a few more spots like this, so please
> audit the whole series for it.

Fair enough. In this case I was just copying the example in pte_huge()
that already existed - but you're right this isn't the kernel coding style.

Thanks,

Steve
