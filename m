Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3BABC62B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504545AbfIXLFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 07:05:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:52361 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504522AbfIXLFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:05:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 04:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="190989183"
Received: from pktinlab.iind.intel.com ([10.66.253.121])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2019 04:05:04 -0700
From:   Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To:     pankaj.bharadiya@gmail.com, andriy.shevchenko@linux.intel.com,
        kernel-hardening@lists.openwall.com, keescook@chromium.org,
        akpm@linux-foundation.org, mayhs11saini@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     pankaj.laxminarayan.bharadiya@intel.com
Subject: [PATCH 1/5] linux/kernel.h: Add sizeof_member macro
Date:   Tue, 24 Sep 2019 16:28:35 +0530
Message-Id: <20190924105839.110713-2-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190924105839.110713-1-pankaj.laxminarayan.bharadiya@intel.com>
References: <20190924105839.110713-1-pankaj.laxminarayan.bharadiya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present we have 3 different macros to calculate the size of a
member of a struct:
  - SIZEOF_FIELD
  - FIELD_SIZEOF
  - sizeof_field

To bring uniformity in entire kernel source tree let's add
sizeof_member macro.

Replace all occurrences of above 3 macro's with sizeof_member in
future patches.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 include/linux/kernel.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4fa360a13c1e..0b80d8bb3978 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -79,6 +79,15 @@
  */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
+/**
+ * sizeof_member - get the size of a struct's member
+ * @T: the target struct
+ * @m: the target struct's member
+ * Return: the size of @m in the struct definition without having a
+ * declared instance of @T.
+ */
+#define sizeof_member(T, m) (sizeof(((T *)0)->m))
+
 /**
  * FIELD_SIZEOF - get the size of a struct's field
  * @t: the target struct
-- 
2.17.1

