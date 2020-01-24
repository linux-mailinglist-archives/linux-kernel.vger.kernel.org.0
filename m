Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F99148B10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgAXPR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387435AbgAXPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15BC2087E;
        Fri, 24 Jan 2020 15:17:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i4-000qBm-Mu; Fri, 24 Jan 2020 10:17:24 -0500
Message-Id: <20200124151724.593184210@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:16:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 02/14] ring-buffer: Fix kernel doc for rb_update_event()
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

rb_update_event has changed without the kernel-doc update.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 46d67ff68795..3bab9b0a90b6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2331,11 +2331,11 @@ static inline bool rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
 
 /**
  * rb_update_event - update event type and data
+ * @cpu_buffer: The per cpu buffer of the @event
  * @event: the event to update
- * @type: the type of event
- * @length: the size of the event field in the ring buffer
+ * @info: The info to update the @event with (contains length and delta)
  *
- * Update the type and data fields of the event. The length
+ * Update the type and data fields of the @event. The length
  * is the actual size that is written to the ring buffer,
  * and with this, we can determine what to place into the
  * data field.
-- 
2.24.1


