Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279FD18908A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 22:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCQVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 17:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbgCQVeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57A920754;
        Tue, 17 Mar 2020 21:34:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEJqp-000EUz-MS; Tue, 17 Mar 2020 17:34:15 -0400
Message-Id: <20200317213222.421100128@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:32:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [RFC][PATCH 00/11] ring-buffer/tracing: Remove disabling of ring buffer while reading trace file
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ring buffer was first written for ftrace, there was two
human readable files to read it. One was a standard "producer/consumer"
file (trace_pipe), which would consume data from the ring buffer as
it read it, and the other was a "static iterator" that would not
consume the events, such that the file could be read multiple times
and return the same output each time.

The "static iterator" was never meant to be read while there was an
active writer to the ring buffer. If writing was enabled, then it
would disable the writer when the trace file was opened.

There has been some complaints about this by the BPF folks, that did
not realize this little bit of information and it was requested that
the "trace" file does not stop the writing to the ring buffer.

This patch series attempts to satisfy that request, by creating a
temporary buffer in each of the per cpu iterators to place the
read event into, such that it can be passed to users without worrying
about a writer to corrupt the event while it was being written out.
It also uses the fact that the ring buffer is broken up into pages,
where each page has its own timestamp that gets updated when a
writer crosses over to it. By copying it to the temp buffer, and
doing a "before and after" test of the time stamp with memory barriers,
can allow the events to be saved.


Steven Rostedt (VMware) (11):
      tracing: Save off entry when peeking at next entry
      ring-buffer: Have ring_buffer_empty() not depend on tracing stopped
      ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()
      ring-buffer: Add page_stamp to iterator for synchronization
      ring-buffer: Have rb_iter_head_event() handle concurrent writer
      ring-buffer: Do not die if rb_iter_peek() fails more than thrice
      ring-buffer: Optimize rb_iter_head_event()
      ring-buffer: Do not disable recording when there is an iterator
      tracing: Do not disable tracing when reading the trace file
      ring-buffer/tracing: Have iterator acknowledge dropped events
      tracing: Have the document reflect that the trace file keeps tracing enabled

----
 Documentation/trace/ftrace.rst       |  13 +--
 include/linux/ring_buffer.h          |   4 +-
 include/linux/trace_events.h         |   2 +
 kernel/trace/ring_buffer.c           | 194 +++++++++++++++++++++++++----------
 kernel/trace/trace.c                 |  55 +++++++---
 kernel/trace/trace_functions_graph.c |   2 +-
 kernel/trace/trace_output.c          |  15 ++-
 7 files changed, 195 insertions(+), 90 deletions(-)
