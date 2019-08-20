Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA895951
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfHTIUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 04:20:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35651 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfHTIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:19:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id t50so2379473edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfuXWDGKyoQ+utA9DObLdBzgNQ7PmRM7y9+Md6RChRo=;
        b=IpD4KcUWdJJzGYciCrUh7Bv8uXRwVIsqc9WDxDjSY8vgC4bD1MqnLoFtEJ3WKlW7x2
         rkEWO8mJXsbLYBcZ+swGGgyCtnXjR2zgHpDjOKk71pTR3TdV0ToLIe4lyHCOZjpEPdUf
         mEs4X/epqWonM/u4BgTxkPW+QH5Xg2F1UbKI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfuXWDGKyoQ+utA9DObLdBzgNQ7PmRM7y9+Md6RChRo=;
        b=MxTDgREtrRCTKc6ihXI36Q92JW/4J+ELzBqOhw4CrpAxbvv5FEoPUKHshIgr1mWdWd
         XyZHYDrKTOoI/LIYih5NJshj8ru+wHvs8WD3uEKiqZT3gWgLPaLeVcSoUJkcRMjp9lSK
         /43Gl1Rtp8PbGhYQCiXzXL8nPgDwjM3S1DFgTtDQE6Wq/ajqFgVMIyYe3EiYuFVaRscU
         V/63Jd3sRUblVecrzsuAEYj3zg8VSsGAq6pli9ePcqacxF7F4sipWerVgatVxQ0bVcOJ
         e29d1s/NQDMFxWPwmT2qGde7sELlpV27cpReZdkNH7xFu+W4YoLZ7c5grKmRxnc00bvs
         +sVg==
X-Gm-Message-State: APjAAAUpMXz6Yh7GNl4viqU9kqeY131wc9CBkgRpqGO7CXUNIgGx+CWz
        gIg5SEH5IWmztZAc0y1TmmXb0A==
X-Google-Smtp-Source: APXvYqwslvZPG/vQIrSy/z3Y4BVivFQjmK/hYGPsHbZyAilMU+rn5KrbwxywGPMgCi4TSq7L+XqPhA==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr30023854edr.292.1566289197967;
        Tue, 20 Aug 2019 01:19:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i4sm2467705ejs.39.2019.08.20.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:19:57 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 2/3] lockdep: add might_lock_nested()
Date:   Tue, 20 Aug 2019 10:19:50 +0200
Message-Id: <20190820081951.25053-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
References: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Necessary to annotate functions where we might acquire a
mutex_lock_nested() or similar. Needed by i915.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/lockdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 38ea6178df7d..30f6172d6889 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -631,6 +631,13 @@ do {									\
 	lock_acquire(&(lock)->dep_map, 0, 0, 1, 1, NULL, _THIS_IP_);	\
 	lock_release(&(lock)->dep_map, 0, _THIS_IP_);			\
 } while (0)
+# define might_lock_nested(lock, subclass) 				\
+do {									\
+	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
+	lock_acquire(&(lock)->dep_map, subclass, 0, 1, 1, NULL,		\
+		     _THIS_IP_);					\
+	lock_release(&(lock)->dep_map, 0, _THIS_IP_);		\
+} while (0)
 
 #define lockdep_assert_irqs_enabled()	do {				\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
@@ -653,6 +660,7 @@ do {									\
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
+# define might_lock_nested(lock, subclass) do { } while (0)
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
-- 
2.23.0.rc1

