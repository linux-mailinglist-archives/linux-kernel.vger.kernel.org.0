Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD67C655
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfGaPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 11:23:07 -0400
Received: from foss.arm.com ([217.140.110.172]:48920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfGaPXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:23:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10E4E344;
        Wed, 31 Jul 2019 08:23:06 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A28A3F694;
        Wed, 31 Jul 2019 08:23:05 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm: kmemleak: Disable early logging in case of error
Date:   Wed, 31 Jul 2019 16:23:02 +0100
Message-Id: <20190731152302.42073-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs during kmemleak_init() (e.g. kmem cache cannot be
created), kmemleak is disabled but kmemleak_early_log remains enabled.
Subsequently, when the .init.text section is freed, the log_early()
function no longer exists. To avoid a page fault in such scenario,
ensure that kmemleak_disable() also disables early logging.

Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6e9e8cca663e..f6e602918dac 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1966,6 +1966,7 @@ static void kmemleak_disable(void)
 
 	/* stop any memory operation tracing */
 	kmemleak_enabled = 0;
+	kmemleak_early_log = 0;
 
 	/* check whether it is too early for a kernel thread */
 	if (kmemleak_initialized)
@@ -2009,7 +2010,6 @@ void __init kmemleak_init(void)
 
 #ifdef CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF
 	if (!kmemleak_skip_disable) {
-		kmemleak_early_log = 0;
 		kmemleak_disable();
 		return;
 	}
