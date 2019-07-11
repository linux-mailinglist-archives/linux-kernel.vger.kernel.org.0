Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9721F6594A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfGKOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 10:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfGKOqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:46:09 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E1021670
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562856368;
        bh=bT+CeivQ2dZ4E3BHg1hYCdOR/wl4IDgjdDoFqaHXVuQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0dZxNekkqGmnPxCz7NaHxChodE20MRXNKms1FWnL7mw3zup4sTqGbHH6S0gwEVDcO
         SJPxZsRHOKaNZUCVL7Qb9d4p4HYNR7k4DohLTI6b0N/AHa4YHIhChjJhu0+gDm9cgQ
         tqtdkKchhSwxDOssUhsheyM12JKTfxEbZ/tWgf/A=
Received: by mail-wr1-f45.google.com with SMTP id f9so6568823wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:46:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWAQqIYvad79tnNk7b9tl4NO+X4bUezl7VCwY5mgdSkv7VxcBdn
        sYHCVGAZ8XN5FV9WpEV+Rr6OvCtAG4o+n9lHhc69iw==
X-Google-Smtp-Source: APXvYqxFwH1q9nlvNJ3LfaqqWu2hvLBynF9EViiMXpiDtTuX1GFKz437QOeChSCpX1q8ubjk0zfQVJpCtpFjEEXbXi0=
X-Received: by 2002:adf:a143:: with SMTP id r3mr5675173wrr.352.1562856366744;
 Thu, 11 Jul 2019 07:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190711114054.406765395@infradead.org> <20190711114336.174080643@infradead.org>
In-Reply-To: <20190711114336.174080643@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jul 2019 07:45:56 -0700
X-Gmail-Original-Message-ID: <CALCETrWYZHhP80PBxOcm5sc=p=StUbuwdvjDj-E3ma7wi3w-Pg@mail.gmail.com>
Message-ID: <CALCETrWYZHhP80PBxOcm5sc=p=StUbuwdvjDj-E3ma7wi3w-Pg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 4:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Since INT3/#BP no longer runs on an IST, this workaround is no longer
> required.
>
> Tested by running lockdep+ftrace as described in the initial commit:
>
>   5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")
>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I would definitely like to see this happen, but there are all kinds of
possibly nasties here.  Ideally we'd like get rid of IST for #DB, but
we can't due to the MOV SS mess.  There are a few relevant cases we
care about:

#DB from user mode -> anything that hits in C code: irrelevant --
we've exited the IST stack already.

#DB from user mode -> NMI/MCE in the asm -> #DB: The NMI code tries to
get this right.  The MCE code does not.

#DB from kernel mode -> NMI/MCE -> #DB: same as above.

MOV SS -> #DB from entry -> #DB again: ugh.  We get some protection
from shift_ist.

IMO we would ideally just clear DR7 in sensitive contexts.  Or extend
the debug_stack_set_zero(), etc hack.

All that being said, the actual _DEBUG macros shouldn't matter here, I
think.  But I'd like to sleep on it.   So not-yet-acked-by me.
