Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975C9161F17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 03:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBRCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 21:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgBRClv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD652467A;
        Tue, 18 Feb 2020 02:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993711;
        bh=9s1PS3TUw7Zsqgs3UGzHhRFfsoLeo9wjHRqNuA7KWTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIwAJNQ5HNu9czhmM5+JIIXVf88Bwz+rEaOqO3+ovrz4lcdLhtE5nggYwMLQWpGo+
         h0v+nvbpEj9gYwiIeG6aZ/+agZ5G5pXaWzUHezJSVXQV136VyGhtBt7ISIZRBYrXOl
         cVRsJiDmz9VLW/XUYQGXV5OWWkc4KiR53crjOTZI=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 06/11] tools/kernel.h: add BUILD_BUG_ON_NOT_POWER_OF_2 macro
Date:   Mon, 17 Feb 2020 21:41:28 -0500
Message-Id: <20200218024133.5059-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now needed as a result of 12593b7467f9 ("locking/lockdep: Reduce
space occupied by stack traces").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index d2b3e1cc0218e..cc3d60623ca47 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -38,6 +38,12 @@
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
 
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)        \
+	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)                  \
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+
 #ifndef max
 #define max(x, y) ({				\
 	typeof(x) _max1 = (x);			\
-- 
2.20.1

