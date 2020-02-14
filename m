Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5215E7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394319AbgBNQ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 11:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393951AbgBNQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:56:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741CB2067D;
        Fri, 14 Feb 2020 16:56:35 +0000 (UTC)
Date:   Fri, 14 Feb 2020 11:56:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH] xhci: Do not open code __print_symbolic() in xhci trace
 events
Message-ID: <20200214115634.30e8ebf2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

libtraceevent (used by perf and trace-cmd) failed to parse the
xhci_urb_dequeue trace event. This is because the user space trace
event format parsing is not a full C compiler. It can handle some basic
logic, but is not meant to be able to handle everything C can do.

In cases where a trace event field needs to be converted from a number
to a string, there's the __print_symbolic() macro that should be used:

 See samples/trace_events/trace-events-sample.h

Some xhci trace events open coded the __print_symbolic() causing the
user spaces tools to fail to parse it. This has to be replaced with
__print_symbolic() instead.

CC: stable@vger.kernel.org
Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206531
Fixes: 5abdc2e6e12ff ("usb: host: xhci: add urb_enqueue/dequeue/giveback tracers")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
index 56eb867803a6..b19582b2a72c 100644
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -289,23 +289,12 @@ DECLARE_EVENT_CLASS(xhci_log_urb,
 	),
 	TP_printk("ep%d%s-%s: urb %p pipe %u slot %d length %d/%d sgs %d/%d stream %d flags %08x",
 			__entry->epnum, __entry->dir_in ? "in" : "out",
-			({ char *s;
-			switch (__entry->type) {
-			case USB_ENDPOINT_XFER_INT:
-				s = "intr";
-				break;
-			case USB_ENDPOINT_XFER_CONTROL:
-				s = "control";
-				break;
-			case USB_ENDPOINT_XFER_BULK:
-				s = "bulk";
-				break;
-			case USB_ENDPOINT_XFER_ISOC:
-				s = "isoc";
-				break;
-			default:
-				s = "UNKNOWN";
-			} s; }), __entry->urb, __entry->pipe, __entry->slot_id,
+			__print_symbolic(__entry->type,
+				   { USB_ENDPOINT_XFER_INT,	"intr" },
+				   { USB_ENDPOINT_XFER_CONTROL,	"control" },
+				   { USB_ENDPOINT_XFER_BULK,	"bulk" },
+				   { USB_ENDPOINT_XFER_ISOC,	"isoc" }),
+			__entry->urb, __entry->pipe, __entry->slot_id,
 			__entry->actual, __entry->length, __entry->num_mapped_sgs,
 			__entry->num_sgs, __entry->stream, __entry->flags
 		)
