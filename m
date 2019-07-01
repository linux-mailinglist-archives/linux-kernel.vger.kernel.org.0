Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF784297D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392064AbfFLOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 10:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392033AbfFLOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:38:02 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6E320679;
        Wed, 12 Jun 2019 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560350281;
        bh=NQXaya6bsyLXSApdfdao9a3unY0qvzopTwCuygXKB38=;
        h=From:To:Cc:Subject:Date:From;
        b=nRpmdb17758Zw1mAon9Em05a4kV7gXHUfGtUEsEN5Lxt/5ecuzSyGayh7YHjx0NeN
         tFP6+93ONLQqTO/2PPURFbGRnS1PlwzCn7Z93Qso8pkBWdl16O9KmS2l1qZq/Lre/5
         7/xGrJ8kdWZ4RNgp7Z1hIX0aESCo6BO6iKXRsKxU=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv5 1/2] dt-bindings: cadence-quadspi: add optional reset property
Date:   Wed, 12 Jun 2019 09:37:43 -0500
Message-Id: <20190612143744.30718-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QSPI module can have an optional reset signals that will hold the
module in a reset state.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v5: document reset-names
v4: no change
v3: created base on review comments
v2: did not exist
v1: did not exist
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index 4345c3a6f530..945be7d5b236 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -35,6 +35,9 @@ custom properties:
 		  (qspi_n_ss_out).
 - cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
                   and first bit transfer.
+- resets	: Must contain an entry for each entry in reset-names.
+		  See ../reset/reset.txt for details.
+- reset-names	: Must include either "qspi" and/or "qspi-ocp".
 
 Example:
 
@@ -50,6 +53,8 @@ Example:
 		cdns,fifo-depth = <128>;
 		cdns,fifo-width = <4>;
 		cdns,trigger-address = <0x00000000>;
+		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
+		reset-names = "qspi", "qspi-ocp";
 
 		flash0: n25q00@0 {
 			...
-- 
2.20.0

