Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018561585EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 00:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBJXG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 18:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBJXG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:06:58 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B252082F;
        Mon, 10 Feb 2020 23:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581376018;
        bh=UHgRzz6I37tz2Q+lWdRFPPj4iTd0HtTTsHKNvR/OA1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NbDwu5DJ+OhLbEsB0iEXzPiS2f1BRfRpaA9SiG1xLZE+uHdS8fT6GTyGZdJJNzY/x
         RXgAFTENUMsCd3Z+U95/BMslkXn5ZYvBCxtHvpeDTIlSHdqTf788adBeqhLED/RW4i
         tWj1jLyM5vyTNEVtp5wBfzZFvBSWnWLpM+UxHaDw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 1/3] tracing: Add missing nest end to synth_event_trace_start() error case
Date:   Mon, 10 Feb 2020 17:06:48 -0600
Message-Id: <20abc444b3eeff76425f895815380abe7aa53ff8.1581374549.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1581374549.git.zanussi@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
In-Reply-To: <cover.1581374549.git.zanussi@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ring_buffer reserve in synth_event_trace_start() fails, the
matching ring_buffer_nest_end() should be called in the error code,
since nothing else will ever call it in this case.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b3bcfd8c7332..a546ffa14785 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2043,6 +2043,7 @@ int synth_event_trace_start(struct trace_event_file *file,
 	entry = trace_event_buffer_reserve(&trace_state->fbuffer, file,
 					   sizeof(*entry) + fields_size);
 	if (!entry) {
+		ring_buffer_nest_end(trace_state->buffer);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.14.1

