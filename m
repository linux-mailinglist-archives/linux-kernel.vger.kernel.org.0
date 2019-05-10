Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0150319AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfEJJ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 05:58:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39019 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfEJJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:58:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hP2IT-00007p-5S; Fri, 10 May 2019 09:58:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] reset: remove redundant null check on pointer dev
Date:   Fri, 10 May 2019 10:58:32 +0100
Message-Id: <20190510095832.28233-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer dev is being dereferenced when passed to the inlined
functon dev_name, however, dev is later being null checked
so at first this seems like a potential null pointer dereference.

In fact, _reset_control_get_from_lookup is only ever called from
__reset_control_get, right after checking dev->of_node hence
dev can never be null.  Clean this up by removing the redundant
null check.

Thanks to Philipp Zabel for spotting that dev can never be null.

Addresses-Coverity: ("Dereference before null check")
Fixes: 6691dffab0ab ("reset: add support for non-DT systems")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: remove null check point, it is redundant.

---
 drivers/reset/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 81ea77cba123..921f4bbbad8a 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -694,9 +694,6 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 	const char *dev_id = dev_name(dev);
 	struct reset_control *rstc = NULL;
 
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
 	mutex_lock(&reset_lookup_mutex);
 
 	list_for_each_entry(lookup, &reset_lookup_list, list) {
-- 
2.20.1

