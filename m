Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4349980328
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 01:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437510AbfHBXUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 19:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437495AbfHBXUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966A0217D6;
        Fri,  2 Aug 2019 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788036;
        bh=DTtqR6dimKI2HoN5TUSVU4siXsFOcGGZxXJOm4LmKSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiNDddZzvKbeHuMCQGZAziBlty3jtqkmTvACDhLYBEkP8PWQawtKFBnvULRYH5ANI
         C04rPO+R3Iy/1nvUCqrK2Y1HH2/i+Juts8Ck3ymX8GfTd7kMKWALyfxMGBBudRQqDH
         hV7Wrvv7hi47e2RcRi1qM2znmeW5y9Mu/yXu9INI=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] crypto: ccp - Remove unnecessary linux/pci.h include
Date:   Fri,  2 Aug 2019 18:20:12 -0500
Message-Id: <20190802232013.15957-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190802232013.15957-1-helgaas@kernel.org>
References: <20190802232013.15957-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove unused includes of linux/pci.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/crypto/ccp/ccp-crypto.h | 1 -
 drivers/crypto/ccp/ccp-dev-v3.c | 1 -
 drivers/crypto/ccp/ccp-dev-v5.c | 1 -
 drivers/crypto/ccp/ccp-dev.h    | 1 -
 drivers/crypto/ccp/ccp-ops.c    | 1 -
 drivers/crypto/ccp/psp-dev.h    | 1 -
 drivers/crypto/ccp/sp-dev.h     | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto.h b/drivers/crypto/ccp/ccp-crypto.h
index 622b34c17643..903e74e7ad1b 100644
--- a/drivers/crypto/ccp/ccp-crypto.h
+++ b/drivers/crypto/ccp/ccp-crypto.h
@@ -12,7 +12,6 @@
 
 #include <linux/list.h>
 #include <linux/wait.h>
-#include <linux/pci.h>
 #include <linux/ccp.h>
 #include <crypto/algapi.h>
 #include <crypto/aes.h>
diff --git a/drivers/crypto/ccp/ccp-dev-v3.c b/drivers/crypto/ccp/ccp-dev-v3.c
index 2b7d47ed5c74..09924f2c264f 100644
--- a/drivers/crypto/ccp/ccp-dev-v3.c
+++ b/drivers/crypto/ccp/ccp-dev-v3.c
@@ -10,7 +10,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/pci.h>
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
 #include <linux/ccp.h>
diff --git a/drivers/crypto/ccp/ccp-dev-v5.c b/drivers/crypto/ccp/ccp-dev-v5.c
index 217e41bbadaf..0b6ef334f9b7 100644
--- a/drivers/crypto/ccp/ccp-dev-v5.c
+++ b/drivers/crypto/ccp/ccp-dev-v5.c
@@ -9,7 +9,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/pci.h>
 #include <linux/kthread.h>
 #include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/crypto/ccp/ccp-dev.h b/drivers/crypto/ccp/ccp-dev.h
index 89aee0900a06..57749c5a5373 100644
--- a/drivers/crypto/ccp/ccp-dev.h
+++ b/drivers/crypto/ccp/ccp-dev.h
@@ -12,7 +12,6 @@
 #define __CCP_DEV_H__
 
 #include <linux/device.h>
-#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index c69ed4bae2eb..b565c08bbe28 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -10,7 +10,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/des.h>
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index c5e06c92d40e..82a084f02990 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -11,7 +11,6 @@
 #define __PSP_DEV_H__
 
 #include <linux/device.h>
-#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 8abe9ea7e76f..53c12562d31e 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -13,7 +13,6 @@
 #define __SP_DEV_H__
 
 #include <linux/device.h>
-#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
-- 
2.22.0.770.g0f2c4a37fd-goog

