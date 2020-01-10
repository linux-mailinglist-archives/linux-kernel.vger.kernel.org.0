Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E75136A73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 11:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgAJKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 05:04:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44924 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgAJKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:04:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ipr9X-00086a-HO; Fri, 10 Jan 2020 10:04:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] devices.txt: fix spelling mistake: "shapshot" -> "snapshot"
Date:   Fri, 10 Jan 2020 10:04:27 +0000
Message-Id: <20200110100427.236530-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix spelling mistake in text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 Documentation/admin-guide/devices.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 1c5d2281efc9..2a97aaec8b12 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -319,7 +319,7 @@
 		182 = /dev/perfctr	Performance-monitoring counters
 		183 = /dev/hwrng	Generic random number generator
 		184 = /dev/cpu/microcode CPU microcode update interface
-		186 = /dev/atomicps	Atomic shapshot of process state data
+		186 = /dev/atomicps	Atomic snapshot of process state data
 		187 = /dev/irnet	IrNET device
 		188 = /dev/smbusbios	SMBus BIOS
 		189 = /dev/ussp_ctl	User space serial port control
-- 
2.24.0

