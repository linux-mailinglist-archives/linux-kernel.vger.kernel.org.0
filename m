Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF1D33B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 23:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfJJVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 17:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:55:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA16D2067B;
        Thu, 10 Oct 2019 21:55:36 +0000 (UTC)
Date:   Thu, 10 Oct 2019 17:55:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] kprobes/x86: While list ftrace locations in kprobe
 blacklist areas
Message-ID: <20191010175535.0a69941b@gandalf.local.home>
In-Reply-To: <20191010175216.4ceb3cf1@gandalf.local.home>
References: <20191010175216.4ceb3cf1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 17:52:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I noticed some of my old tests failing on kprobes, and realized that
> this was due to black listing irq_entry functions on x86 from being
> used by kprobes. IIRC, this was due to the cr2 being corrupted and
> such, and I believe other things were to cause. But black listing all
> irq_entry code is a big hammer to this.
> 
>  (See commit 0eae81dc9f026 "x86/kprobes: Prohibit probing on IRQ
>  handlers directly" for more details)

BTW, I noticed this recently (again) when running my tests by hand. I
forgot that I have my automated tests revert the above commit before
compiling the kernel it is about to test (because it tests kprobes on
irq entry locations!). My tests never had issues with kprobes on irq
entry locations.

-- Steve
