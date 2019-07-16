Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD776A100
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 05:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfGPDwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 23:52:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbfGPDwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:52:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CFCDAFFC;
        Tue, 16 Jul 2019 03:52:23 +0000 (UTC)
Subject: Re: [PATCH 1/2] x86/xen: remove 32-bit Xen PV guest support
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20190715113739.17694-1-jgross@suse.com>
 <20190715113739.17694-2-jgross@suse.com>
 <91ed11a0-c97e-8caf-c71c-4595be4dbbb4@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <b5049344-da16-274b-b519-aba565dbff98@suse.com>
Date:   Tue, 16 Jul 2019 05:52:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <91ed11a0-c97e-8caf-c71c-4595be4dbbb4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 17:44, Boris Ostrovsky wrote:
> 
>> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
>> index 084de77a109e..d42737f31304 100644
>> --- a/arch/x86/xen/Makefile
>> +++ b/arch/x86/xen/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
>> +OBJECT_FILES_NON_STANDARD_xen-asm_64.o := y
>>   
>>   ifdef CONFIG_FUNCTION_TRACER
>>   # Do not profile debug and lowlevel utilities
>> @@ -34,7 +34,7 @@ obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
>>   obj-$(CONFIG_XEN_PV)		+= irq.o
>>   obj-$(CONFIG_XEN_PV)		+= multicalls.o
>>   obj-$(CONFIG_XEN_PV)		+= xen-asm.o
>> -obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
>> +obj-$(CONFIG_XEN_PV)		+= xen-asm_64.o
> 
> We should be able to merge xen-asm_64.S into xen-asm.S, shouldn't we?

Yes, probably a good idea to add that.

>> @@ -1312,15 +1290,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
>>   
>>   	/* keep using Xen gdt for now; no urgent need to change it */
>>   
>> -#ifdef CONFIG_X86_32
>> -	pv_info.kernel_rpl = 1;
>> -	if (xen_feature(XENFEAT_supervisor_mode_kernel))
>> -		pv_info.kernel_rpl = 0;
>> -#else
>>   	pv_info.kernel_rpl = 0;
> 
> Is kernel_rpl needed anymore?

Yes, this can be dropped, together with get_kernel_rpl().


Juergen
