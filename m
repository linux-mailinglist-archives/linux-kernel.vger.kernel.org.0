Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76328491BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFQUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 16:55:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:16366 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFQUzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:55:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 13:55:50 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2019 13:55:49 -0700
Date:   Mon, 17 Jun 2019 13:46:19 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
Message-ID: <20190617204619.GC217081@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
 <CALCETrWtmrwqjThkMKU9YpTDK4o95V4HBb2_yQF2tvx5JZ9Ukw@mail.gmail.com>
 <20190610041343.GC162238@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906112242410.2214@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906112242410.2214@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:46:55PM +0200, Thomas Gleixner wrote:
> On Sun, 9 Jun 2019, Fenghua Yu wrote:
> 
> > On Sat, Jun 08, 2019 at 03:52:42PM -0700, Andy Lutomirski wrote:
> > > On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > >
> > > > umwait or tpause allows processor to enter a light-weight
> > > > power/performance optimized state (C0.1 state) or an improved
> > > > power/performance optimized state (C0.2 state) for a period
> > > > specified by the instruction or until the system time limit or until
> > > > a store to the monitored address range in umwait.
> > > >
> > > > IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> > > > on the processor and set maximum time the processor can reside in
> > > > C0.1 or C0.2.
> > > >
> > > > By default C0.2 is enabled so the user wait instructions can enter the
> > > > C0.2 state to save more power with slower wakeup time.
> > > 
> > > Sounds good, but:
> > > 
> > > > +#define MSR_IA32_UMWAIT_CONTROL_C02            BIT(0)
> > > 
> > > > +static u32 umwait_control_cached = 100000;
> > > 
> > > The code seems to disagree.
> > 
> > The definition of bit[0] is: C0.2 is disabled when bit[0]=1. So
> > 100000 means C0.2 is enabled (and max time is 100000).
> 
> which is totally non obvious. If you have to encode the control bit, then
> please make it explicit, i.e. mask out the disable bit in the initializer.

Is this right?

static u32 umwait_control_cached = 100000 & ~MSR_IA32_UMWAIT_CONTROL_C02_DISABLED;

Thanks.

-Fenghua

