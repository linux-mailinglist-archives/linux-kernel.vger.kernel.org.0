Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6510C006
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 23:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK0WKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 17:10:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:41392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726947AbfK0WKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:10:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 395CFB3DC;
        Wed, 27 Nov 2019 22:10:03 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Diana Craciun <diana.craciun@nxp.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        "Gustavo L. F. Walbon" <gwalbon@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Christopher M. Riedl" <cmr@informatik.wtf>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: add link stack flush mitigation status in debugfs.
Date:   Wed, 27 Nov 2019 23:09:59 +0100
Message-Id: <20191127220959.6208-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link stack flush status is not visible in debugfs. It can be enabled
even when count cache flush is disabled. Add separate file for its
status.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/security.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 7d4b2080a658..56dce4798a4d 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -446,14 +446,26 @@ static int count_cache_flush_get(void *data, u64 *val)
 	return 0;
 }
 
+static int link_stack_flush_get(void *data, u64 *val)
+{
+	*val = link_stack_flush_enabled;
+
+	return 0;
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_count_cache_flush, count_cache_flush_get,
 			 count_cache_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_link_stack_flush, link_stack_flush_get,
+			 count_cache_flush_set, "%llu\n");
 
 static __init int count_cache_flush_debugfs_init(void)
 {
 	debugfs_create_file_unsafe("count_cache_flush", 0600,
 				   powerpc_debugfs_root, NULL,
 				   &fops_count_cache_flush);
+	debugfs_create_file_unsafe("link_stack_flush", 0600,
+				   powerpc_debugfs_root, NULL,
+				   &fops_link_stack_flush);
 	return 0;
 }
 device_initcall(count_cache_flush_debugfs_init);
-- 
2.23.0

