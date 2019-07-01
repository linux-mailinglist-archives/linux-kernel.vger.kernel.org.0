Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B175E49176
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfFQUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 16:36:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:4819 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFQUgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:36:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 13:36:34 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2019 13:36:33 -0700
Date:   Mon, 17 Jun 2019 13:27:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
Message-ID: <20190617202702.GB217081@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com>
 <20190610035302.GA162238@romley-ivt3.sc.intel.com>
 <CALCETrUSpk+_FDaPpA3a-duajUdF8kOK64AQJjsr7Pm0Gi04OA@mail.gmail.com>
 <20190610060234.GD162238@romley-ivt3.sc.intel.com>
 <F021B947-90E9-450A-9196-531B7EE965F1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F021B947-90E9-450A-9196-531B7EE965F1@amacapital.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:41:31AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Jun 9, 2019, at 11:02 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > 
> >> On Sun, Jun 09, 2019 at 09:24:18PM -0700, Andy Lutomirski wrote:
> >>> On Sun, Jun 9, 2019 at 9:02 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >>> 
> >>>> On Sat, Jun 08, 2019 at 03:50:32PM -0700, Andy Lutomirski wrote:
> >>>>> On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >>>>> 
> >>>>> C0.2 state in umwait and tpause instructions can be enabled or disabled
> >>>>> on a processor through IA32_UMWAIT_CONTROL MSR register.
> >>>>> 
> >>>>> By default, C0.2 is enabled and the user wait instructions result in
> >>>>> lower power consumption with slower wakeup time.
> >>>>> 
> >>>>> But in real time systems which require faster wakeup time although power
> >>>>> savings could be smaller, the administrator needs to disable C0.2 and all
> >>>>> C0.2 requests from user applications revert to C0.1.
> >>>>> 
> >>>>> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
> >>>>> created to allow the administrator to control C0.2 state during run time.
> >>>> 
> >>>> This looks better than the previous version.  I think the locking is
> >>>> still rather confused.  You have a mutex that you hold while changing
> >>>> the value, which is entirely reasonable.  But, of the code paths that
> >>>> write the MSR, only one takes the mutex.
> >>>> 
> >>>> I think you should consider making a function that just does:
> >>>> 
> >>>> wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
> >>>> 
> >>>> and using it in all the places that update the MSR.  The only thing
> >>>> that should need the lock is the sysfs code to avoid accidentally
> >>>> corrupting the value, but that code should also use WRITE_ONCE to do
> >>>> its update.
> >>> 
> >>> Based on the comment, the illustrative CPU online and enable_c02 store
> >>> functions would be:
> >>> 
> >>> umwait_cpu_online()
> >>> {
> >>>        wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
> >>>        return 0;
> >>> }
> >>> 
> >>> enable_c02_store()
> >>> {
> >>>       mutex_lock(&umwait_lock);
> >>>       umwait_control_c02 = (u32)!c02_enabled;
> >>>       WRITE_ONCE(umwait_control_cached, 2 | get_umwait_control_max_time());
> >>>       on_each_cpu(umwait_control_msr_update, NULL, 1);
> >>>       mutex_unlock(&umwait_lock);
> >>> }
> >>> 
> >>> Then suppose umwait_control_cached = 100000 initially and only CPU0 is
> >>> running. Admin change bit 0 in MSR from 0 to 1 to disable C0.2 and is
> >>> onlining CPU1 in the same time:
> >>> 
> >>> 1. On CPU1, read umwait_control_cached to eax as 100000 in
> >>> umwait_cpu_online()
> >>> 2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
> >>> 3. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()
> >>> 4. On CPU0, wrmsr with 100001 in enabled_c02_store()
> >>> 
> >>> The result is CPU0 and CPU1 have different MSR values.
> >> 
> >> Yes, but only transiently, because you didn't finish your example.
> >> 
> >> Step 5: enable_c02_store() does on_each_cpu(), and CPU 1 gets updated.
> > 
> > There is no sync on wrmsr on CPU0 and CPU1.
> 
> What do you mean by sync?
> 
> > So a better sequence to
> > describe the problem is changing the order of wrmsr:
> > 
> > 1. On CPU1, read umwait_control_cached to eax as 100000 in
> > umwait_cpu_online()
> > 2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
> > 3. On CPU0, wrmsr with 100001 in on_each_cpu() in enabled_c02_store()
> > 4. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()
> > 
> > So CPU1 and CPU0 have different MSR values. This won't be transient.
> 
> You are still ignoring the wrmsr on CPU1 due to on_each_cpu().
> 

Initially umwait_control_cached is 100000 and CPU0 is online while CPU1
is going to be online:

1. On CPU1, cpu_online_mask=0x3 in start_secondary()
2. On CPU1, read umwait_control_cached to eax as 100000 in umwait_cpu_online()
3. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
4. On CPU0, execute one_each_cpu() in enabled_c02_store():
    wrmsr with 100001 on CPU0
    wrmsr with 100001 on CPU1
5. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()

So the MSR is 100000 on CPU1 and 100001 on CPU0. The MSRs are different on
the CPUs.

Is this a right sequence to demonstrate locking issue without the mutex
locking?

Thanks.

-Fenghua

