Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B77263E30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGIXAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 19:00:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46435 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGIXAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:00:41 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkz69-0007ym-0U; Wed, 10 Jul 2019 01:00:33 +0200
Date:   Wed, 10 Jul 2019 01:00:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com> <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com> <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com> <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
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

On Wed, 10 Jul 2019, Thomas Gleixner wrote:
> On Tue, 9 Jul 2019, Linus Torvalds wrote:
> > I also don't have any logs, because the boot never gets far enough. I
> > assume that there was a problem bringing up a non-boot CPU, and the
> > eventual hang ends up being due to that.
> 
> Hrm. I just build the tip of your tree and bootet it. It hangs at:
> 
> [    4.788678] ACPI: 4 ACPI AML tables successfully acquired and loaded
> [    4.793860] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    4.821476] ACPI: Dynamic OEM Table Load:
> 
> That's way after the secondary CPUs have been brought up. tip/master boots
> without problems with the same config. Let me try x86/asm alone and also a
> revert of the CR4/CR0 stuff.

x86/asm works alone

revert of cr4/0 pinning on top of your tree gets stuck as well

> And while writing this the softlockup detector muttered:

Have not yet fully bisected it, but Jiri did and he ended up with

  c522ad0637ca ("ACPICA: Update table load object initialization")

Reverting that on top of your tree makes it work again. Tony has the same
issue.

That still does not explain the cr4/0 issue you have. Can you send me your
.config please?

Thanks,

	tglx



