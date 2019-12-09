Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6B1178E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 22:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfLIVyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 16:54:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:29289 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfLIVyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:54:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 13:54:23 -0800
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="224933851"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 13:54:22 -0800
From:   ira.weiny@intel.com
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] percpu_ref: Fix comment regarding percpu_ref_init flags
Date:   Mon,  9 Dec 2019 13:54:20 -0800
Message-Id: <20191209215420.19157-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The comment for percpu_ref_init() implies that using
PERCPU_REF_ALLOW_REINIT will cause the refcount to start at 0.  But
this is not true.  PERCPU_REF_ALLOW_REINIT starts the count at 1 as
if the flags were zero.  Add this fact to the kernel doc comment.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 lib/percpu-refcount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 4f6c6ebbbbde..48d7fcff70b6 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -50,9 +50,9 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
  * @flags: PERCPU_REF_INIT_* flags
  * @gfp: allocation mask to use
  *
- * Initializes @ref.  If @flags is zero, @ref starts in percpu mode with a
- * refcount of 1; analagous to atomic_long_set(ref, 1).  See the
- * definitions of PERCPU_REF_INIT_* flags for flag behaviors.
+ * Initializes @ref.  If @flags is zero or PERCPU_REF_ALLOW_REINIT, @ref starts
+ * in percpu mode with a refcount of 1; analagous to atomic_long_set(ref, 1).
+ * See the definitions of PERCPU_REF_INIT_* flags for flag behaviors.
  *
  * Note that @release must not sleep - it may potentially be called from RCU
  * callback context by percpu_ref_kill().
-- 
2.21.0

