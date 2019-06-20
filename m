Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE14DDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 01:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfFTXiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 19:38:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:62691 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfFTXiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:38:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 16:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="171047534"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2019 16:38:05 -0700
Date:   Thu, 20 Jun 2019 16:28:29 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 0/5] x86/umwait: Enable user wait instructions
Message-ID: <20190620232829.GB238683@romley-ivt3.sc.intel.com>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
 <CALCETrVcnccgOtxzEYqjES3qXKMVofmFfOdcY8y3s4knbw7eow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVcnccgOtxzEYqjES3qXKMVofmFfOdcY8y3s4knbw7eow@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 09:25:44AM -0700, Andy Lutomirski wrote:
> On Wed, Jun 19, 2019 at 6:43 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > The sysfs interface files are in /sys/devices/system/cpu/umwait_control/
> 
> This might be a silly question, but: what do we envision as the use
> case for changing the C0.2 setting?  I'm wondering if we'll ever end
> up wanting it as a prctl() instead of a sysfs file.

There may be some use cases, e.g. C0.2 state is enabled for saving more
power when the system has less workloads and is disabled for better
performance when the system is busy, or a real time system wants to disable
C0.2 for better response time, etc.

We thought about controling C0.2 per process before. But if doing so, the
umwait control MSR is per proces and needs to be saved/restored in
context switch. xsave/xrestore doesn't support the MSR. So the overhead
of saving/restoring the MSR could be high, especially the overhead
may hurt real time apps.

And there is no clear usage cases for changing C0.2 per process.

We hope the current patches to be available in upstream first for its
simplity and usage.

If we find usage of controling C0.2 per process, we can add code later
and/or may have xsave/xrestore support for the MSR to speed up context
switch.

The current C0.2 control won't block potential per process control if
the per process control is supported in the future.

Thanks.

-Fenghua
