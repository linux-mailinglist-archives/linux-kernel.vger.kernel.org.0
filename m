Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36613A378
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 05:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfFIDpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 23:45:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfFIDpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 23:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B24508830A;
        Sun,  9 Jun 2019 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A5CC67C8C;
        Sun,  9 Jun 2019 03:45:14 +0000 (UTC)
Subject: Re: The current SME implementation fails kexec/kdump kernel booting.
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>
Cc:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190604134952.GC26891@MiWiFi-R3L-srv>
 <508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com>
 <20190605005600.GF26891@MiWiFi-R3L-srv>
 <0d9fba9d-7bbe-a7c7-dfe4-696da0dfecc4@amd.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <2fe0e56c-9286-b71d-3d6d-c2a6fbcfba89@redhat.com>
Date:   Sun, 9 Jun 2019 11:45:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0d9fba9d-7bbe-a7c7-dfe4-696da0dfecc4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 09 Jun 2019 03:45:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年06月06日 00:04, Lendacky, Thomas 写道:
> On 6/4/19 7:56 PM, Baoquan He wrote:
>> On 06/04/19 at 03:56pm, Lendacky, Thomas wrote:
>>> On 6/4/19 8:49 AM, Baoquan He wrote:
>>>> Hi Tom,
>>>>
>>>> Lianbo reported kdump kernel can't boot well with 'nokaslr' added, and
>>>> have to enable KASLR in kdump kernel to make it boot successfully. This
>>>> blocked his work on enabling sme for kexec/kdump. And on some machines
>>>> SME kernel can't boot in 1st kernel.
>>>>
>>>> I checked code of SME implementation, and found out the root cause. The
>>>> above failures are caused by SME code, sme_encrypt_kernel(). In
>>>> sme_encrypt_kernel(), you get a 2M of encryption work area as intermediate
>>>> buffer to encrypt kernel in-place. And the work area is just after _end of
>>>> kernel.
>>>
>>> I remember worrying about something like this back when I was testing the
>>> kexec support. I had come up with a patch to address it, but never got the
>>> time to test and submit it.  I've included it here if you'd like to test
>>> it (I haven't done run this patch in quite some time). If it works, we can
>>> think about submitting it.
>>
>> Thanks for your quick response and making this patch, Tom.
>>
>> Tested on a speedway machine, it entered into kernel, but failed in
>> below stage. Tested two times, always happened.
> 
> Is this the initial kernel boot or the kexec kernel boot?
> 
> It looks like this is related to the initrd/initramfs decryption. Not
> sure what could be happening there. I just tried the patch on my Naples
> system and a 5.2.0-rc3 kernel and have been able to repeatedly kexec boot
> a number of times so far.
> 

I used the hacked kexec-tools(by Baoquan) to test it, the kexec-d kernel and
kdump kernel worked well. But Tom's patch only worked for the kexec-d kernel,
and the kdump kernel did not work(kdump kernel could not successfully boot).
What's the difference between them?

Thanks
Lianbo

> Thanks,
> Tom
> 
>>
>>
>> [    4.978521] Freeing unused decrypted memory: 2040K
>> [    4.983800] Freeing unused kernel image memory: 2344K
>> [    4.988943] Write protecting the kernel read-only data: 18432k
>> [    4.995306] Freeing unused kernel image memory: 2012K
>> [    5.000488] Freeing unused kernel image memory: 256K
>> [    5.005540] Run /init as init process
>> [    5.009443] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>> [    5.017230] CPU: 0 PID: 1 Comm: init Not tainted 5.2.0-rc2+ #38
>> [    5.023251] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1004B 10/18/2017
>> [    5.031299] Call Trace:
>> [    5.033793]  dump_stack+0x46/0x60
>> [    5.037169]  panic+0xfb/0x2cb
>> [    5.040191]  do_exit.cold.21+0x59/0x81
>> [    5.044004]  do_group_exit+0x3a/0xa0
>> [    5.047640]  __x64_sys_exit_group+0x14/0x20
>> [    5.051899]  do_syscall_64+0x55/0x1c0
>> [    5.055627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [    5.060764] RIP: 0033:0x7fa1b1fc9e2e
>> [    5.064404] Code: Bad RIP value.
>> [    5.067687] RSP: 002b:00007fffc5abb778 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
>> [    5.075296] RAX: ffffffffffffffda RBX: 00007fa1b1fd2528 RCX: 00007fa1b1fc9e2e
>> [    5.082625] RDX: 000000000000007f RSI: 000000000000003c RDI: 000000000000007f
>> [    5.089879] RBP: 00007fa1b21d8d00 R08: 00000000000000e7 R09: 00007fffc5abb688
>> [    5.097134] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
>> [    5.104386] R13: 0000000000000001 R14: 00007fa1b21d8d40 R15: 00007fa1b21d8d30
>> [    5.111645] Kernel Offset: disabled
>> [    5.423002] Rebooting in 10 seconds..
>> [   15.429641] ACPI MEMORY or I/O RESET_REG.
>>
