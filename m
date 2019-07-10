Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF7644D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGJKD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 06:03:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44389 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:03:27 -0400
Received: from 79.184.253.121.ipv4.supernova.orange.pl (79.184.253.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 64e8419d88ddbbae; Wed, 10 Jul 2019 12:03:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
Date:   Wed, 10 Jul 2019 12:03:23 +0200
Message-ID: <5258816.hjoiAQk5RS@kreacher>
In-Reply-To: <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
References: <20190708162756.GA69120@gmail.com> <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 10, 2019 1:00:32 AM CEST Thomas Gleixner wrote:
> On Wed, 10 Jul 2019, Thomas Gleixner wrote:
> > On Tue, 9 Jul 2019, Linus Torvalds wrote:
> > > I also don't have any logs, because the boot never gets far enough. I
> > > assume that there was a problem bringing up a non-boot CPU, and the
> > > eventual hang ends up being due to that.
> > 
> > Hrm. I just build the tip of your tree and bootet it. It hangs at:
> > 
> > [    4.788678] ACPI: 4 ACPI AML tables successfully acquired and loaded
> > [    4.793860] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> > [    4.821476] ACPI: Dynamic OEM Table Load:
> > 
> > That's way after the secondary CPUs have been brought up. tip/master boots
> > without problems with the same config. Let me try x86/asm alone and also a
> > revert of the CR4/CR0 stuff.
> 
> x86/asm works alone
> 
> revert of cr4/0 pinning on top of your tree gets stuck as well
> 
> > And while writing this the softlockup detector muttered:
> 
> Have not yet fully bisected it, but Jiri did and he ended up with
> 
>   c522ad0637ca ("ACPICA: Update table load object initialization")
> 
> Reverting that on top of your tree makes it work again. Tony has the same
> issue.

I have a revert of this one queued up (with a plan to push it later today).

Cheers,
Rafael




