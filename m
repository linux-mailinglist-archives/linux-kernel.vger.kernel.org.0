Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B18AEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 07:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfHMFQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 01:16:11 -0400
Received: from scadrial.mjdsystems.ca ([198.100.154.185]:48477 "EHLO
        scadrial.mjdsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHMFQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:16:11 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 01:16:11 EDT
Received: from ring00.mjdsystems.ca (unknown [IPv6:2607:f2c0:ed80:136:810f:e1f:d6d5:2f63])
        by scadrial.mjdsystems.ca (Postfix) with ESMTPSA id C381B5ADCA7C;
        Tue, 13 Aug 2019 01:07:50 -0400 (EDT)
From:   Matthew Dawson <matthew@mjdsystems.ca>
To:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Matthew Dawson <matthew@mjdsystems.ca>
Subject: [PATCH] tools build: Fix clang detection with clang >= 8.0
Date:   Tue, 13 Aug 2019 01:07:31 -0400
Message-Id: <20190813050731.57131-1-matthew@mjdsystems.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=7.0 tests=BAYES_00,UNPARSEABLE_RELAY
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        scadrial.mjdsystems.ca
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8.0 release of clang/llvm moved the VirtualFileSystem.h header
to from clang to llvm.  This change causes a compile error, causing
perf to not detect clang/llvm.

Fix by including the right header for the different versions of llvm,
using the older header for llvm < 8, and the new header for llvm >= 8.

Signed-off-by: Matthew Dawson <matthew@mjdsystems.ca>
---
 tools/build/feature/test-clang.cpp | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/build/feature/test-clang.cpp b/tools/build/feature/test-clang.cpp
index a2b3f092d2f0..313ef1568880 100644
--- a/tools/build/feature/test-clang.cpp
+++ b/tools/build/feature/test-clang.cpp
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "clang/Basic/VirtualFileSystem.h"
 #include "clang/Driver/Driver.h"
 #include "clang/Frontend/TextDiagnosticPrinter.h"
 #include "llvm/ADT/IntrusiveRefCntPtr.h"
 #include "llvm/Support/ManagedStatic.h"
 #include "llvm/Support/raw_ostream.h"
+#if LLVM_VERSION_MAJOR >= 8
+#include "llvm/Support/VirtualFileSystem.h"
+#else
+#include "clang/Basic/VirtualFileSystem.h"
+#endif
 
 using namespace clang;
 using namespace clang::driver;
-- 
2.21.0

