Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87721925D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfEITGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 15:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfEITGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:06:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4153F20656;
        Thu,  9 May 2019 19:06:46 +0000 (UTC)
Date:   Thu, 9 May 2019 15:06:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
Message-ID: <20190509150644.13d4a046@gandalf.local.home>
In-Reply-To: <20190509184531.jhinxi2x2pdfaefb@treble>
References: <20190318153840.906404905@infradead.org>
        <20190318155140.058627431@infradead.org>
        <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
        <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
        <20190509090058.6554dc81@gandalf.local.home>
        <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
        <20190509142902.08a32f20@gandalf.local.home>
        <20190509184531.jhinxi2x2pdfaefb@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 13:45:31 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Actually, my original fix already went in:
> 
>   37686b1353cf ("tracing: Improve "if" macro code generation")
> 
> But it introduced a regression:
> 
>   https://lkml.kernel.org/r/201905040509.iqQ2CrOU%lkp@intel.com
> 
> which Linus' patch fixes for some reason.

Hmm, I'm still working on my pull request for the merge window, and if
this already went in, I could just add this, and let it conflict. I'm
sure Linus will have no problems in fixing up the conflicts.

I should change the subject, as it is the same ;-) Perhaps to:

 tracing: Clean up "if" macro

But it would be good to find out why this fixes the issue you see.
Perhaps its because we remove the internal if statement?

-- Steve
