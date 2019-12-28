Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02FE12BD2A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 10:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfL1Jcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 04:32:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbfL1Jcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 04:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577525566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/ed2bIJde+VHhN1RIGsEEo6GK8PhQGGiZ4Gf5Ce3sI=;
        b=C1K1RGMimjTifELYcLjU7zStB3ghr1SC6zi2sKPqD3XJlzKksqkoaeCyRuZZ20Qzj2XdEu
        pdX5QJAYnlD2k63pyGeKeMsPYhvExfA3cx9x90wu9+VpBzXN89R/iPCqqRzaOwtYDvjlaK
        A+gef5SQHDKPbTdhq6AfELxHGx7FN5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-JI4zvU32Ml2-Zg_cQ3al_Q-1; Sat, 28 Dec 2019 04:32:45 -0500
X-MC-Unique: JI4zvU32Ml2-Zg_cQ3al_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A0C0185432E;
        Sat, 28 Dec 2019 09:32:39 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3BF36A84A;
        Sat, 28 Dec 2019 09:32:31 +0000 (UTC)
Date:   Sat, 28 Dec 2019 17:32:27 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, james.morse@arm.com, bhsharma@redhat.com,
        horms@verge.net.au, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, xiexiuqi@huawei.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/4] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
Message-ID: <20191228093227.GA19720@dhcp-128-65.nay.redhat.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-2-chenzhou10@huawei.com>
 <20191227055458.GA14893@dhcp-128-65.nay.redhat.com>
 <09d42854-461b-e85c-ba3f-0e1173dc95b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d42854-461b-e85c-ba3f-0e1173dc95b5@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/19 at 07:04pm, Chen Zhou wrote:
> Hi Dave
> 
> On 2019/12/27 13:54, Dave Young wrote:
> > Hi,
> > On 12/23/19 at 11:23pm, Chen Zhou wrote:
> >> In preparation for supporting reserve_crashkernel_low in arm64 as
> >> x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
> >>
> >> Note, in arm64, we reserve low memory if and only if crashkernel=X,low
> >> is specified. Different with x86_64, don't set low memory automatically.
> > 
> > Do you have any reason for the difference?  I'd expect we have same
> > logic if possible and remove some of the ifdefs.
> 
> In x86_64, if we reserve crashkernel above 4G, then we call reserve_crashkernel_low()
> to reserve low memory.
> 
> In arm64, to simplify, we call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
> and then relax the arm64_dma32_phys_limit if reserve_crashkernel_low() allocated something.
> In this case, if reserve crashkernel below 4G there will be 256M low memory set automatically
> and this needs extra considerations.

Sorry that I did not read the old thread details and thought that is
arch dependent.  But rethink about that, it would be better that we can
have same semantic about crashkernel parameters across arches.  If we
make them different then it causes confusion, especially for
distributions.

OTOH, I thought if we reserve high memory then the low memory should be
needed.  There might be some exceptions, but I do not know the exact
one, can we make the behavior same, and special case those systems which
do not need low memory reservation.

> 
> previous discusses:
> 	https://lkml.org/lkml/2019/6/5/670
> 	https://lkml.org/lkml/2019/6/13/229

Another concern from James:
"
With both crashk_low_res and crashk_res, we end up with two entries in /proc/iomem called
"Crash kernel". Because its sorted by address, and kexec-tools stops searching when it
find "Crash kernel", you are always going to get the kernel placed in the lower portion.
"

The kexec-tools code is iterating all "Crash kernel" ranges and add them
in an array.  In X86 code, it uses the higher range to locate memory.

> 
> > 
> >>
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  arch/x86/kernel/setup.c    | 62 ++++-----------------------------
> >>  include/linux/crash_core.h |  3 ++
> >>  include/linux/kexec.h      |  2 --
> >>  kernel/crash_core.c        | 87 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  kernel/kexec_core.c        | 17 ---------
> >>  5 files changed, 96 insertions(+), 75 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> index cedfe20..5f38942 100644
> >> --- a/arch/x86/kernel/setup.c
> >> +++ b/arch/x86/kernel/setup.c
> >> @@ -486,59 +486,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
> >>  # define CRASH_ADDR_HIGH_MAX	SZ_64T
> >>  #endif
> >>  
> >> -static int __init reserve_crashkernel_low(void)
> >> -{
> >> -#ifdef CONFIG_X86_64
> >> -	unsigned long long base, low_base = 0, low_size = 0;
> >> -	unsigned long total_low_mem;
> >> -	int ret;
> >> -
> >> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> >> -
> >> -	/* crashkernel=Y,low */
> >> -	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
> >> -	if (ret) {
> >> -		/*
> >> -		 * two parts from kernel/dma/swiotlb.c:
> >> -		 * -swiotlb size: user-specified with swiotlb= or default.
> >> -		 *
> >> -		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> >> -		 * to 8M for other buffers that may need to stay low too. Also
> >> -		 * make sure we allocate enough extra low memory so that we
> >> -		 * don't run out of DMA buffers for 32-bit devices.
> >> -		 */
> >> -		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> >> -	} else {
> >> -		/* passed with crashkernel=0,low ? */
> >> -		if (!low_size)
> >> -			return 0;
> >> -	}
> >> -
> >> -	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> >> -	if (!low_base) {
> >> -		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> >> -		       (unsigned long)(low_size >> 20));
> >> -		return -ENOMEM;
> >> -	}
> >> -
> >> -	ret = memblock_reserve(low_base, low_size);
> >> -	if (ret) {
> >> -		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
> >> -		return ret;
> >> -	}
> >> -
> >> -	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
> >> -		(unsigned long)(low_size >> 20),
> >> -		(unsigned long)(low_base >> 20),
> >> -		(unsigned long)(total_low_mem >> 20));
> >> -
> >> -	crashk_low_res.start = low_base;
> >> -	crashk_low_res.end   = low_base + low_size - 1;
> >> -	insert_resource(&iomem_resource, &crashk_low_res);
> >> -#endif
> >> -	return 0;
> >> -}
> >> -
> >>  static void __init reserve_crashkernel(void)
> >>  {
> >>  	unsigned long long crash_size, crash_base, total_mem;
> >> @@ -602,9 +549,12 @@ static void __init reserve_crashkernel(void)
> >>  		return;
> >>  	}
> >>  
> >> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> >> -		memblock_free(crash_base, crash_size);
> >> -		return;
> >> +	if (crash_base >= (1ULL << 32)) {
> >> +		if (reserve_crashkernel_low()) {
> >> +			memblock_free(crash_base, crash_size);
> >> +			return;
> >> +		}
> >> +		insert_resource(&iomem_resource, &crashk_low_res);
> > 
> > Some specific reason to move insert_resouce out of the
> > reserve_crashkernel_low function?
> 
> No specific reason.
> I just exposed arm64 "Crash kernel low" in request_standard_resources() as other resources,
> so did this change.

Ok.

> 
> > 
> >>  	}
> >>  
> >>  	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> >> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> >> index 525510a..4df8c0b 100644
> >> --- a/include/linux/crash_core.h
> >> +++ b/include/linux/crash_core.h
> >> @@ -63,6 +63,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> >>  extern unsigned char *vmcoreinfo_data;
> >>  extern size_t vmcoreinfo_size;
> >>  extern u32 *vmcoreinfo_note;
> >> +extern struct resource crashk_res;
> >> +extern struct resource crashk_low_res;
> >>  
> >>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> >>  			  void *data, size_t data_len);
> >> @@ -74,5 +76,6 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
> >>  		unsigned long long *crash_size, unsigned long long *crash_base);
> >>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> >>  		unsigned long long *crash_size, unsigned long long *crash_base);
> >> +int __init reserve_crashkernel_low(void);
> >>  
> >>  #endif /* LINUX_CRASH_CORE_H */
> >> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> >> index 1776eb2..5d5d963 100644
> >> --- a/include/linux/kexec.h
> >> +++ b/include/linux/kexec.h
> >> @@ -330,8 +330,6 @@ extern int kexec_load_disabled;
> >>  
> >>  /* Location of a reserved region to hold the crash kernel.
> >>   */
> >> -extern struct resource crashk_res;
> >> -extern struct resource crashk_low_res;
> >>  extern note_buf_t __percpu *crash_notes;
> >>  
> >>  /* flag to track if kexec reboot is in progress */
> >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> index 9f1557b..eb72fd6 100644
> >> --- a/kernel/crash_core.c
> >> +++ b/kernel/crash_core.c
> >> @@ -7,6 +7,8 @@
> >>  #include <linux/crash_core.h>
> >>  #include <linux/utsname.h>
> >>  #include <linux/vmalloc.h>
> >> +#include <linux/memblock.h>
> >> +#include <linux/swiotlb.h>
> >>  
> >>  #include <asm/page.h>
> >>  #include <asm/sections.h>
> >> @@ -19,6 +21,22 @@ u32 *vmcoreinfo_note;
> >>  /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
> >>  static unsigned char *vmcoreinfo_data_safecopy;
> >>  
> >> +/* Location of the reserved area for the crash kernel */
> >> +struct resource crashk_res = {
> >> +	.name  = "Crash kernel",
> >> +	.start = 0,
> >> +	.end   = 0,
> >> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> >> +	.desc  = IORES_DESC_CRASH_KERNEL
> >> +};
> >> +struct resource crashk_low_res = {
> >> +	.name  = "Crash kernel",
> >> +	.start = 0,
> >> +	.end   = 0,
> >> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> >> +	.desc  = IORES_DESC_CRASH_KERNEL
> >> +};
> >> +
> >>  /*
> >>   * parsing the "crashkernel" commandline
> >>   *
> >> @@ -292,6 +310,75 @@ int __init parse_crashkernel_low(char *cmdline,
> >>  				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
> >>  }
> >>  
> >> +#if defined(CONFIG_X86_64)
> >> +#define CRASH_ALIGN		SZ_16M
> >> +#elif defined(CONFIG_ARM64)
> >> +#define CRASH_ALIGN		SZ_2M
> >> +#endif
> > 
> > I think no need to have the #ifdef, although I can not think out of
> > reason we have 16M for X86, maybe move it to 2M as well if no other
> > objections.  Then it will be easier to reserve crashkernel successfully
> > considering nowadays we have KASLR and other stuff it becomes harder.
> 
> I also don't figure out why it is 16M in x86.

IMHO, if we do not know why and in theory it should work with 2M, can
you do some basic testing and move it to 2M?

We can easily move back to 16M if someone really report something, but
if we do not change it will always stay there but we do not know why.

> 
> > 
> >> +
> >> +int __init reserve_crashkernel_low(void)
> >> +{
> >> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> >> +	unsigned long long base, low_base = 0, low_size = 0;
> >> +	unsigned long total_low_mem;
> >> +	int ret;
> >> +
> >> +	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> >> +
> >> +	/* crashkernel=Y,low */
> >> +	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size,
> >> +			&base);
> >> +	if (ret) {
> >> +#ifdef CONFIG_X86_64
> >> +		/*
> >> +		 * two parts from lib/swiotlb.c:
> >> +		 * -swiotlb size: user-specified with swiotlb= or default.
> >> +		 *
> >> +		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> >> +		 * to 8M for other buffers that may need to stay low too. Also
> >> +		 * make sure we allocate enough extra low memory so that we
> >> +		 * don't run out of DMA buffers for 32-bit devices.
> >> +		 */
> >> +		low_size = max(swiotlb_size_or_default() + (8UL << 20),
> >> +				256UL << 20);
> >> +#else
> >> +		/*
> >> +		 * in arm64, reserve low memory if and only if crashkernel=X,low
> >> +		 * specified.
> >> +		 */
> >> +		return -EINVAL;
> >> +#endif
> > 
> > As said before, can you explore about why it needs different logic, it
> > would be good to keep two arches same.
> > 
> >> +	} else {
> >> +		/* passed with crashkernel=0,low ? */
> >> +		if (!low_size)
> >> +			return 0;
> >> +	}
> >> +
> >> +	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> >> +	if (!low_base) {
> >> +		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> >> +		       (unsigned long)(low_size >> 20));
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	ret = memblock_reserve(low_base, low_size);
> >> +	if (ret) {
> >> +		pr_err("%s: Error reserving crashkernel low memblock.\n",
> >> +				__func__);
> >> +		return ret;
> >> +	}
> >> +
> >> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
> >> +		(unsigned long)(low_size >> 20),
> >> +		(unsigned long)(low_base >> 20),
> >> +		(unsigned long)(total_low_mem >> 20));
> >> +
> >> +	crashk_low_res.start = low_base;
> >> +	crashk_low_res.end   = low_base + low_size - 1;
> >> +#endif
> >> +	return 0;
> >> +}
> >> +
> >>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> >>  			  void *data, size_t data_len)
> >>  {
> >> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> index 15d70a9..458d093 100644
> >> --- a/kernel/kexec_core.c
> >> +++ b/kernel/kexec_core.c
> >> @@ -53,23 +53,6 @@ note_buf_t __percpu *crash_notes;
> >>  /* Flag to indicate we are going to kexec a new kernel */
> >>  bool kexec_in_progress = false;
> >>  
> >> -
> >> -/* Location of the reserved area for the crash kernel */
> >> -struct resource crashk_res = {
> >> -	.name  = "Crash kernel",
> >> -	.start = 0,
> >> -	.end   = 0,
> >> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> >> -	.desc  = IORES_DESC_CRASH_KERNEL
> >> -};
> >> -struct resource crashk_low_res = {
> >> -	.name  = "Crash kernel",
> >> -	.start = 0,
> >> -	.end   = 0,
> >> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> >> -	.desc  = IORES_DESC_CRASH_KERNEL
> >> -};
> >> -
> >>  int kexec_should_crash(struct task_struct *p)
> >>  {
> >>  	/*
> >> -- 
> >> 2.7.4
> >>
> > 
> > Thanks
> > Dave
> > 
> > 
> > .
> > 
> Thanks,
> Chen Zhou
> 

Thanks
Dave

