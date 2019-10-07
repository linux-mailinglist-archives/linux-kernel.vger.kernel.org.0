Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A02CDB53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 07:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfJGFYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 01:24:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41898 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJGFYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:24:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id q9so13526085wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 22:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xg+QfBCXfzEbEahIMN/FjbGzkhLOtal9LzLwBW93FJw=;
        b=Iion2YvWLpU/q5nDVqVb5iNOn7KdQ/s4pyBAF9rWw5vHusRa0h+GUvX3iQKYIX15qL
         7ZukTRgfLDfTEsgZj1V5dSNHCcG5E0bUtz5C23zNj5mYl1XIZQNhYulE0OM2K1CDyG1q
         ANj2jOdjGWfjYfvlJLsMm4Bt4ZYcnoo7lsPWuEzzd3blVd/ijOLHk3y/IpJxOjHOJ7Qv
         ANppPm1EMZKjD9IBGIa3Vc7uPQqtdUFJytcOKnUN45MR+rI3gGhkJKryfw07XdDAJ6Ys
         sNIiOr55KWuGdYpQ2QoQBVWf9IQrubBiLGYCAGrK0JqyMMyfHDFT2kaWZKXn81iqLJ1R
         Z0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xg+QfBCXfzEbEahIMN/FjbGzkhLOtal9LzLwBW93FJw=;
        b=TskoY+35QFwIElcyCaUos2yAxIK1y3xwM/lG523t/duXwOfTZu4wiG11sWoowH7MES
         861FoIR4INVOhrsqHnvYhFvc1xhhyLpI5erC/Id/F67ahsKYzMq5qm87WxZl3JDFHBTu
         MSKQ8g9w5tdV+XVFkXKwBcQKBEAPVLQDuXLtXQAzppplvn09NciteqvhLLu/ispcpG5f
         L4x9sIEj4FFE0nNXYoT51S3+yIXXA1U37tTLUjwerOUl3YHfijl/JdQHEO0Mr/dv8Sp1
         7haxB+gY4CW+34qSW4uRHiyY3sI0tKj8yWSgtJ+3dhgCvv+WNWnugsTEjLc3QmNDdCOv
         pvAw==
X-Gm-Message-State: APjAAAUVamA+qH2dqy/eIgKX8ZUx7/1uvaLdEWf8PJLyDh4CHDCBtfXi
        R6qxFrZpwMK5Rdw0mlkx6aApKcEu
X-Google-Smtp-Source: APXvYqztcPrY6UMHsP2lKj3STJyIPCr46O+RJaA9aAj1aMsHmHOAC66sIuMrLQWnXQfl1iNQFhLn8w==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr14290627wrt.188.1570425889025;
        Sun, 06 Oct 2019 22:24:49 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id t13sm37298074wra.70.2019.10.06.22.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Oct 2019 22:24:48 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L
Date:   Mon,  7 Oct 2019 09:23:59 +0400
Message-Id: <1570425839-4183-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIM3L appears to use a different ID:

[    0.086470] soc soc0: Amlogic Meson SM1 (S905X3) Revision 2b:c (b0:2) Detected

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 3c86d8d..87ed558 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -69,6 +69,7 @@ static const struct meson_gx_package_id {
 	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
 	{ "S905X3", 0x2b, 0x5, 0xf },
+	{ "S905X3", 0x2b, 0xb0, 0xf2 },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
 
-- 
2.7.4

