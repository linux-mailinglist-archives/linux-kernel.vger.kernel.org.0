Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74150647C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfGJODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 10:03:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47829 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfGJODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:03:39 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlDBx-0003p9-Vo; Wed, 10 Jul 2019 16:03:30 +0200
Date:   Wed, 10 Jul 2019 16:03:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Jiri Kosina <jikos@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <20190710134433.GN3402@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907101555510.1758@nanos.tec.linutronix.de>
References: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com> <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
 <201907091727.91CC6C72D8@keescook> <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang> <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang> <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang> <20190710134433.GN3402@hirez.programming.kicks-ass.net>
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

On Wed, 10 Jul 2019, Peter Zijlstra wrote:

> On Wed, Jul 10, 2019 at 09:25:16PM +0800, Xi Ruoyao wrote:
> > On 2019-07-10 14:31 +0200, Jiri Kosina wrote:
> > > Adding Daniel to check whether this couldn't be some fallout of jumplabel 
> > > batching.
> > 
> > I don't think so.  I tried to revert Daniel's jumplabel batching commits and the
> > issue wasn't solved.  But reverting Kees' CR0 and CR4 commits can "fix" it
> > (apprently).
> 
> Xi, could you please try the below instead?
> 
> If we mark the key as RO after init, and then try and modify the key to
> link module usage sites, things might go bang as described.

Right. I finally was able to reproduce that with Linus' config (slightly
modified). Applying your patch makes it go away.

Now what puzzles me is that this never exploded in my face before and with
a debian config it JustWorks.

Both configs have:

 CONFIG_KVM=m
 CONFIG_KVM_INTEL=m

so I'd expect both to crash and burn when KVM_INTEL is loaded as that has a
cr4 operation inside.

So something papers over that ... Still looking.

Thanks,

	tglx


