Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA61914AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgCXPhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbgCXPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:33 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E9220789;
        Tue, 24 Mar 2020 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064252;
        bh=s8x98rN3JIFXforeIZi6fVqHqm3rsPtMjmu01QfsNfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBzUO2WGI5lj7iwjFs8aSh+KQqoMKFYHe90bplIwTE4gioxy+X25SSJLiJoCNjbka
         JDsmyp6svbZTccZH2vARyX1NXmdry8evOEje8IzAtXp1X7NQ2rh/Huu9fvSkxKBSGu
         YhnooLqeg6ja2dhQBNpJp/ipNv7JCu9VGBjLhF5M=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: [RFC PATCH 17/21] linux/bit_spinlock.h: Include linux/processor.h
Date:   Tue, 24 Mar 2020 15:36:39 +0000
Message-Id: <20200324153643.15527-18-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for cpu_relax().

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/bit_spinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..505daa942527 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/processor.h>
 
 /*
  *  bit-based spin_lock()
-- 
2.20.1

