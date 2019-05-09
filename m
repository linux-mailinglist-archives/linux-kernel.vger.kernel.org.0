Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989CE18A30
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEINBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 09:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEINBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:01:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13E4520989;
        Thu,  9 May 2019 13:01:00 +0000 (UTC)
Date:   Thu, 9 May 2019 09:00:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
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
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190509090058.6554dc81@gandalf.local.home>
In-Reply-To: <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
References: <20190318153840.906404905@infradead.org>
        <20190318155140.058627431@infradead.org>
        <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
        <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 10:26:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Mar 20, 2019 at 4:17 AM David Laight <David.Laight@aculab.com> wrote:
> >  
> > >               ______r = !!(cond);                                     \  
> >
> >         Is that (or maybe just the !!) needed any more??  
> 
> It is, because the 'cond' expression might not be an int, it could be
> a test for a pointer being non-NULL, or an u64 being non-zero, and not
> having the "!!" would mean that you'd get a warning or drop bits when
> assigning to 'int'.
> 
> And you do need the new temporary variable to avoid double evaluation
> the way that code is written.
> 
> That said, I do think the code is really ugly. We could:
> 
>  - avoid the temporary by just simplifying things.
> 
>  - do the '!!' just once in the parent macro.
> 
>  - Steven has this crazy model of "more underscores are better". They
> aren't. They don't help if things nest anyway, but what does help is
> meaningful names. Both when things don't nest, and when looking at
> generated asm files.
> 
>  - ,, and finally, what _is_ better is to chop things up so that they
> are smaller and make each macro do only one thing
> 
> So maybe do the patch something like the attached instead? Completely
> untested, but it looks sane to me.
> 

Linus,

This patch works. Can I get your Signed-off-by for it?

-- Steve
