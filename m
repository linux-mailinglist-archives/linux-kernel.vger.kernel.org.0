Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3519A88C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbgDAJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 05:22:34 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:37845 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbgDAJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585732953;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fFF9OUeXr1h4Pp47sdoLaY1EMBBVAx8Wu/mPO2HYv8U=;
  b=IhTK0RSJ6c1qLJMqkWi+S8xjK617hFRIbonHpVIoNRv90xXr5LJJofpw
   zAyldCn/V1IumYorkJWzxYRS1F1OV9QwDbswUwhWY1jScu0HY5+U19yT5
   xslShqefBZNNcbueJGGbw41ar49p77b7WLCdyZfAQICuCm31lQZyXF2P6
   c=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 47JPB1ufd71MwYKC3AM8prCu8I1IjLXO5EQQCaMwtAITzLQJv0Wp0LBs3UbGfA8rS2xuKjsHeh
 eXAsBLMZSjrMOyof7KevSjCBWzHUn8PuRIpFsWlwglJuG/kdNNOearKX7lmw+ViPQ25XY+r6ZI
 3sV9x0c02Bwz1FRcOX6hvJXrxwWtKpdyobJAUuUKwnsbRDbWnzLGqVr1fZqzvG/68XIPpF8Jdh
 cfkxHwHIRagklFTWCtVW+9d5WWlPdLtCl6gOAKh6doAXExBHXLFsQXF5GLa/pgA9iRtXTFDl3n
 qrE=
X-SBRS: 2.7
X-MesageID: 15394601
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,331,1580792400"; 
   d="scan'208";a="15394601"
Subject: Re: [PATCH v2] x86/smpboot: Remove 486-isms from the modern AP boot
 path
To:     Brian Gerst <brgerst@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        <jailhouse-dev@googlegroups.com>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
 <20200331175810.30204-1-andrew.cooper3@citrix.com>
 <CAMzpN2i6Nf0VDZ82mXyFixN879FC4eZfqe-LzWGkvygcz1gH_Q@mail.gmail.com>
 <c46bcb6d-4256-2d65-9cd9-33e010846de4@citrix.com>
 <CAMzpN2gdkmYYbQatFk66QMpiuZSfnUQUVtJ30VYF7nsX_+XVgA@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <bdf7995d-2d50-9bb9-8066-6c4ccfaa5b52@citrix.com>
Date:   Wed, 1 Apr 2020 10:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMzpN2gdkmYYbQatFk66QMpiuZSfnUQUVtJ30VYF7nsX_+XVgA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2020 23:53, Brian Gerst wrote:
> On Tue, Mar 31, 2020 at 6:44 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 31/03/2020 23:23, Brian Gerst wrote:
>>> On Tue, Mar 31, 2020 at 1:59 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>>>> Linux has an implementation of the Universal Start-up Algorithm (MP spec,
>>>> Appendix B.4, Application Processor Startup), which includes unconditionally
>>>> writing to the Bios Data Area and CMOS registers.
>>>>
>>>> The warm reset vector is only necessary in the non-integrated Local APIC case.
>>>> UV and Jailhouse already have an opt-out for this behaviour, but blindly using
>>>> the BDA and CMOS on a UEFI or other reduced hardware system isn't clever.
>>>>
>>>> We could make this conditional on the integrated-ness of the Local APIC, but
>>>> 486-era SMP isn't supported.  Drop the logic completely, tidying up the includ
>>>> list and header files as appropriate.
>>>>
>>>> CC: Thomas Gleixner <tglx@linutronix.de>
>>>> CC: Ingo Molnar <mingo@redhat.com>
>>>> CC: Borislav Petkov <bp@alien8.de>
>>>> CC: "H. Peter Anvin" <hpa@zytor.com>
>>>> CC: x86@kernel.org
>>>> CC: Jan Kiszka <jan.kiszka@siemens.com>
>>>> CC: James Morris <jmorris@namei.org>
>>>> CC: David Howells <dhowells@redhat.com>
>>>> CC: Andrew Cooper <andrew.cooper3@citrix.com>
>>>> CC: Matthew Garrett <mjg59@google.com>
>>>> CC: Josh Boyer <jwboyer@redhat.com>
>>>> CC: Steve Wahl <steve.wahl@hpe.com>
>>>> CC: Mike Travis <mike.travis@hpe.com>
>>>> CC: Dimitri Sivanich <dimitri.sivanich@hpe.com>
>>>> CC: Arnd Bergmann <arnd@arndb.de>
>>>> CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>>>> CC: Giovanni Gherdovich <ggherdovich@suse.cz>
>>>> CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>> CC: Len Brown <len.brown@intel.com>
>>>> CC: Kees Cook <keescook@chromium.org>
>>>> CC: Martin Molnar <martin.molnar.programming@gmail.com>
>>>> CC: Pingfan Liu <kernelfans@gmail.com>
>>>> CC: linux-kernel@vger.kernel.org
>>>> CC: jailhouse-dev@googlegroups.com
>>>> Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
>>>> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
>>>> ---
>>>> v2:
>>>>  * Drop logic entirely, rather than retaining support in 32bit builds.
>>>> ---
>>>>  arch/x86/include/asm/apic.h        |  6 -----
>>>>  arch/x86/include/asm/x86_init.h    |  1 -
>>>>  arch/x86/kernel/apic/x2apic_uv_x.c |  1 -
>>>>  arch/x86/kernel/jailhouse.c        |  1 -
>>>>  arch/x86/kernel/platform-quirks.c  |  1 -
>>>>  arch/x86/kernel/smpboot.c          | 50 --------------------------------------
>>>>  6 files changed, 60 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
>>>> index 19e94af9cc5d..5c33f9374b28 100644
>>>> --- a/arch/x86/include/asm/apic.h
>>>> +++ b/arch/x86/include/asm/apic.h
>>>> @@ -472,12 +472,6 @@ static inline unsigned default_get_apic_id(unsigned long x)
>>>>                 return (x >> 24) & 0x0F;
>>>>  }
>>>>
>>>> -/*
>>>> - * Warm reset vector position:
>>>> - */
>>>> -#define TRAMPOLINE_PHYS_LOW            0x467
>>>> -#define TRAMPOLINE_PHYS_HIGH           0x469
>>>> -
>>>>  extern void generic_bigsmp_probe(void);
>>>>
>>>>  #ifdef CONFIG_X86_LOCAL_APIC
>>>> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
>>>> index 96d9cd208610..006a5d7fd7eb 100644
>>>> --- a/arch/x86/include/asm/x86_init.h
>>>> +++ b/arch/x86/include/asm/x86_init.h
>>>> @@ -229,7 +229,6 @@ enum x86_legacy_i8042_state {
>>>>  struct x86_legacy_features {
>>>>         enum x86_legacy_i8042_state i8042;
>>>>         int rtc;
>>>> -       int warm_reset;
>>>>         int no_vga;
>>>>         int reserve_bios_regions;
>>>>         struct x86_legacy_devices devices;
>>>> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
>>>> index ad53b2abc859..5afcfd193592 100644
>>>> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
>>>> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
>>>> @@ -343,7 +343,6 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
>>>>         } else if (!strcmp(oem_table_id, "UVH")) {
>>>>                 /* Only UV1 systems: */
>>>>                 uv_system_type = UV_NON_UNIQUE_APIC;
>>>> -               x86_platform.legacy.warm_reset = 0;
>>>>                 __this_cpu_write(x2apic_extra_bits, pnodeid << uvh_apicid.s.pnode_shift);
>>>>                 uv_set_apicid_hibit();
>>>>                 uv_apic = 1;
>>>> diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
>>>> index 6eb8b50ea07e..d628fe92d6af 100644
>>>> --- a/arch/x86/kernel/jailhouse.c
>>>> +++ b/arch/x86/kernel/jailhouse.c
>>>> @@ -210,7 +210,6 @@ static void __init jailhouse_init_platform(void)
>>>>         x86_platform.calibrate_tsc      = jailhouse_get_tsc;
>>>>         x86_platform.get_wallclock      = jailhouse_get_wallclock;
>>>>         x86_platform.legacy.rtc         = 0;
>>>> -       x86_platform.legacy.warm_reset  = 0;
>>>>         x86_platform.legacy.i8042       = X86_LEGACY_I8042_PLATFORM_ABSENT;
>>>>
>>>>         legacy_pic                      = &null_legacy_pic;
>>>> diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
>>>> index b348a672f71d..d922c5e0c678 100644
>>>> --- a/arch/x86/kernel/platform-quirks.c
>>>> +++ b/arch/x86/kernel/platform-quirks.c
>>>> @@ -9,7 +9,6 @@ void __init x86_early_init_platform_quirks(void)
>>>>  {
>>>>         x86_platform.legacy.i8042 = X86_LEGACY_I8042_EXPECTED_PRESENT;
>>>>         x86_platform.legacy.rtc = 1;
>>>> -       x86_platform.legacy.warm_reset = 1;
>>>>         x86_platform.legacy.reserve_bios_regions = 0;
>>>>         x86_platform.legacy.devices.pnpbios = 1;
>>>>
>>>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>>>> index fe3ab9632f3b..a9f5b511d0b4 100644
>>>> --- a/arch/x86/kernel/smpboot.c
>>>> +++ b/arch/x86/kernel/smpboot.c
>>>> @@ -72,7 +72,6 @@
>>>>  #include <asm/fpu/internal.h>
>>>>  #include <asm/setup.h>
>>>>  #include <asm/uv/uv.h>
>>>> -#include <linux/mc146818rtc.h>
>>>>  #include <asm/i8259.h>
>>>>  #include <asm/misc.h>
>>>>  #include <asm/qspinlock.h>
>>>> @@ -119,34 +118,6 @@ int arch_update_cpu_topology(void)
>>>>         return retval;
>>>>  }
>>>>
>>>> -static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
>>>> -{
>>>> -       unsigned long flags;
>>>> -
>>>> -       spin_lock_irqsave(&rtc_lock, flags);
>>>> -       CMOS_WRITE(0xa, 0xf);
>>>> -       spin_unlock_irqrestore(&rtc_lock, flags);
>>>> -       *((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
>>>> -                                                       start_eip >> 4;
>>>> -       *((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
>>>> -                                                       start_eip & 0xf;
>>>> -}
>>>> -
>>>> -static inline void smpboot_restore_warm_reset_vector(void)
>>>> -{
>>>> -       unsigned long flags;
>>>> -
>>>> -       /*
>>>> -        * Paranoid:  Set warm reset code and vector here back
>>>> -        * to default values.
>>>> -        */
>>>> -       spin_lock_irqsave(&rtc_lock, flags);
>>>> -       CMOS_WRITE(0, 0xf);
>>>> -       spin_unlock_irqrestore(&rtc_lock, flags);
>>>> -
>>>> -       *((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
>>>> -}
>>>> -
>>>>  static void init_freq_invariance(void);
>>>>
>>>>  /*
>>>> @@ -1049,20 +1020,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>>>          * the targeted processor.
>>>>          */
>>>>
>>>> -       if (x86_platform.legacy.warm_reset) {
>>>> -
>>>> -               pr_debug("Setting warm reset code and vector.\n");
>>>> -
>>>> -               smpboot_setup_warm_reset_vector(start_ip);
>>>> -               /*
>>>> -                * Be paranoid about clearing APIC errors.
>>>> -               */
>>>> -               if (APIC_INTEGRATED(boot_cpu_apic_version)) {
>>>> -                       apic_write(APIC_ESR, 0);
>>>> -                       apic_read(APIC_ESR);
>>>> -               }
>>>> -       }
>>>> -
>>>>         /*
>>>>          * AP might wait on cpu_callout_mask in cpu_init() with
>>>>          * cpu_initialized_mask set if previous attempt to online
>>>> @@ -1118,13 +1075,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>>>                 }
>>>>         }
>>>>
>>>> -       if (x86_platform.legacy.warm_reset) {
>>>> -               /*
>>>> -                * Cleanup possible dangling ends...
>>>> -                */
>>>> -               smpboot_restore_warm_reset_vector();
>>>> -       }
>>>> -
>>>>         return boot_error;
>>>>  }
>>> You removed x86_platform.legacy.warm_reset in the original patch, but
>>> that is missing in V2.
>> Second hunk?  Or are you referring to something different?
> Removing the warm_reset field from struct x86_legacy_features.

Ok, but that is still present as the 2nd hunk of the patch.

~Andrew
