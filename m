Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B71103BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfKTNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfKTNiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:03 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A6922529;
        Wed, 20 Nov 2019 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257082;
        bh=64GkfrnU5/CmFwfArTVS22nUh21+z4REs8qfwPVsKmY=;
        h=From:To:Cc:Subject:Date:From;
        b=Nt3g+6Pze6/31UAWEBSwLNzpCMrlanNFL4/Ks0M5irdkDEfxCQG1IenoZDKG7Ud8W
         ERs26ifbftvQj1HV8/GVLUrV7DfUxjfiDEmKZRMgdSpMWxQiW+PYiVL4m7TuafupzM
         AJrZCSCcjN2j1trEOl8I4c5ZlQQRCW6DeOYLDfH8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] mm: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:59 +0800
Message-Id: <20191120133759.12629-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 mm/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index e38ff1d5968d..27b7e61e3055 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -160,9 +160,9 @@ config MEMORY_HOTPLUG_SPARSE
 	depends on SPARSEMEM && MEMORY_HOTPLUG
 
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
-        bool "Online the newly added memory blocks by default"
-        depends on MEMORY_HOTPLUG
-        help
+	bool "Online the newly added memory blocks by default"
+	depends on MEMORY_HOTPLUG
+	help
 	  This option sets the default policy setting for memory hotplug
 	  onlining policy (/sys/devices/system/memory/auto_online_blocks) which
 	  determines what happens to newly added memory regions. Policy setting
@@ -227,14 +227,14 @@ config COMPACTION
 	select MIGRATION
 	depends on MMU
 	help
-          Compaction is the only memory management component to form
-          high order (larger physically contiguous) memory blocks
-          reliably. The page allocator relies on compaction heavily and
-          the lack of the feature can lead to unexpected OOM killer
-          invocations for high order memory requests. You shouldn't
-          disable this option unless there really is a strong reason for
-          it and then we would be really interested to hear about that at
-          linux-mm@kvack.org.
+	  Compaction is the only memory management component to form
+	  high order (larger physically contiguous) memory blocks
+	  reliably. The page allocator relies on compaction heavily and
+	  the lack of the feature can lead to unexpected OOM killer
+	  invocations for high order memory requests. You shouldn't
+	  disable this option unless there really is a strong reason for
+	  it and then we would be really interested to hear about that at
+	  linux-mm@kvack.org.
 
 #
 # support for page migration
@@ -302,10 +302,10 @@ config KSM
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
 config DEFAULT_MMAP_MIN_ADDR
-        int "Low address space to protect from user allocation"
+	int "Low address space to protect from user allocation"
 	depends on MMU
-        default 4096
-        help
+	default 4096
+	help
 	  This is the portion of low virtual memory which should be protected
 	  from userspace allocation.  Keeping a user from writing to low pages
 	  can help reduce the impact of kernel NULL pointer bugs.
-- 
2.17.1

