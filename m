Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A173158071
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 18:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBJRF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 12:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbgBJRFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:05:55 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F364120838;
        Mon, 10 Feb 2020 17:05:53 +0000 (UTC)
Date:   Mon, 10 Feb 2020 12:05:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210120552.1a06a7aa@gandalf.local.home>
In-Reply-To: <20200210094616.GC14879@hirez.programming.kicks-ass.net>
References: <20200207205656.61938-1-joel@joelfernandes.org>
        <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
        <20200210094616.GC14879@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 10:46:16 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Furthermore, using srcu would be detrimental, because of how it has
> smp_mb() in the read side primitives.

I didn't realize that there was a full memory barrier in the srcu read
side. Seems to me that itself is rational for reverting it. And also a
big NAK for any suggestion to have any of the function tracing to use
it as well (which comes up here and there).

-- Steve
