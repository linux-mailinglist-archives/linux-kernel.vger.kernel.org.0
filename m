Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98647E0D62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfJVUk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 16:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJVUk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:40:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CCC21848;
        Tue, 22 Oct 2019 20:40:24 +0000 (UTC)
Date:   Tue, 22 Oct 2019 16:40:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191022164023.2102fb1a@gandalf.local.home>
In-Reply-To: <20191022202401.GO1817@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
        <20191018074634.801435443@infradead.org>
        <20191021222110.49044eb5@oasis.local.home>
        <20191022202401.GO1817@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 22:24:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> The below seems to cure it; and seems to generate identical
> events/*/format output (for my .config, with the exception of ID).
> 
> It has just one section mismatch report that I'm too tired to look at
> just now.

Thanks, I'll try to take a look at it tomorrow.

> 
> I'm not particularly proud of the "__function__" hack, but it works :/ I

If anything, that should be defined as a macro:

#define TRACE_EVENT_FIELD_SPECIAL "__trace_event_special__"

And use that to test?

> couldn't come up with anything else for [uk]probes which seem to have
> dynamic fields and if we're having it then syscall_enter can also make
> use of it, the syscall_metadata crud was going to be ugly otherwise.
> 
> (also, win on LOC)

I'm more worried about text/data bloat. But if anything, we may be able
to deal with that later.

-- Steve
