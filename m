Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562A0171F66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgB0Ofg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387481AbgB0OeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:00 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C747246AE;
        Thu, 27 Feb 2020 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814039;
        bh=LptIzUxwKjl42YG8Ni/qcMG8j5lOeHqwdiwER+neHwg=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gKXVK5tsLaynaC4LSDA0PTu+6Nv76v34XRXpd9lX5QC8t2/uKms0CXxCfIDaNjXDY
         faWucMNZSnVJ7nZ5nJHK6KAUSRLrQpgYR6fqT4G5E4YE3qmzUIPpZ0KJ0p2sEFkkEM
         tGp4XGCO2ql2KN6QEGQm954UDmR35SisehS5BXFI=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 04/23] x86: preempt: Check preemption level before looking at lazy-preempt
Date:   Thu, 27 Feb 2020 08:33:15 -0600
Message-Id: <ced8d6e46fd112cad04bdf4cc6ebf299dfc2d465.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 19fc8557f2323c52b26561651ed4d51fc688a740 ]

Before evaluating the lazy-preempt state it must be ensure that the
preempt-count is zero.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 arch/x86/include/asm/preempt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index f66708779274..afa0e42ccdd1 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -96,6 +96,8 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	if (____preempt_count_dec_and_test())
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if (preempt_count())
+		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
-- 
2.14.1

