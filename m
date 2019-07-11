Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58FB6461A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfGJMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 08:19:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47545 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:19:33 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlBZI-0001sp-BD; Wed, 10 Jul 2019 14:19:28 +0200
Date:   Wed, 10 Jul 2019 14:19:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xi Ruoyao <xry111@mengyan1223.wang>
cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
Message-ID: <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
References: <20190708162756.GA69120@gmail.com>  <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>  <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>  <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
  <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>  <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>  <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>  <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
  <201907091727.91CC6C72D8@keescook>  <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang> <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019, Xi Ruoyao wrote:
> On 2019-07-10 19:27 +0800, Xi Ruoyao wrote:
> > On 2019-07-09 17:31 -0700, Kees Cook wrote:
> > > On Wed, Jul 10, 2019 at 01:17:11AM +0200, Thomas Gleixner wrote:
> > > > On Wed, 10 Jul 2019, Thomas Gleixner wrote:
> > > > > That still does not explain the cr4/0 issue you have. Can you send me
> > > > > your
> > > > > .config please?
> > > > 
> > > > Does your machine have UMIP support? None of my test boxes has. So that'd
> > > > be the difference of bits enforced in CR4. Should not matter because it's
> > > > User mode instruction prevention, but who knows.
> > > 
> > > Ew. Yeah, I don't have i9 nor i7 for testing this. I did try everything
> > > else I had (and hibernation). Is only Linus able to reproduce this so far?
> > 
> > I can, too.
> > 
> > > To rule out (in?) UMIP, this would remove UMIP from the pinning:
> > > 
> > > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > > index 309b6b9b49d4..f3beedb6da8a 100644
> > > --- a/arch/x86/kernel/cpu/common.c
> > > +++ b/arch/x86/kernel/cpu/common.c
> > > @@ -380,7 +380,7 @@ static void __init setup_cr_pinning(void)
> > >  {
> > >  	unsigned long mask;
> > >  
> > > -	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
> > > +	mask = (X86_CR4_SMEP | X86_CR4_SMAP);
> > >  	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
> > >  	static_key_enable(&cr_pinning.key);
> > >  }
> > 
> > I'll try it.
> 
> That doesn't work, sadly.
>
> My laptop is an old i3-3217u.
> 
> My .config and syslog snip are attached.

From the log:

BUG: unable to handle page fault for address: ffffffff9edc1598
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 1a20c067 P4D 1a20c067 PUD 1a20d063 PMD 8000000019e000e1 
Oops: 0003 [#1] SMP PTI
2 PID: 151 Comm: systemd-udevd Not tainted 5.2.0+ #54
Hardware name: LENOVO 20175/INVALID, BIOS 66CN54WW 01/21/2013
RIP: 0010:static_key_set_mod.isra.0+0x10/0x30
Code: 48 8b 37 83 e6 03 48 09 c6 48 89 37 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f0 a8 03 75 0d 48 8b 37 83 e6 03 48 09 c6 <48> 89 37 c3 0f 0b 48 8b 37 83 e6 03 48 09 c6 48 89 37 c3 66 66 2e
RSP: 0000:ffffa606c032bc98 EFLAGS: 00010286
RAX: ffff9981ddce30a0 RBX: ffffffff9edc1590 RCX: 0000000000000000
RDX: 0000000000000020 RSI: ffff9981ddce30a0 RDI: ffffffff9edc1598
RBP: ffffffffc06f4000 R08: ffff9981e6003980 R09: ffff9981ddce30a0
R10: 0000000000000000 R11: 0000000000028b56 R12: ffffffffc06f8880
R13: ffff9981ddce3080 R14: ffffffffc06f4008 R15: ffffffffc06f6dc0
FS:  00007f992dd9a680(0000) GS:ffff9981e7080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff9edc1598 CR3: 00000002233aa001 CR4: 00000000001606e0
Call Trace:
  jump_label_module_notify+0x1e7/0x2b0
  notifier_call_chain+0x44/0x70
  blocking_notifier_call_chain+0x43/0x60
  load_module+0x1bcb/0x2490
  ? vfs_read+0x11f/0x150
  ? __do_sys_finit_module+0xbf/0xe0
  __do_sys_finit_module+0xbf/0xe0
  do_syscall_64+0x43/0x110
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Josh, didn't you mention that yesterday or so?


RIP: 0033:0x7f992e2eeaf9
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 67 73 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffca220d288 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 00000000009b8da0 RCX: 00007f992e2eeaf9
RDX: 0000000000000000 RSI: 00007f992e464885 RDI: 0000000000000010
RBP: 0000000000020000 R08: 0000000000000000 R09: 00000000009c45c0
R10: 0000000000000010 R11: 0000000000000246 R12: 00007f992e464885
R13: 0000000000000000 R14: 00000000009acc50 R15: 00000000009b8da0
Modules linked in: kvm_intel(+) kvm irqbypass hid_sensor_hub crc32_pclmul mfd_core i2c_i801 snd_hda_intel i915(+) intel_gtt snd_hda_codec i2c_algo_bit snd_hwdep snd_hda_core drm_kms_helper snd_pcm syscopyarea sysfillrect sysimgblt fb_sys_fops drm hid_multitouch ideapad_laptop sparse_keymap hid_generic wmi efivarfs
CR2: ffffffff9edc1598
[ end trace dbeb7e66daa9bdca ]---

RIP: 0010:static_key_set_mod.isra.0+0x10/0x30
Code: 48 8b 37 83 e6 03 48 09 c6 48 89 37 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f0 a8 03 75 0d 48 8b 37 83 e6 03 48 09 c6 <48> 89 37 c3 0f 0b 48 8b 37 83 e6 03 48 09 c6 48 89 37 c3 66 66 2e
RSP: 0000:ffffa606c032bc98 EFLAGS: 00010286
RAX: ffff9981ddce30a0 RBX: ffffffff9edc1590 RCX: 0000000000000000
RDX: 0000000000000020 RSI: ffff9981ddce30a0 RDI: ffffffff9edc1598
RBP: ffffffffc06f4000 R08: ffff9981e6003980 R09: ffff9981ddce30a0
R10: 0000000000000000 R11: 0000000000028b56 R12: ffffffffc06f8880
R13: ffff9981ddce3080 R14: ffffffffc06f4008 R15: ffffffffc06f6dc0
FS:  00007f992dd9a680(0000) GS:ffff9981e7080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff9edc1598 CR3: 00000002233aa001 CR4: 00000000001606e0
