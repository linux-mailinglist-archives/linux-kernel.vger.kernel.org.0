Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE270871
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfGVSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:24:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39837 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbfGVSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:24:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so13781220pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBLXt7ZWn2zmK8NpfvRDIxgW5YjFwc7a7QBC18Huh3I=;
        b=o3PfoVz3oWkK4qVEUumRXievJXYCstqaeP6vKrYQCY831VTi14wUfmaRo1eZRNCEUq
         FF3stt5QZCdqpWxNPce5/NSSi03E6NuPQKHvM/tlN4DYM8qe9u+iAMH4Jn2bE48xyAcQ
         HS06tQNYND4GUiKoAep/hEWABn8n5plJdNxreq8Xp46wxy6eUuRmnZaVrLamandVZMoI
         /8zLp12U1gDYkIykR+Rw5q/eTmtPQU+3CMXVBuLX7uinuI8CtzVHVjphbC2+VoeV4USd
         +e+5LREqmBuyZ0y9NUpc/Mcuw4H7LpjYtCU4kYX05gPg0JAej/hrpdy02deN7Z0dorTR
         L8JQ==
X-Gm-Message-State: APjAAAVFCR+JNWIdHdbM/D0jK7Agm2yGHM4eFhcrpH2XQIt/WUjkp91g
        Abh1gCJzpEFtuQ2E9a8yMSM=
X-Google-Smtp-Source: APXvYqyMbaQhZ0Lau8xistcidhkONqyIgCdb0H6vFUly/kD1fjXeKvImcaPFG2ij+Xqhlk4/HsMfWA==
X-Received: by 2002:aa7:9481:: with SMTP id z1mr1558598pfk.92.1563819892977;
        Mon, 22 Jul 2019 11:24:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p23sm44556008pfn.10.2019.07.22.11.24.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:24:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/4] stacktrace: Constify 'entries' arguments
Date:   Mon, 22 Jul 2019 11:24:41 -0700
Message-Id: <20190722182443.216015-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722182443.216015-1-bvanassche@acm.org>
References: <20190722182443.216015-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear to humans and to the compiler that the stack trace
('entries') arguments are not modified.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/stacktrace.h | 4 ++--
 kernel/stacktrace.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index f0cfd12cb45e..83bd8cb475d7 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -9,9 +9,9 @@ struct task_struct;
 struct pt_regs;
 
 #ifdef CONFIG_STACKTRACE
-void stack_trace_print(unsigned long *trace, unsigned int nr_entries,
+void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
 		       int spaces);
-int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
+int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 			unsigned int nr_entries, int spaces);
 unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 			      unsigned int skipnr);
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index f5440abb7532..6d1f68b7e528 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -20,7 +20,7 @@
  * @nr_entries:	Number of entries in the storage array
  * @spaces:	Number of leading spaces to print
  */
-void stack_trace_print(unsigned long *entries, unsigned int nr_entries,
+void stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
 		       int spaces)
 {
 	unsigned int i;
@@ -43,7 +43,7 @@ EXPORT_SYMBOL_GPL(stack_trace_print);
  *
  * Return: Number of bytes printed.
  */
-int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
+int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 			unsigned int nr_entries, int spaces)
 {
 	unsigned int generated, i, total = 0;
-- 
2.22.0.657.g960e92d24f-goog

