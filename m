Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6ECB4B50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfIQJyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 05:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57801 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfIQJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC9DC308213F;
        Tue, 17 Sep 2019 09:54:52 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2A965D6A9;
        Tue, 17 Sep 2019 09:54:50 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amit Shah <amit@kernel.org>, linux-crypto@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] hw_random: don't wait on add_early_randomness()
Date:   Tue, 17 Sep 2019 11:54:50 +0200
Message-Id: <20190917095450.11625-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 17 Sep 2019 09:54:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add_early_randomness() is called by hwrng_register() when the
hardware is added. If this hardware and its module are present
at boot, and if there is no data available the boot hangs until
data are available and can't be interrupted.

To avoid that, call rng_get_data() in non-blocking mode (wait=0)
from add_early_randomness().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/char/hw_random/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 9044d31ab1a1..8d53b8ef545c 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -67,7 +67,7 @@ static void add_early_randomness(struct hwrng *rng)
 	size_t size = min_t(size_t, 16, rng_buffer_size());
 
 	mutex_lock(&reading_mutex);
-	bytes_read = rng_get_data(rng, rng_buffer, size, 1);
+	bytes_read = rng_get_data(rng, rng_buffer, size, 0);
 	mutex_unlock(&reading_mutex);
 	if (bytes_read > 0)
 		add_device_randomness(rng_buffer, bytes_read);
-- 
2.21.0

