Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A5D195ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 17:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgC0QOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 12:14:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33824 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgC0QOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:14:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jHrcE-0002xS-0M; Fri, 27 Mar 2020 16:13:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: qe: clean up an indentation issue
Date:   Fri, 27 Mar 2020 16:13:49 +0000
Message-Id: <20200327161349.284679-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that not indented correctly, remove the
extraneous space.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/fsl/qe/ucc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index d6c93970df4d..cac0fb7693a0 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -519,7 +519,7 @@ int ucc_set_tdm_rxtx_clk(u32 tdm_num, enum qe_clock clock,
 	int clock_bits;
 	u32 shift;
 	struct qe_mux __iomem *qe_mux_reg;
-	 __be32 __iomem *cmxs1cr;
+	__be32 __iomem *cmxs1cr;
 
 	qe_mux_reg = &qe_immr->qmx;
 
-- 
2.25.1

