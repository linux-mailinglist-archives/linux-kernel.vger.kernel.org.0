Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE802D97E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406497AbfJPQwh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Oct 2019 12:52:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39412 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfJPQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:52:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iKmXE-0003u2-SI; Wed, 16 Oct 2019 10:52:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iKmXD-0006Rl-ON; Wed, 16 Oct 2019 10:52:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     lijiang <lijiang@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
References: <20191012022140.19003-1-lijiang@redhat.com>
        <20191012022140.19003-4-lijiang@redhat.com>
        <87d0f22oi5.fsf@x220.int.ebiederm.org>
        <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
        <87zhi51ers.fsf@x220.int.ebiederm.org>
        <72edff0b-9778-2e83-224b-7fe70dfb8d73@redhat.com>
        <8736fu1d8k.fsf@x220.int.ebiederm.org>
        <93e6713a-8027-3a7a-4445-9bee56b19f62@redhat.com>
Date:   Wed, 16 Oct 2019 11:51:33 -0500
In-Reply-To: <93e6713a-8027-3a7a-4445-9bee56b19f62@redhat.com> (lijiang's
        message of "Wed, 16 Oct 2019 22:30:15 +0800")
Message-ID: <87eezczl9m.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iKmXD-0006Rl-ON;;;mid=<87eezczl9m.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UqLKJeXTL8k7QmDIJbylA80uUSDQ/w/E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_Unicode,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;lijiang <lijiang@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 675 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.2 (0.3%), b_tie_ro: 1.52 (0.2%), parse: 1.23
        (0.2%), extract_message_metadata: 8 (1.2%), get_uri_detail_list: 6
        (0.8%), tests_pri_-1000: 3.9 (0.6%), tests_pri_-950: 1.39 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 42 (6.2%), check_bayes: 40
        (5.9%), b_tokenize: 13 (2.0%), b_tok_get_all: 15 (2.2%), b_comp_prob:
        3.2 (0.5%), b_tok_touch_all: 7 (1.0%), b_finish: 0.55 (0.1%),
        tests_pri_0: 599 (88.7%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.97 (0.1%), tests_pri_10:
        1.79 (0.3%), tests_pri_500: 5.0 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the backup region
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lijiang <lijiang@redhat.com> writes:

> 在 2019年10月15日 19:04, Eric W. Biederman 写道:
>> lijiang <lijiang@redhat.com> writes:
>> 
>>> 在 2019年10月13日 11:54, Eric W. Biederman 写道:
>>>> Dave Young <dyoung@redhat.com> writes:
>>>>
>>>>> Hi Eric,
>>>>>
>>>>> On 10/12/19 at 06:26am, Eric W. Biederman wrote:
>>>>>> Lianbo Jiang <lijiang@redhat.com> writes:
>>>>>>
>>>>>>> When the crashkernel kernel command line option is specified, the
>>>>>>> low 1MiB memory will always be reserved, which makes that the memory
>>>>>>> allocated later won't fall into the low 1MiB area, thereby, it's not
>>>>>>> necessary to create a backup region and also no need to copy the first
>>>>>>> 640k content to a backup region.
>>>>>>>
>>>>>>> Currently, the code related to the backup region can be safely removed,
>>>>>>> so lets clean up.
>>>>>>>
>>>>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>>>>> ---
>>>>>>
>>>>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>>>>> index eb651fbde92a..cc5774fc84c0 100644
>>>>>>> --- a/arch/x86/kernel/crash.c
>>>>>>> +++ b/arch/x86/kernel/crash.c
>>>>>>> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>>>>>>  
>>>>>>>  #ifdef CONFIG_KEXEC_FILE
>>>>>>>  
>>>>>>> -static unsigned long crash_zero_bytes;
>>>>>>> -
>>>>>>>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>>>>>>>  {
>>>>>>>  	unsigned int *nr_ranges = arg;
>>>>>>> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>>>>>>>  {
>>>>>>>  	struct crash_mem *cmem = arg;
>>>>>>>  
>>>>>>> -	cmem->ranges[cmem->nr_ranges].start = res->start;
>>>>>>> -	cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>>>> -	cmem->nr_ranges++;
>>>>>>> +	if (res->start >= SZ_1M) {
>>>>>>> +		cmem->ranges[cmem->nr_ranges].start = res->start;
>>>>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>>>> +		cmem->nr_ranges++;
>>>>>>> +	} else if (res->end > SZ_1M) {
>>>>>>> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>>>>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>>>> +		cmem->nr_ranges++;
>>>>>>> +	}
>>>>>>
>>>>>> What is going on with this chunk?  I can guess but this needs a clear
>>>>>> comment.
>>>>>
>>>>> Indeed it needs some code comment, this is based on some offline
>>>>> discussion.  cat /proc/vmcore will give a warning because ioremap is
>>>>> mapping the system ram.
>>>>>
>>>>> We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
>>>>> kernel can use the low 1M memory because for example the trampoline
>>>>> code.
>>>>>
>>>>>>
>>>>>>>  
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>>
>>>>>>> @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>>>>>>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>>>>>>>  	cmd.params = params;
>>>>>>>  
>>>>>>> -	/* Add first 640K segment */
>>>>>>> -	ei.addr = image->arch.backup_src_start;
>>>>>>> -	ei.size = image->arch.backup_src_sz;
>>>>>>> +	/*
>>>>>>> +	 * Add the low memory range[0x1000, SZ_1M], skip
>>>>>>> +	 * the first zero page.
>>>>>>> +	 */
>>>>>>> +	ei.addr = PAGE_SIZE;
>>>>>>> +	ei.size = SZ_1M - PAGE_SIZE;
>>>>>>>  	ei.type = E820_TYPE_RAM;
>>>>>>>  	add_e820_entry(params, &ei);
>>>>>>
>>>>>> Likewise here.  Why do we need a special case?
>>>>>> Why the magic with PAGE_SIZE?
>>>>>
>>>>> Good catch, the zero page part is useless, I think no other special
>>>>> reason, just assumed zero page is not usable, but it should be ok to
>>>>> remove the special handling, just pass 0 - 1M is good enough.
>>>>
>>>> But if we have stopped special casing the low 1M.  Why do we need a
>>>> special case here at all?
>>>>
>>> Here, need to pass the low memory range to kdump kernel, which will guarantee
>>> the availability of low memory in kdump kernel, otherwise, kdump kernel won't
>>> use the low memory region.
>>>
>>>> If you need the special case it is almost certainly wrong to say you
>>>> have ram above 640KiB and below 1MiB.  That is the legacy ROM and video
>>>> MMIO area.
>>>>
>>>> There is a reason the original code said 640KiB.
>>>>
>>> Do you mean that the 640k region is good enough here instead of 1MiB?
>> 
>> Reading through the code of crash_setup_memap_entries I see that what
>> the code is doing now.  The code is repeating the e820 memory map with
>> the memory areas that were not reserved for the crash kernel removed.
>> 
>> In which case what the code needs to be doing something like:
>> 
>> 	cmd.type = E820_TYPE_RAM;
>> 	flags = IORESOURCE_MEM;
>> 	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, 1024*1024, &cmd,
>> 			       memmap_entry_callback);
>> 
> The above code does not get the results what we expected, it gets the reserved
> memory marked as 'IORES_DESC_RESERVED' in the low 1MiB range.
>
> Finally, kdump kernel happened the panic as follow:
> ......
> [    3.555662] Kernel panic - not syncing: Real mode trampoline was not allocated
> [    3.556660] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc3+ #4
> [    3.556660] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1009C 07/27/2018
> [    3.556660] Call Trace:
> [    3.556660]  dump_stack+0x46/0x60
> [    3.556660]  panic+0xfb/0x2d7
> [    3.556660]  ? hv_init_spinlocks+0x7f/0x7f
> [    3.556660]  init_real_mode+0x27/0x1fa
> [    3.556660]  ? hv_init_spinlocks+0x7f/0x7f
> [    3.556660]  ? do_one_initcall+0x46/0x1e4
> [    3.556660]  ? proc_register+0xd0/0x130
> [    3.556660]  ? kernel_init_freeable+0xe2/0x242
> [    3.556660]  ? rest_init+0xaa/0xaa
> [    3.556660]  ? kernel_init+0xa/0x106
> [    3.556660]  ? ret_from_fork+0x22/0x40
> [    3.556660] Rebooting in 10 seconds..
> [    3.556660] ACPI MEMORY or I/O RESET_REG.
>
> I modified the above code, and tested it. This can find out the system ram in
> the low 1MiB range. And it worked well.
>
> @@ -356,11 +338,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>         memset(&cmd, 0, sizeof(struct crash_memmap_data));
>         cmd.params = params;
>  
> +       /* Add the low 1MiB */
> +       cmd.type = E820_TYPE_RAM;
> +       flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +       walk_iomem_res_desc(IORES_DESC_NONE, flags, 0, 1024*1024 - 1, &cmd,
> +                       memmap_entry_callback);
>

That looks like a very reasonable fix.

>> Depending on which bugs exist it might make sense to limit this to
>> the low 640KiB.  But finding something the kernel already recognizes
>> as RAM should prevent most of those problems already.  Barring bugs
>> I admit it doesn't make sense to repeat the work that someone else
>> has already done.
>> 
>> This bit:
>> 	/* Add e820 reserved ranges */
>> 	cmd.type = E820_TYPE_RESERVED;
>> 	flags = IORESOURCE_MEM;
>> 	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, -1, &cmd,
>> 			   memmap_entry_callback);
>> 
>> Should probably start at 1MiB instead of 0.  Just so we don't report the
> If so, it can not find out the reserved memory marked as 'IORES_DESC_RESERVED' in
> the low 1MiB range, finally, it doesn't pass the reserved memory in the low 1MiB to
> kdump kernel, which could cause some problems, such as SME or PCI MMCONFIG issue.

Good point. For some reason I was thinking IORESOURCE_MEM and
IORESOURCE_SYSTEM_RAM were the same thing.  It has been way to long
since I have been in that part of the code.

So yes let's leave that part alone.

>> memory below 1MiB as unconditionally reserved.   I don't properly
>> understand the IORES_DESC_RESERVED flag, and how that differs from
> I found three commits about 'IORES_DESC_RESERVED' flag, hope this helps.
> 1.ae9e13d621d6 ("x86/e820, ioport: Add a new I/O resource descriptor IORES_DESC_RESERVED")
> 2.5da04cc86d12 ("x86/mm: Rework ioremap resource mapping determination")
> 3.980621daf368 ("x86/crash: Add e820 reserved ranges to kdump kernel's e820 table")
>
>> flags.  So please test my suggestions to verify the code works as
>> expected.
>> 
> I have tested the two changes that you mentioned, please refer to the
> reply above.

Thank you.  It looks like you have figured out how these things should
work.

Eric

