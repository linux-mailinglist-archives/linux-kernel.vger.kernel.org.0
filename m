Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB8103BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfKTNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbfKTNjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:07 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D787C224FA;
        Wed, 20 Nov 2019 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257147;
        bh=LKrTG5QM06PoJ9vEP5IsU6tG9Iwb0ZyKAYiGtkhkmN4=;
        h=From:To:Cc:Subject:Date:From;
        b=i5U7vIAX4Duv4b2cw5XT3uOgn5ghUT4+BtMVqs4VqfMWIwT6M1tMsc5Dwe3QFk8ae
         8Oy8Zj/U5f8wEVMrycwwYFxHouHg0d3BeSyi1qmqm8fsdAdosFFWCjXUSayxYLyiTi
         +IRq2YbD/v0uggKwM3YBXlEuxdQvglNH8mfd4pyA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: most: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:03 +0800
Message-Id: <20191120133903.13428-1-krzk@kernel.org>
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
 drivers/staging/most/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/most/Kconfig b/drivers/staging/most/Kconfig
index 8948d5246409..6262eb25c80b 100644
--- a/drivers/staging/most/Kconfig
+++ b/drivers/staging/most/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig MOST
-        tristate "MOST support"
+	tristate "MOST support"
 	depends on HAS_DMA && CONFIGFS_FS
-        default n
-        help
+	default n
+	help
 	  Say Y here if you want to enable MOST support.
 	  This driver needs at least one additional component to enable the
 	  desired access from userspace (e.g. character devices) and one that
@@ -12,7 +12,7 @@ menuconfig MOST
 	  To compile this driver as a module, choose M here: the
 	  module will be called most_core.
 
-          If in doubt, say N here.
+	  If in doubt, say N here.
 
 
 
-- 
2.17.1

