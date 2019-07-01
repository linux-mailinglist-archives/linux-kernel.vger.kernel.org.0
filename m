Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A4919242
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 21:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfEISrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 14:47:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfEISrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60A00308FC5E;
        Thu,  9 May 2019 18:47:19 +0000 (UTC)
Received: from treble (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 272014A3;
        Thu,  9 May 2019 18:47:17 +0000 (UTC)
Date:   Thu, 9 May 2019 13:47:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190509184715.6y2uzlld4irlm3tw@treble>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
 <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
 <20190509090058.6554dc81@gandalf.local.home>
 <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
 <20190509142902.08a32f20@gandalf.local.home>
 <20190509184531.jhinxi2x2pdfaefb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509184531.jhinxi2x2pdfaefb@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 09 May 2019 18:47:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 01:45:31PM -0500, Josh Poimboeuf wrote:
> On Thu, May 09, 2019 at 02:29:02PM -0400, Steven Rostedt wrote:
> > On Thu, 9 May 2019 09:51:59 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > On Thu, May 9, 2019 at 6:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > This patch works. Can I get your Signed-off-by for it?  
> > > 
> > > Yes. Please write some kind of comprehensible commit log for it, but
> > 
> > How's this:
> > 
> > "Peter Zijlstra noticed that with CONFIG_PROFILE_ALL_BRANCHES, the "if"
> > macro converts the conditional to an array index.  This can cause GCC
> > to create horrible code.  When there are nested ifs, the generated code
> > uses register values to encode branching decisions.
> > 
> > Josh Poimboeuf found that replacing the define "if" macro from using
> > the condition as an array index and incrementing the branch statics
> > with an if statement itself, reduced the asm complexity and shrinks the
> > generated code quite a bit.
> > 
> > But this can be simplified even further by replacing the internal if
> > statement with a ternary operator.
> > 
> > Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Actually, my original fix already went in:
> 
>   37686b1353cf ("tracing: Improve "if" macro code generation")
> 
> But it introduced a regression:
> 
>   https://lkml.kernel.org/r/201905040509.iqQ2CrOU%lkp@intel.com
> 
> which Linus' patch fixes for some reason.

/me curses URL encoding

https://lkml.kernel.org/r/201905040509.iqQ2CrOU%25lkp@intel.com

-- 
Josh
