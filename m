Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441F42C43F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE1K31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 06:29:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54400 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1K31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:29:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 437D4341;
        Tue, 28 May 2019 03:29:26 -0700 (PDT)
Received: from [192.168.1.27] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F35D23F59C;
        Tue, 28 May 2019 03:29:23 -0700 (PDT)
Subject: Re: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190528100413.GA20809@fuggles.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <8963e2ba-be92-39cb-40f1-7df89aa1e635@arm.com>
Date:   Tue, 28 May 2019 12:29:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528100413.GA20809@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 12:04 PM, Will Deacon wrote:
> On Thu, May 23, 2019 at 11:22:52AM +0100, Ard Biesheuvel wrote:
>> Wire up the code introduced in v5.2 to manage the permissions
>> of executable vmalloc regions (and their linear aliases) more
>> strictly.
>>
>> One of the things that came up in the internal discussion is
>> whether non-x86 architectures have any benefit at all from the
>> lazy vunmap feature, and whether it would perhaps be better to
>> implement eager vunmap instead.
>>
>> Cc: Nadav Amit <namit@vmware.com>
>> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>>
>> Ard Biesheuvel (4):
>>    arm64: module: create module allocations without exec permissions
>>    arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
>>    arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
>>    arm64: bpf: do not allocate executable memory
>>
>>   arch/arm64/Kconfig                  |  1 +
>>   arch/arm64/include/asm/cacheflush.h |  3 ++
>>   arch/arm64/kernel/module.c          |  4 +-
>>   arch/arm64/kernel/probes/kprobes.c  |  4 +-
>>   arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
>>   arch/arm64/net/bpf_jit_comp.c       |  2 +-
>>   mm/vmalloc.c                        | 11 -----
>>   7 files changed, 50 insertions(+), 23 deletions(-)
> 
> Thanks, this all looks good to me. I can get pick this up for 5.2 if
> Rick's fixes [1] land soon enough.
> 

Note that you'll get a trivial conflict in the hunk against mm/vmalloc.c.
