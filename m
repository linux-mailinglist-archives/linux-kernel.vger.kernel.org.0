Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A63FE7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 23:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKOWeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 17:34:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43964 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfKOWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id a18so5616516plm.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pnStBG/T13CIghpMMY37iVdEqu6Tf6ypUdEca+Im12A=;
        b=UcNOeX7QeFUdS+8BsU3HT6dUr5DPakiIHn/4UvPOHLFYqY/K6ujtP4IZer6qWH4PsL
         kSBTMAw/WQgyxTxeo4ivek0tX/PV86dgJw0UkYo6ERIwQlFRePO6NKrAtfa6NCJ20W2O
         TsLzkBAGM6YB4DuaLNvOwjU3GdT2dzYF5IIKeZ0U3QUbT9dSuHzqJDl+QXBysh5SV+Ov
         lw25nX/7WiyUcJ5Xp4DrwnC0HKLo02gWkWh9DR0hT+OxTsQXWX6d6dxK8t070uRMMt9V
         r9oATtIcUAuwarcVv9V2aewPHt7avcTKRzk1AKnwfy3HSFUqXiDShEdVFb9swtzK8Huo
         4nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pnStBG/T13CIghpMMY37iVdEqu6Tf6ypUdEca+Im12A=;
        b=S0USZpYOt+njxTIcdLLhWzXZta10kaap4bn3+9R6I6ay9MBNkI9EDCXqACsJ/aVM21
         DJGyFZogpvjBEuR+Emrsjn5QsIyTTRQFL2eu57b4SUg01gErJLC6CjL24AkjCkm5DZoR
         HqI6VrlzmxopzypbQhkB1qbofKdP+6AzDcIYQ8Rs7xZqFSaTz5BPXD2GeaWTBsR6toXu
         1/iWSUaX5Lhb6UJkYHBAIfOOgtnuIbkcNqk0fUTvFvTgDv/auDo/oPhuBFGz4+azAA5H
         4Tq4Px5sf48TwcHQdNfd4nHUoc1r2EOKLAHNsU9+6n2GfukkLks6tBUICyGRHgXxrzgi
         qT+A==
X-Gm-Message-State: APjAAAV8bz3r+uhXSgQwcVJDj8t5gHzT20wIpcssvb7WEwgyPEdSEGxh
        FnqMl3oCb5laAXei6IL9Sx+UCw==
X-Google-Smtp-Source: APXvYqyUkVVN6TQZYe84qUdIeuFg+UeaXSpsS5sSY6gzAeOIOOHIRLFnS9NzrP3wYAkm6hhStgbJiw==
X-Received: by 2002:a17:902:fe8f:: with SMTP id x15mr17473187plm.343.1573857240779;
        Fri, 15 Nov 2019 14:34:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:00 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 04/20] crypto: stm31/hash - Fix hmac issue more than 256 bytes
Date:   Fri, 15 Nov 2019 15:33:40 -0700
Message-Id: <20191115223356.27675-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Debieve <lionel.debieve@st.com>

commit 0acabecebc912b3ba06289e4ef40476acc499a37 upstream

Correct condition for the second hmac loop. Key must be only
set in the first loop. Initial condition was wrong,
HMAC_KEY flag was not properly checked.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/crypto/stm32/stm32-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 590d7352837e..641b11077f47 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -365,7 +365,7 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 		return -ETIMEDOUT;
 
 	if ((hdev->flags & HASH_FLAGS_HMAC) &&
-	    (hdev->flags & ~HASH_FLAGS_HMAC_KEY)) {
+	    (!(hdev->flags & HASH_FLAGS_HMAC_KEY))) {
 		hdev->flags |= HASH_FLAGS_HMAC_KEY;
 		stm32_hash_write_key(hdev);
 		if (stm32_hash_wait_busy(hdev))
-- 
2.17.1

