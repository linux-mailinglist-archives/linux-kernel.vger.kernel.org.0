Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3A77B80
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 21:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbfG0Tef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 15:34:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41983 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0Tef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:34:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so54483157wrm.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwPC0uC2vhnnQFt6dtjfct0lT1hDdrq7y6oBUVdLJKw=;
        b=QHT+vr7UctQsq5De/q5TWMQcuzSpL9ljxuV/hNLT+ItJwKXkM5g0LOvOUd02ezmEgN
         I9oEh9513WE73nzCZyW2keHtEuqZpwwDcSya5rATKTtZS58nE2Qe7BZLO6CzOpQGeoMO
         t63VYywAg5wGh+gDQPQixN/ocPo44KmMqJ7gyBLUeZIkhBUXCOAcfweN9A9U2uyNKkjt
         j2MGWuCFgqB2fu9j+oN2xm0rTzmMou7027hLuHn/CDTIiL777gOwV9l2CxAm78GnV6L4
         sW4AlzaBnvgMuiJoSEAkZxefKDwMqv1nMl1oJ8HGWMjelXlyk0MGOZOr2umlEIcQUbY5
         adrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwPC0uC2vhnnQFt6dtjfct0lT1hDdrq7y6oBUVdLJKw=;
        b=CfZ3VV2qKCHaEO4wiEXqXpC/RY0951HdsQPSNZzBvtcb62+BmkuKW+MeEhpCRmGRKU
         bkXjIY42CaIt/OMyLSv4upM95Vm38vT5NpLvwucZg18D/NDngghK302PGZSYLvkC7hO7
         TintopBs5QGjkiXNShKopDHKDiqEd8iwRzD+LtWzzK1h/zmKKHzLFwHBQSUGpOmHw/DF
         nduNFlzKr1sFVY21cgeqMdn6M0GXuum7XnNyTytHkne4VoOPgXTxt0h0/vxe2vK2LQdl
         c68lU+zxn3WU4OXhqLjfoHuxb3ui13OraRnpqCqIAAIdrvLFQwlYy7E2GWJ233cfx5Pi
         +pHw==
X-Gm-Message-State: APjAAAWl1jdOKZGSTBi+COIZOzmHzprb+FHAb+MDC/3kcojnAH3PCAva
        sJXWCqt6IgpgIjRI4lGg0rs=
X-Google-Smtp-Source: APXvYqwtcykN6reCHIDCRtC2TmW13zB5ZF0C7B4/4u2+Ho0Ih/KuuXH6Lj6HdkYgFIebULYKFdTG9Q==
X-Received: by 2002:a5d:668e:: with SMTP id l14mr52098236wru.156.1564256073191;
        Sat, 27 Jul 2019 12:34:33 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id n3sm50301258wrt.31.2019.07.27.12.34.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:34:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, srinivas.kandagatla@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] nvmem: meson-mx-efuse: allow reading data smaller than word_size
Date:   Sat, 27 Jul 2019 21:34:14 +0200
Message-Id: <20190727193414.11371-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Amlogic boards store the Ethernet MAC address inside the eFuse. The
Ethernet MAC address uses 6 bytes. The existing logic in
meson_mx_efuse_read() would write beyond the end of the data buffer when
trying to read data with a size that is not aligned to word_size (4
bytes on Meson8, Meson8b and Meson8m2).

Calculate the remaining data to copy inside meson_mx_efuse_read() so
reading 6 bytes doesn't write beyond the end of the data buffer.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- switch from min() to min_t() to get rid of a compiler warning


 drivers/nvmem/meson-mx-efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 2976aef87c82..e8fc0baa09e7 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -155,7 +155,8 @@ static int meson_mx_efuse_read(void *context, unsigned int offset,
 		if (err)
 			break;
 
-		memcpy(buf + i, &tmp, efuse->config.word_size);
+		memcpy(buf + i, &tmp,
+		       min_t(size_t, bytes - i, efuse->config.word_size));
 	}
 
 	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
-- 
2.22.0

