Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF886CBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbfGRJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:25:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfGRJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:25:30 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ho2fH-0006Nl-6B; Thu, 18 Jul 2019 09:25:27 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] staging: rtl8723bs: Disable procfs debugging by default
Date:   Thu, 18 Jul 2019 17:25:22 +0800
Message-Id: <20190718092522.17748-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The procfs provides many useful information for debugging, but it may be
too much for normal usage, routines like proc_get_sec_info() reports
various security related information.

So disable it by defaultl.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/staging/rtl8723bs/include/autoconf.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index 196aca3aed7b..8f4c1e734473 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -57,9 +57,5 @@
 #define DBG	0	/*  for ODM & BTCOEX debug */
 #endif /*  !DEBUG */
 
-#ifdef CONFIG_PROC_FS
-#define PROC_DEBUG
-#endif
-
 /* define DBG_XMIT_BUF */
 /* define DBG_XMIT_BUF_EXT */
-- 
2.17.1

