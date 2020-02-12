Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6E159F85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 04:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBLD15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 22:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbgBLD15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:27:57 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E1B32082F;
        Wed, 12 Feb 2020 03:27:56 +0000 (UTC)
Date:   Tue, 11 Feb 2020 22:27:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
Message-ID: <20200211222754.0185b9b3@rorschach.local.home>
In-Reply-To: <20200212030403.GC13208@google.com>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
        <20200212011551.GA13208@google.com>
        <20200211214958.5d8f4004@rorschach.local.home>
        <20200212030403.GC13208@google.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 12:04:03 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> Oh, yes, ftrace printks a lot. But I sort of forgot why don't we do
> the same for "regular" NMIs. So NMIs use per-cpu buffers, expect for
> NMIs which involve ftrace dump. I'm missing something here.

Well, ftrace_dump() is called from NMI context when the system is about
to crash (ftrace_dump_on_oops). And at that moment, we care more about
the trace than other output (it's most like to contain the information
that caused the bug).

But for things like sysrq-l, that does a printk in NMI context for
normal operations, we don't want strange races to occur and affect
other printk operations. Having them in buffers controls the output a
bit better.

But with the new printk ring buffer work, perhaps that's no longer
necessary.

-- Steve
