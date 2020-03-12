Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14E183C73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 23:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCLW2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 18:28:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38562 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgCLW2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:28:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B4CDA1A11AF;
        Thu, 12 Mar 2020 23:28:40 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 76B601A11CD;
        Thu, 12 Mar 2020 23:28:40 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id C9D9740A63;
        Thu, 12 Mar 2020 15:28:39 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 3/6] soc: fsl: qe: fix sparse warnings for ucc.c
Date:   Thu, 12 Mar 2020 17:28:24 -0500
Message-Id: <20200312222827.17409-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20200312222827.17409-1-leoyang.li@nxp.com>
References: <20200312222827.17409-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

drivers/soc/fsl/qe/ucc.c:637:20: warning: incorrect type in assignment (different address spaces)
drivers/soc/fsl/qe/ucc.c:637:20:    expected struct qe_mux *qe_mux_reg
drivers/soc/fsl/qe/ucc.c:637:20:    got struct qe_mux [noderef] <asn:2> *
drivers/soc/fsl/qe/ucc.c:652:9: warning: incorrect type in argument 1 (different address spaces)
drivers/soc/fsl/qe/ucc.c:652:9:    expected void const volatile [noderef] <asn:2> *addr
drivers/soc/fsl/qe/ucc.c:652:9:    got restricted __be32 *
drivers/soc/fsl/qe/ucc.c:652:9: warning: incorrect type in argument 2 (different address spaces)
drivers/soc/fsl/qe/ucc.c:652:9:    expected void volatile [noderef] <asn:2> *addr
drivers/soc/fsl/qe/ucc.c:652:9:    got restricted __be32 *

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/qe/ucc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index 90157acc5ba6..d6c93970df4d 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -632,7 +632,7 @@ int ucc_set_tdm_rxtx_sync(u32 tdm_num, enum qe_clock clock,
 {
 	int source;
 	u32 shift;
-	struct qe_mux *qe_mux_reg;
+	struct qe_mux __iomem *qe_mux_reg;
 
 	qe_mux_reg = &qe_immr->qmx;
 
-- 
2.17.1

