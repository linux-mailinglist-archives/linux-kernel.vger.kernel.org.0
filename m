Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C82D5FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfJNKCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 06:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbfJNKCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DCCB81DEB;
        Mon, 14 Oct 2019 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DCF5600CD;
        Mon, 14 Oct 2019 10:02:26 +0000 (UTC)
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the
 backup region
To:     Dave Young <dyoung@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, bhe@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        vgoyal@redhat.com, kexec@lists.infradead.org
References: <20191012022140.19003-1-lijiang@redhat.com>
 <20191012022140.19003-4-lijiang@redhat.com>
 <87d0f22oi5.fsf@x220.int.ebiederm.org>
 <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <f3fc12b9-be39-d430-52f5-d1b76b2599a3@redhat.com>
Date:   Mon, 14 Oct 2019 18:02:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 14 Oct 2019 10:02:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年10月12日 20:16, Dave Young 写道:
> Hi Eric,
> 
> On 10/12/19 at 06:26am, Eric W. Biederman wrote:
>> Lianbo Jiang <lijiang@redhat.com> writes:
>>
>>> When the crashkernel kernel command line option is specified, the
>>> low 1MiB memory will always be reserved, which makes that the memory
>>> allocated later won't fall into the low 1MiB area, thereby, it's not
>>> necessary to create a backup region and also no need to copy the first
>>> 640k content to a backup region.
>>>
>>> Currently, the code related to the backup region can be safely removed,
>>> so lets clean up.
>>>
>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>> ---
>>
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index eb651fbde92a..cc5774fc84c0 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>>  
>>>  #ifdef CONFIG_KEXEC_FILE
>>>  
>>> -static unsigned long crash_zero_bytes;
>>> -
>>>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>>>  {
>>>  	unsigned int *nr_ranges = arg;
>>> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>>>  {
>>>  	struct crash_mem *cmem = arg;
>>>  
>>> -	cmem->ranges[cmem->nr_ranges].start = res->start;
>>> -	cmem->ranges[cmem->nr_ranges].end = res->end;
>>> -	cmem->nr_ranges++;
>>> +	if (res->start >= SZ_1M) {
>>> +		cmem->ranges[cmem->nr_ranges].start = res->start;
>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>> +		cmem->nr_ranges++;
>>> +	} else if (res->end > SZ_1M) {
>>> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>> +		cmem->nr_ranges++;
>>> +	}
>>
>> What is going on with this chunk?  I can guess but this needs a clear
>> comment.
> 
> Indeed it needs some code comment, this is based on some offline
> discussion.  cat /proc/vmcore will give a warning because ioremap is
> mapping the system ram.
> 
> We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
> kernel can use the low 1M memory because for example the trampoline
> code.
> 
Thank you, Eric and Dave. I will add the code comment as below if it would be OK.

@@ -234,9 +232,20 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
        struct crash_mem *cmem = arg;
 
-       cmem->ranges[cmem->nr_ranges].start = res->start;
-       cmem->ranges[cmem->nr_ranges].end = res->end;
-       cmem->nr_ranges++;
+       /*
+        * Currently, pass the low 1MiB range to kdump kernel in e820
+        * as system ram so that kdump kernel can also use the low 1MiB
+        * memory due to the real mode trampoline code.
+        * And later, the low 1MiB range will be exclued from elf header,
+        * which will avoid remapping the 1MiB system ram when dumping
+        * vmcore.
+        */
+       if (res->start >= SZ_1M) {
+               cmem->ranges[cmem->nr_ranges].start = res->start;
+               cmem->ranges[cmem->nr_ranges].end = res->end;
+               cmem->nr_ranges++;
+       } else if (res->end > SZ_1M) {
+               cmem->ranges[cmem->nr_ranges].start = SZ_1M;
+               cmem->ranges[cmem->nr_ranges].end = res->end;
+               cmem->nr_ranges++;
+       }
 
        return 0;
 }

>>
>>>  
>>>  	return 0;
>>>  }
>>
>>> @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>>>  	cmd.params = params;
>>>  
>>> -	/* Add first 640K segment */
>>> -	ei.addr = image->arch.backup_src_start;
>>> -	ei.size = image->arch.backup_src_sz;
>>> +	/*
>>> +	 * Add the low memory range[0x1000, SZ_1M], skip
>>> +	 * the first zero page.
>>> +	 */
>>> +	ei.addr = PAGE_SIZE;
>>> +	ei.size = SZ_1M - PAGE_SIZE;
>>>  	ei.type = E820_TYPE_RAM;
>>>  	add_e820_entry(params, &ei);
>>
>> Likewise here.  Why do we need a special case?
>> Why the magic with PAGE_SIZE?
> 
> Good catch, the zero page part is useless, I think no other special
> reason, just assumed zero page is not usable, but it should be ok to
> remove the special handling, just pass 0 - 1M is good enough.
>> Thanks
> Dave
> 
