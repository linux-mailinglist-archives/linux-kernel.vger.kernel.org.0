Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B22C199BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgCaQf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgCaQfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:35:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B472920CC7;
        Tue, 31 Mar 2020 16:35:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jJJr7-002VfA-Kz; Tue, 31 Mar 2020 12:35:13 -0400
Message-Id: <20200331163513.525283482@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 31 Mar 2020 12:34:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Tiejun Chen <tiejunc@vmware.com>
Subject: [PATCH RT 1/3] lib/ubsan: Remove flags parameter from calls to ubsan_prologue() and
 ubsan_epilogue()
References: <20200331163453.805082089@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.106-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Tiejun Chen <tiejunc@vmware.com>

Fails to build with CONFIG_UBSAN=y

lib/ubsan.c: In function '__ubsan_handle_vla_bound_not_positive':
lib/ubsan.c:348:2: error: too many arguments to function 'ubsan_prologue'
  ubsan_prologue(&data->location, &flags);
  ^~~~~~~~~~~~~~
lib/ubsan.c:146:13: note: declared here
 static void ubsan_prologue(struct source_location *location)
             ^~~~~~~~~~~~~~
lib/ubsan.c:353:2: error: too many arguments to function 'ubsan_epilogue'
  ubsan_epilogue(&flags);
  ^~~~~~~~~~~~~~
lib/ubsan.c:155:13: note: declared here
 static void ubsan_epilogue(void)
             ^~~~~~~~~~~~~~

Signed-off-by: Tiejun Chen <tiejunc@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/ubsan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 5830cc9a2164..199c75e03469 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -339,18 +339,17 @@ EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
 void __ubsan_handle_vla_bound_not_positive(struct vla_bound_data *data,
 					void *bound)
 {
-	unsigned long flags;
 	char bound_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(bound_str, sizeof(bound_str), data->type, bound);
 	pr_err("variable length array bound value %s <= 0\n", bound_str);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_vla_bound_not_positive);
 
-- 
2.25.1


