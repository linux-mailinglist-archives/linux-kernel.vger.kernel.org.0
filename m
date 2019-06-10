Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4F3ADD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 06:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfFJEOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 00:14:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:52558 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfFJEOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:14:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 21:14:08 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2019 21:14:08 -0700
Date:   Sun, 9 Jun 2019 21:04:49 -0700
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
Message-ID: <20190610040449.GB162238@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrWi+uM5Rch6vaXOwHsHas928CDY5VJoBYaudD+3VFTrNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWi+uM5Rch6vaXOwHsHas928CDY5VJoBYaudD+3VFTrNw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 03:52:03PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > C0.2 state in umwait and tpause instructions can be enabled or disabled
> > on a processor through IA32_UMWAIT_CONTROL MSR register.
> >
> 
> > +static u32 get_umwait_control_c02(void)
> > +{
> > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02;
> > +}
> > +
> > +static u32 get_umwait_control_max_time(void)
> > +{
> > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> > +}
> > +
> 
> I'm not convinced that these helpers make the code any more readable.

The helpers reduce length of statements that call them. Otherwise, all of
the statements would be easily over 80 characters.

Plus, each of the helpers is called multiple places in #0003 and #0004.
So the helpers make the patches smaller and cleaner.

So is it still OK to keep the helpers?

Thanks.

-Fenghua
