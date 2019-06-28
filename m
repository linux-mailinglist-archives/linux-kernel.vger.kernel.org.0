Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBA5A296
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF1RlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 13:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfF1Rkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:40:55 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60600214AF;
        Fri, 28 Jun 2019 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561743654;
        bh=47Hrj9p6N602R9iuCQ1SRRZ5DEtEd3CZsgul574d45g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JA0Cj4MVv1C74KESYIvJfZHMh7nkRH1HFQnxmJMFcX4e3zD7AQt4IWpMAHaFTr9Ql
         xuUdbNuyUF0w9OYsny5uYQD2MXuDDwWN6xgiL/+B/NuptV587vd8QeMEWZw5vkj5cN
         ZFdEqMY08/daBlbMDjrRyxwI0MKDc1L6A4zSpgpI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] tracing: Add 'hist:' to hist trigger error log error string
Date:   Fri, 28 Jun 2019 12:40:22 -0500
Message-Id: <449df721f560042e22382f67574bcc5b4d830d3d.1561743018.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1561743018.git.zanussi@kernel.org>
References: <cover.1561743018.git.zanussi@kernel.org>
In-Reply-To: <cover.1561743018.git.zanussi@kernel.org>
References: <cover.1561743018.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'hist:' prefix gets stripped from the command text during command
processing, but should be added back when displaying the command
during error processing.

Not only because it's what should be displayed but also because not
having it means the test cases fail because the caret is miscalculated
by the length of the prefix string.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d33c94a1cfa9..79768f22d5c5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -607,7 +607,8 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 	if (!str)
 		return;
 
-	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+	strcpy(last_cmd, "hist:");
+	strncat(last_cmd, str, MAX_FILTER_STR_VAL - 1 - sizeof("hist:"));
 
 	if (file) {
 		call = file->event_call;
-- 
2.14.1

