Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2979D10AC30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0ItY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 03:49:24 -0500
Received: from foss.arm.com ([217.140.110.172]:44544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0ItW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:49:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF03328;
        Wed, 27 Nov 2019 00:49:20 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A99453F52E;
        Wed, 27 Nov 2019 00:49:19 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] crypto: ccree: remove useless define
Date:   Wed, 27 Nov 2019 10:49:05 +0200
Message-Id: <20191127084909.14472-2-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127084909.14472-1-gilad@benyossef.com>
References: <20191127084909.14472-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The define of CC_DEV_SHA_MAX is not needed since we moved
to runtime detection of capabilities. Remove it.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.h | 1 -
 drivers/crypto/ccree/cc_hash.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index ab31d4a68c80..7b6b5d6f1b33 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -28,7 +28,6 @@
 
 /* Registers definitions from shared/hw/ree_include */
 #include "cc_host_regs.h"
-#define CC_DEV_SHA_MAX 512
 #include "cc_crypto_ctx.h"
 #include "cc_hw_queue_defs.h"
 #include "cc_sram_mgr.h"
diff --git a/drivers/crypto/ccree/cc_hash.c b/drivers/crypto/ccree/cc_hash.c
index bc71bdf44a9f..aee5db5f8538 100644
--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -2358,11 +2358,9 @@ cc_digest_len_addr(void *drvdata, u32 mode)
 	case DRV_HASH_SHA256:
 	case DRV_HASH_MD5:
 		return digest_len_addr;
-#if (CC_DEV_SHA_MAX > 256)
 	case DRV_HASH_SHA384:
 	case DRV_HASH_SHA512:
 		return  digest_len_addr + sizeof(cc_digest_len_init);
-#endif
 	default:
 		return digest_len_addr; /*to avoid kernel crash*/
 	}
-- 
2.23.0

