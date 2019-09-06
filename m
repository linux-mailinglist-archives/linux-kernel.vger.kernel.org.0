Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A014AB73D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbfIFLhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 07:37:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:30308 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389929AbfIFLhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:37:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 04:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="183117360"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.130.212]) ([10.249.130.212])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2019 04:37:31 -0700
Subject: Re: [PATCH v5 00/10] EFI Specific Purpose Memory Support
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2329745.bCNtynFxEq@kreacher>
 <CAPcyv4ggOXjzaYZb4qCMQQL-Xf3fbZqKzqHTUBins_fv3=cEbw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <67107eb8-13bc-36ee-0708-7f5ba1d74d9e@intel.com>
Date:   Fri, 6 Sep 2019 13:37:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ggOXjzaYZb4qCMQQL-Xf3fbZqKzqHTUBins_fv3=cEbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2019 1:06 AM, Dan Williams wrote:
> On Mon, Sep 2, 2019 at 4:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, August 30, 2019 3:52:18 AM CEST Dan Williams wrote:
>>> Changes since v4 [1]:
>>> - Rename the facility from "Application Reserved" to "Soft Reserved" to
>>>    better reflect how the memory is treated. While the spec talks about
>>>    "specific / application purpose" memory the expected kernel behavior is
>>>    to make a best effort at reserving the memory from general purpose
>>>    allocations.
>>>
>>> - Add a new efi=nosoftreserve option to disable consideration of the
>>>    EFI_MEMORY_SP attribute at boot time. This is also motivated by
>>>    Christoph's initial feedback of allowing the kernel to opt-out of the
>>>    policy whims of the platform BIOS implementation.
>>>
>>> - Update the KASLR implementation to exclude soft-reserved memory
>>>    including the case where soft-reserved memory is specified via the
>>>    efi_fake_mem= attribute-override command-line option.
>>>
>>> - Move the memregion allocator to its own object file. v4 had it in
>>>    kernel/resource.c which caused compile errors on Sparc. I otherwise
>>>    could not find an appropriate place to stash it.
>>>
>>> - Rebase on a merge of tip/master and rafael/linux-next since the series
>>>    collides with changes in both those trees.
>>>
>>> [1]: https://lore.kernel.org/r/156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>
>>> ---
>>>
>>> Thomas, Rafael,
>>>
>>> This happens to collide with both your trees. I think the content
>>> warrants going through the x86 tree, but would need to publish commit:
>>>
>>> 5c7ed4385424 HMAT: Skip publishing target info for nodes with no online memory
>>>
>>> ...in Rafael's tree as a stable id for -tip to pull in, but I'm also
>>> open to other options. I've retained Dave's reviewed-by from v4.
>>>
>>> ---
>>>
>>> The EFI 2.8 Specification [2] introduces the EFI_MEMORY_SP ("specific
>>> purpose") memory attribute. This attribute bit replaces the deprecated
>>> ACPI HMAT "reservation hint" that was introduced in ACPI 6.2 and removed
>>> in ACPI 6.3.
>>>
>>> Given the increasing diversity of memory types that might be advertised
>>> to the operating system, there is a need for platform firmware to hint
>>> which memory ranges are free for the OS to use as general purpose memory
>>> and which ranges are intended for application specific usage. For
>>> example, an application with prior knowledge of the platform may expect
>>> to be able to exclusively allocate a precious / limited pool of high
>>> bandwidth memory. Alternatively, for the general purpose case, the
>>> operating system may want to make the memory available on a best effort
>>> basis as a unique numa-node with performance properties by the new
>>> CONFIG_HMEM_REPORTING [3] facility.
>>>
>>> In support of optionally allowing either application-exclusive and
>>> core-kernel-mm managed access to differentiated memory, claim
>>> EFI_MEMORY_SP ranges for exposure as "soft reserved" and assigned to a
>>> device-dax instance by default. Such instances can be directly owned /
>>> mapped by a platform-topology-aware application. Alternatively, with the
>>> new kmem facility [4], the administrator has the option to instead
>>> designate that those memory ranges be hot-added to the core-kernel-mm as
>>> a unique memory numa-node. In short, allow for the decision about what
>>> software agent manages soft-reserved memory to be made at runtime.
>>>
>>> The patches build on the new HMAT+HMEM_REPORTING facilities merged
>>> for v5.2-rc1. The implementation is tested with qemu emulation of HMAT
>>> [5] plus the efi_fake_mem facility for applying the EFI_MEMORY_SP
>>> attribute. Specific details on reproducing the test configuration are in
>>> patch 10.
>>>
>>> [2]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
>>> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1cf33aafb84
>>> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
>>> [5]: http://patchwork.ozlabs.org/cover/1096737/
>>>
>>> ---
>>>
>>> Dan Williams (10):
>>>        acpi/numa: Establish a new drivers/acpi/numa/ directory
>>>        efi: Enumerate EFI_MEMORY_SP
>>>        x86, efi: Push EFI_MEMMAP check into leaf routines
>>>        x86, efi: Reserve UEFI 2.8 Specific Purpose Memory for dax
>>>        x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
>>>        lib: Uplevel the pmem "region" ida to a global allocator
>>>        dax: Fix alloc_dax_region() compile warning
>>>        device-dax: Add a driver for "hmem" devices
>>>        acpi/numa/hmat: Register HMAT at device_initcall level
>>>        acpi/numa/hmat: Register "soft reserved" memory as an "hmem" device
>>>
>>>
>>>   Documentation/admin-guide/kernel-parameters.txt |   19 +++
>>>   arch/x86/Kconfig                                |   21 ++++
>>>   arch/x86/boot/compressed/eboot.c                |    7 +
>>>   arch/x86/boot/compressed/kaslr.c                |   50 +++++++-
>>>   arch/x86/include/asm/e820/types.h               |    8 +
>>>   arch/x86/include/asm/efi-stub.h                 |   11 ++
>>>   arch/x86/include/asm/efi.h                      |   17 +++
>>>   arch/x86/kernel/e820.c                          |   12 ++
>>>   arch/x86/kernel/setup.c                         |   19 ++-
>>>   arch/x86/platform/efi/efi.c                     |   56 +++++++++
>>>   arch/x86/platform/efi/quirks.c                  |    3 +
>>>   drivers/acpi/Kconfig                            |    9 --
>>>   drivers/acpi/Makefile                           |    3 -
>>>   drivers/acpi/hmat/Makefile                      |    2
>>>   drivers/acpi/numa/Kconfig                       |    8 +
>>>   drivers/acpi/numa/Makefile                      |    3 +
>>>   drivers/acpi/numa/hmat.c                        |  138 +++++++++++++++++++++--
>>>   drivers/acpi/numa/srat.c                        |    0
>>>   drivers/dax/Kconfig                             |   27 ++++-
>>>   drivers/dax/Makefile                            |    2
>>>   drivers/dax/bus.c                               |    2
>>>   drivers/dax/bus.h                               |    2
>>>   drivers/dax/dax-private.h                       |    2
>>>   drivers/dax/hmem.c                              |   57 ++++++++++
>>>   drivers/firmware/efi/Makefile                   |    5 +
>>>   drivers/firmware/efi/efi.c                      |    8 +
>>>   drivers/firmware/efi/esrt.c                     |    3 +
>>>   drivers/firmware/efi/fake_mem.c                 |   26 ++--
>>>   drivers/firmware/efi/fake_mem.h                 |   10 ++
>>>   drivers/firmware/efi/libstub/efi-stub-helper.c  |   12 ++
>>>   drivers/firmware/efi/x86-fake_mem.c             |   69 ++++++++++++
>>>   drivers/nvdimm/Kconfig                          |    1
>>>   drivers/nvdimm/core.c                           |    1
>>>   drivers/nvdimm/nd-core.h                        |    1
>>>   drivers/nvdimm/region_devs.c                    |   13 +-
>>>   include/linux/efi.h                             |    4 -
>>>   include/linux/ioport.h                          |    1
>>>   include/linux/memregion.h                       |   23 ++++
>>>   lib/Kconfig                                     |    3 +
>>>   lib/Makefile                                    |    1
>>>   lib/memregion.c                                 |   18 +++
>>>   41 files changed, 584 insertions(+), 93 deletions(-)
>>>   create mode 100644 arch/x86/include/asm/efi-stub.h
>>>   delete mode 100644 drivers/acpi/hmat/Makefile
>>>   rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (70%)
>>>   create mode 100644 drivers/acpi/numa/Makefile
>>>   rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (85%)
>>>   rename drivers/acpi/{numa.c => numa/srat.c} (100%)
>>>   create mode 100644 drivers/dax/hmem.c
>>>   create mode 100644 drivers/firmware/efi/fake_mem.h
>>>   create mode 100644 drivers/firmware/efi/x86-fake_mem.c
>>>   create mode 100644 include/linux/memregion.h
>>>   create mode 100644 lib/memregion.c
>>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> for the ACPI-related changes in this series.
> Thanks Rafael, is commit 5c7ed4385424 on a stable branch that Thomas
> could merge, or Thomas, is this all too late for v5.4?

Yes, I've just exported the acpi-tables branch containing that commit as 
a stable one in the linux-pm.git tree at kernel.org.

Cheers!


