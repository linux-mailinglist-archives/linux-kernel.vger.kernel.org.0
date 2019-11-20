Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67603103BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfKTNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfKTNi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:58 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB93224FA;
        Wed, 20 Nov 2019 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257137;
        bh=/9NJm8FBtb+c8mCuOKpMv1HbYFsrFzhxLk/5+F4za0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=het8AsdSOJYIoPR+Z1Dscdm1oyCu3expVdjZvTiAsvRhm/skPdqXWGM9V+QMfnzUy
         mQ1JJfbVUmwa1sfsE9Supw2Pc3DG6JyYN7vOtXJ/VtqNnmCBrPqKyytOaj9ILqwdPr
         CsnSMXPEbe7F1r2KI7qFQBlpUbmARWXj4gY5ghuw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: pi433: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:53 +0800
Message-Id: <20191120133853.13308-1-krzk@kernel.org>
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
 drivers/staging/pi433/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
index 8acde0814206..dd9e4709d1a8 100644
--- a/drivers/staging/pi433/Kconfig
+++ b/drivers/staging/pi433/Kconfig
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 config PI433
-        tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
-        depends on SPI
-        help
-          This option allows you to enable support for the radio module Pi433.
+	tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
+	depends on SPI
+	help
+	  This option allows you to enable support for the radio module Pi433.
 
-          Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
-          or compatible. It extends the Raspberry Pi with the option, to
-          send and receive data in the 433MHz ISM band - for example to
-          communicate between two systems without using ethernet or bluetooth
-          or for control or read sockets, actors, sensors, widely available
-          for low price.
+	  Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
+	  or compatible. It extends the Raspberry Pi with the option, to
+	  send and receive data in the 433MHz ISM band - for example to
+	  communicate between two systems without using ethernet or bluetooth
+	  or for control or read sockets, actors, sensors, widely available
+	  for low price.
 
-          For details or the option to buy, please visit https://pi433.de/en.html
+	  For details or the option to buy, please visit https://pi433.de/en.html
 
-          If in doubt, say N here, but saying yes most probably won't hurt
+	  If in doubt, say N here, but saying yes most probably won't hurt
-- 
2.17.1

