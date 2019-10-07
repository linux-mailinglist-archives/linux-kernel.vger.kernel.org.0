Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA94CDE44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 11:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfJGJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 05:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGJdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB7B9C0495A3;
        Mon,  7 Oct 2019 09:33:47 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F6F100197A;
        Mon,  7 Oct 2019 09:33:42 +0000 (UTC)
Date:   Mon, 7 Oct 2019 17:33:38 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, bhe@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH v2] x86/kdump: Fix 'kmem -s' reported an invalid
 freepointer when SME was active
Message-ID: <20191007093338.GA4710@dhcp-128-65.nay.redhat.com>
References: <20191007070844.15935-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007070844.15935-1-lijiang@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 07 Oct 2019 09:33:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,
On 10/07/19 at 03:08pm, Lianbo Jiang wrote:
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
> 
> Kdump kernel will reuse the first 640k region because of some reasons,
> for example: the trampline and conventional PC system BIOS region may
> require to allocate memory in this area. Obviously, kdump kernel will
> also overwrite the first 640k region, therefore, kernel has to copy
> the contents of the first 640k area to a backup area, which is done in
> purgatory(), because vmcore may need the old memory. When vmcore is
> dumped, kdump kernel will read the old memory from the backup area of
> the first 640k area.
> 
> Basically, the main reason should be clear, kernel does not correctly
> handle the first 640k region when SME is active, which causes that
> kernel does not properly copy these old memory to the backup area in
> purgatory(). Therefore, kdump kernel reads out the incorrect contents
> from the backup area when dumping vmcore. Finally, the phenomenon is
> as follow:
> 
> [root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
> WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values
> 
>       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
>     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
>         CPUS: 128
>         DATE: Thu Sep 19 08:31:18 2019
>       UPTIME: 00:01:21
> LOAD AVERAGE: 0.16, 0.07, 0.02
>        TASKS: 1343
>     NODENAME: amd-ethanol
>      RELEASE: 5.3.0-rc7+
>      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
>      MACHINE: x86_64  (2195 Mhz)
>       MEMORY: 127.9 GB
>        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>          PID: 9789
>      COMMAND: "bash"
>         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
>          CPU: 83
>        STATE: TASK_RUNNING (PANIC)
> 
> crash> kmem -s|grep -i invalid
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> crash>
> 
> BTW: I also tried to fix the above problem in purgatory(), but there
> are too many restricts in purgatory() context, for example: i can't
> allocate new memory to create the identity mapping page table for SME
> situation.
> 
> Currently, there are two places where the first 640k area is needed,
> the first one is in the find_trampoline_placement(), another one is
> in the reserve_real_mode(), and their content doesn't matter. To avoid
> the above error, lets occupy the remain memory of the first 640k region
> (expect for the trampoline and real mode) so that the allocated memory
> does not fall into the first 640k area when SME is active, which makes
> us not to worry about whether kernel can correctly copy the contents of
> the first 640k area to a backup region in the purgatory().
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> Changes since v1:
> 1. Improve patch log
> 2. Change the checking condition from sme_active() to sme_active()
>    && strstr(boot_command_line, "crashkernel=")
> 
>  arch/x86/kernel/setup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 77ea96b794bd..bdb1a02a84fd 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1148,6 +1148,9 @@ void __init setup_arch(char **cmdline_p)
>  
>  	reserve_real_mode();
>  
> +	if (sme_active() && strstr(boot_command_line, "crashkernel="))
> +		memblock_reserve(0, 640*1024);
> +

Seems you missed the comment about "unconditionally do it", only check
crashkernel param looks better.

Also I noticed reserve_crashkernel is called after initmem_init, I'm not
sure if memblock_reserve is good enough in early code before
initmem_init. 

>  	trim_platform_memory_ranges();
>  	trim_low_memory_range();
>  
> -- 
> 2.17.1
> 

Thanks
Dave
