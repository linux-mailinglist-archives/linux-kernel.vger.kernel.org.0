Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6B103CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfKTOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfKTOCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:02:08 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1932235D;
        Wed, 20 Nov 2019 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258527;
        bh=t1jxGZVRUT3++psVJjlPRe6/LZ+4yNKYPY14ryaanGc=;
        h=From:To:Cc:Subject:Date:From;
        b=DcZZdtzerNPQMVOy5kXJwHMeoiwmcosvynUMDsLtNGXOd3litogWi4exsJQHxMWCk
         EPq6VTrxY0/c7xtsM//+Q1xV3bA0jlMppQzTCixZoXytbSIKLbi/d9U9TBuJprQ3HS
         0QRqR2AraROZYPT1BxpnE8ykcDI20kfzTTLEebAQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] init: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 22:02:01 +0800
Message-Id: <20191120140201.19274-1-krzk@kernel.org>
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
 init/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index ff15a3c71176..4c06edc52f63 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -149,10 +149,10 @@ config BUILD_SALT
        string "Build ID Salt"
        default ""
        help
-          The build ID is used to link binaries and their debug info. Setting
-          this option will use the value in the calculation of the build id.
-          This is mostly useful for distributions which want to ensure the
-          build is unique between builds. It's safe to leave the default.
+	  The build ID is used to link binaries and their debug info. Setting
+	  this option will use the value in the calculation of the build id.
+	  This is mostly useful for distributions which want to ensure the
+	  build is unique between builds. It's safe to leave the default.
 
 config HAVE_KERNEL_GZIP
 	bool
@@ -1311,9 +1311,9 @@ menuconfig EXPERT
 	select DEBUG_KERNEL
 	help
 	  This option allows certain base kernel options and settings
-          to be disabled or tweaked. This is for specialized
-          environments which can tolerate a "non-standard" kernel.
-          Only use this if you really know what you are doing.
+	  to be disabled or tweaked. This is for specialized
+	  environments which can tolerate a "non-standard" kernel.
+	  Only use this if you really know what you are doing.
 
 config UID16
 	bool "Enable 16-bit UID system calls" if EXPERT
@@ -1423,11 +1423,11 @@ config BUG
 	bool "BUG() support" if EXPERT
 	default y
 	help
-          Disabling this option eliminates support for BUG and WARN, reducing
-          the size of your kernel image and potentially quietly ignoring
-          numerous fatal conditions. You should only consider disabling this
-          option for embedded systems with no facilities for reporting errors.
-          Just say Y.
+	  Disabling this option eliminates support for BUG and WARN, reducing
+	  the size of your kernel image and potentially quietly ignoring
+	  numerous fatal conditions. You should only consider disabling this
+	  option for embedded systems with no facilities for reporting errors.
+	  Just say Y.
 
 config ELF_CORE
 	depends on COREDUMP
@@ -1443,8 +1443,8 @@ config PCSPKR_PLATFORM
 	select I8253_LOCK
 	default y
 	help
-          This option allows to disable the internal PC-Speaker
-          support, saving some memory.
+	  This option allows to disable the internal PC-Speaker
+	  support, saving some memory.
 
 config BASE_FULL
 	default y
-- 
2.17.1

