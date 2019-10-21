Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE15DE628
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfJUIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 04:20:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46046 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:20:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id v8so8736702lfa.12;
        Mon, 21 Oct 2019 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5JzKSpnIK5rSjQFv+xBtJ5cRm0LAw3wIvKLByt2f/kI=;
        b=QQro1XbO4awUyGIP6YDCeU8B9aDmE+UCgs8wgUZGMLtLgWPlpnGinM3IZSDAJXr3dU
         zxe+ra5fgBuMtDANQxH1Lmseq/7SOfznON+l98+vY0c38crblBvxev6mhiuafZh/xl7T
         PCJ4wUfTmUxlsOK93GxcjnHmYb8F7UBvIaV96VbxCF+geUBb7WWLZaJpuSQlKROXixcv
         vxijcFL9A+Igg91lW1acupgTRVcQOjURXc8FAr2cxyRkRbWvD4pHcDBW84OXBvOCmcyK
         ABgILBH9qlbGAwZr9tYAJqV+oRsystOutOKABizo5+MQ1J9k8y8Nuf9Hh+iDsWyaWcLb
         VzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5JzKSpnIK5rSjQFv+xBtJ5cRm0LAw3wIvKLByt2f/kI=;
        b=hRcX4nWUftaR9dPwqok6FCn+AUfIL+EqbAci3nvpPtp8NOXkHtB78bz5Vpm1dHAOU/
         o6piOa3wfHcEsX5S3GOvKDFpaY3x50O0AFBAnV7hXSivs16x7wzpQdkzviMFmR9DTTlS
         V+N16mSLZOJi06NyeVA9G96MoSM76FZPfVMbSzgziPTiZ6E9m2LvCcy8FdYPAFb2HN/t
         iCdzK2L/joszQXHlBjfjDWRp5YeBR+/utbivqmSQF0uqfTsmYV53kcbIl8ZL4heyeUk4
         GWW4AjA5eFNwuD8z30xMwye5HxD+GaxXesDUfLwBSSQWldVvrmDFuRypcxaJrfIwWYZN
         xOnA==
X-Gm-Message-State: APjAAAVsSUc1x85XYN2rpx2bKuJ8U1KnjUt4I1dnbrPdq+eNaXncXiDF
        fSl8Us9z1V0QBkfv2R2chK4=
X-Google-Smtp-Source: APXvYqy4KwjOgJwK4T+IIgoUkEcxcswQs8VRoMux4nTdEMlg8h921V+P9V5ED2tELeaDOb47y/wq/g==
X-Received: by 2002:ac2:4566:: with SMTP id k6mr13856386lfm.132.1571646055615;
        Mon, 21 Oct 2019 01:20:55 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id m17sm16494781lje.0.2019.10.21.01.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 01:20:54 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] soc: amlogic: meson-gx-socinfo: Fix S905D3 ID for VIM3L
Date:   Mon, 21 Oct 2019 12:20:04 +0400
Message-Id: <1571646004-21269-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chip on the board is S905D3 not S905X3:

[    0.098998] soc soc0: Amlogic Meson SM1 (S905D3) Revision 2b:c (b0:2) Detected

Change from v1: use 0xf0 mask instead of 0xf2 as advised by Neil Armstrong.

Fixes: 1d7c541b8a5b ("soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 87ed558..01fc0d2 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -69,7 +69,7 @@ static const struct meson_gx_package_id {
 	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
 	{ "S905X3", 0x2b, 0x5, 0xf },
-	{ "S905X3", 0x2b, 0xb0, 0xf2 },
+	{ "S905D3", 0x2b, 0xb0, 0xf0 },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
 
-- 
2.7.4

