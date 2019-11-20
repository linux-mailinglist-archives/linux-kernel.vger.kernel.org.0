Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC178103C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfKTNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbfKTNnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:45 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC1C22529;
        Wed, 20 Nov 2019 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257424;
        bh=xeCJqurX4RkNcjf2QeoKUT0jsty4nV+TvM4lmNA6dsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mON5RSsTAW1ybEu5VPfT6UvYN5a2pBxmYe/mVEYQgKP0x1IokBg0uh8qwF0+nBtBI
         MGud1QK/F32uNnl6fEjbzxvKD0D2bhRjMFkZOS/tlutQsNONQ/54J5blh2x8AG+vBU
         BACD/+kuDFWIr1mV9cqv4rBy9umIpSLAZMRzELQA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH] 9p: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:40 +0800
Message-Id: <20191120134340.16770-1-krzk@kernel.org>
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
 fs/9p/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index ac2ec4543fe1..09fd4a185fd2 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -32,13 +32,13 @@ endif
 
 
 config 9P_FS_SECURITY
-        bool "9P Security Labels"
-        depends on 9P_FS
-        help
-          Security labels support alternative access control models
-          implemented by security modules like SELinux.  This option
-          enables an extended attribute handler for file security
-          labels in the 9P filesystem.
-
-          If you are not using a security module that requires using
-          extended attributes for file security labels, say N.
+	bool "9P Security Labels"
+	depends on 9P_FS
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the 9P filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
-- 
2.17.1

