Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AC121C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 23:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfLPWQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 17:16:32 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:59210 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbfLPWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:16:32 -0500
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 340DD30C2DA;
        Mon, 16 Dec 2019 14:11:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 340DD30C2DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1576534303;
        bh=c/wouBtv91PTKkOxRyp61Efr8gRVBG7WS5ajBeXOp4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPq2VwE9QNLUYvrq04bC1r3z1+LhdAmvQ9qr6JmtLOVnStfxwVIfT0yT1z7AtmloZ
         NVOaZ5PZjJYmOUB1SChdGUbPSZ1hoSpL+7L6ZuY5zOc+MK8ltHOls4L2J6te1jGKh9
         MBge094ODcsDczzp7TPlnerp40Ys7rrgtZDtrWh0=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id CC569140069;
        Mon, 16 Dec 2019 14:16:29 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     lukasz.luba@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rostedt@goodmis.org, sudeep.holla@arm.com
Subject: [PATCH 1/2] include: trace: Add SCMI header with trace events
Date:   Mon, 16 Dec 2019 17:15:54 -0500
Message-Id: <20191216161650.21844-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216161650.21844-1-lukasz.luba@arm.com>
References: <20191216161650.21844-1-lukasz.luba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

+
+TRACE_EVENT(scmi_xfer_begin,
+	TP_PROTO(u8 id, u8 protocol_id, u16 seq, bool poll),
+	TP_ARGS(id, protocol_id, seq, poll),
+
+	TP_STRUCT__entry(
+		__field(u8, id)
+		__field(u8, protocol_id)
+		__field(u16, seq)
+		__field(bool, poll)
+	),
+
+	TP_fast_assign(
+		__entry->id = id;
+		__entry->protocol_id = protocol_id;
+		__entry->seq = seq;
+		__entry->poll = poll;
+	),
+
+	TP_printk("id=%u protocol_id=%u seq=%u poll=%u", __entry->id,
+		__entry->protocol_id, __entry->seq, __entry->poll)
+);
+
+TRACE_EVENT(scmi_xfer_end,
+	TP_PROTO(u8 id, u8 protocol_id, u16 seq, u32 status),
+	TP_ARGS(id, protocol_id, seq, status),
+
+	TP_STRUCT__entry(
+		__field(u8, id)
+		__field(u8, protocol_id)
+		__field(u16, seq)
+		__field(u32, status)
+	),
+
+	TP_fast_assign(
+		__entry->id = id;
+		__entry->protocol_id = protocol_id;
+		__entry->seq = seq;
+		__entry->status = status;
+	),
+
+	TP_printk("id=%u protocol_id=%u seq=%u status=%u", __entry->id,
+		__entry->protocol_id, __entry->seq, __entry->status)
+);

Hello,

When there are multiple messages in the mbox queue, I've found it
a chore matching up the 'begin' event with the 'end' event for each
SCMI msg.  The id (command) may not be unique, the proto_id may not be
unique, and the seq may not be unique.  The combination of the three
may not be unique.  Would it make sense to assign a monotonically
increasing ID to each msg so that one can easily match the two events
for each msg?  This id could be the result of an atomic increment and
could be stored in the xfer structure.  Of course, it would be one of
the values printed out in the events.

Also, would you consider a third event, right after the
scmi_fetch_response() invocation in scmi_rx_callback()?  I've found
this to be insightful in situations where we were debugging a timeout.

I'm fine if you elect not to do the above; I just wanted to post
this for your consideration.

Thanks,
Jim Quinlan
Broadcom
