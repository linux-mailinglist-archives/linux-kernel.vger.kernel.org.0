Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E220764755
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfGJNot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 09:44:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfGJNos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5it4G6eaywghVnR4elg3H5x4iunu3dNhSVWHqmcRde4=; b=mHjBG21VKFos5ObtmXA/gZ5eL
        CY+VtlaF6Qv+nMoWEk8bkvUaA1+70L5QWplR8unDu+0jrcE8s2Ii3+acNiJOoRc/TmC33Uu/tMw4d
        ngGfiyZCH4Niuvf/ZFsc6QOQNu60C331dF9n6RsTWIUexqQd/hQ1HZjM/fX07wTJu0TSJihx/ll4T
        J2HeDBBDLOoLOXwD7/xapiDYDeasMhXa+z+vCPRmo317iHzxI6detG/a+uWz2o0CQdgfJdWFcABMY
        UMfBoR6ak4rw5eI1wJeV+PHNG2DcqSd8MgiH+MOU6puSJYB5gaxunAGJzHsHliiyzJFaHWMiCszsB
        ZQoXK4yqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlCtf-00022s-Ki; Wed, 10 Jul 2019 13:44:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 735F420976EE4; Wed, 10 Jul 2019 15:44:33 +0200 (CEST)
Date:   Wed, 10 Jul 2019 15:44:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20190710134433.GN3402@hirez.programming.kicks-ass.net>
References: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
 <201907091727.91CC6C72D8@keescook>
 <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
 <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 09:25:16PM +0800, Xi Ruoyao wrote:
> On 2019-07-10 14:31 +0200, Jiri Kosina wrote:
> > Adding Daniel to check whether this couldn't be some fallout of jumplabel 
> > batching.
> 
> I don't think so.  I tried to revert Daniel's jumplabel batching commits and the
> issue wasn't solved.  But reverting Kees' CR0 and CR4 commits can "fix" it
> (apprently).

Xi, could you please try the below instead?

If we mark the key as RO after init, and then try and modify the key to
link module usage sites, things might go bang as described.

Thanks!


diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 27d7864e7252..5bf7a8354da2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
-DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
+DEFINE_STATIC_KEY_FALSE(cr_pinning);
 EXPORT_SYMBOL(cr_pinning);
 unsigned long cr4_pinned_bits __ro_after_init;
 EXPORT_SYMBOL(cr4_pinned_bits);
