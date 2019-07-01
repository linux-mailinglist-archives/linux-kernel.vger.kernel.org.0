Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A153ADCE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 06:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfFJECX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 00:02:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:49116 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfFJECX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:02:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 21:02:21 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2019 21:02:21 -0700
Date:   Sun, 9 Jun 2019 20:53:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
Message-ID: <20190610035302.GA162238@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 03:50:32PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > C0.2 state in umwait and tpause instructions can be enabled or disabled
> > on a processor through IA32_UMWAIT_CONTROL MSR register.
> >
> > By default, C0.2 is enabled and the user wait instructions result in
> > lower power consumption with slower wakeup time.
> >
> > But in real time systems which require faster wakeup time although power
> > savings could be smaller, the administrator needs to disable C0.2 and all
> > C0.2 requests from user applications revert to C0.1.
> >
> > A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
> > created to allow the administrator to control C0.2 state during run time.
> 
> This looks better than the previous version.  I think the locking is
> still rather confused.  You have a mutex that you hold while changing
> the value, which is entirely reasonable.  But, of the code paths that
> write the MSR, only one takes the mutex.
> 
> I think you should consider making a function that just does:
> 
> wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
> 
> and using it in all the places that update the MSR.  The only thing
> that should need the lock is the sysfs code to avoid accidentally
> corrupting the value, but that code should also use WRITE_ONCE to do
> its update.

Based on the comment, the illustrative CPU online and enable_c02 store
functions would be:

umwait_cpu_online()
{
        wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
        return 0;
}

enable_c02_store()
{
       mutex_lock(&umwait_lock);
       umwait_control_c02 = (u32)!c02_enabled;
       WRITE_ONCE(umwait_control_cached, 2 | get_umwait_control_max_time());
       on_each_cpu(umwait_control_msr_update, NULL, 1);
       mutex_unlock(&umwait_lock);
}

Then suppose umwait_control_cached = 100000 initially and only CPU0 is
running. Admin change bit 0 in MSR from 0 to 1 to disable C0.2 and is
onlining CPU1 in the same time:

1. On CPU1, read umwait_control_cached to eax as 100000 in
umwait_cpu_online()
2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
3. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()
4. On CPU0, wrmsr with 100001 in enabled_c02_store()

The result is CPU0 and CPU1 have different MSR values.

The problem is because there is no wrmsr serialization b/w uwait_cpu_online()
and enable_c02_store(). The WRITE_ONCE() and READ_ONCE() only serialize
access to umwait_control_cached. But we need to serialize wrmsr() as well to
guarantee all CPUs have the same MSR value.

So does it make sense to keep the mutex and locking as the current patch does?

Thanks.

-Fenghua
