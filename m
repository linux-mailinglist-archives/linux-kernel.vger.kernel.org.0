Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9715015E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 06:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBCFZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 00:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgBCFZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 00:25:09 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB762080D;
        Mon,  3 Feb 2020 05:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580707509;
        bh=Aq0yEnBkPZ2i28u2kA+F5xCcoMjtJM3CWtJgcuQxAI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/928VeEyoFEYXbIWkImpCUwlhO4t9K/TmNAhMzMvbabz08lIhif7Mcwem0U1nMdG
         NGiEk/fp9CgAS1qX0ixhQeyezgyRvifoGuavCo1BHNQ2UCkoDQL0fueNTL4TKF4sDZ
         1C9RJzKs4knv6M41nQEXx6DbITIwgHdNvWIv83Kg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wen He <wen.he_1@nxp.com>
Subject: [PATCH 2/2] dt/bindings: clk: fsl,plldig: Drop 'bindings' from schema id
Date:   Sun,  2 Feb 2020 21:25:07 -0800
Message-Id: <20200203052507.93215-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203052507.93215-1-sboyd@kernel.org>
References: <20200203052507.93215-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having 'bindings' in here causes a warning when checking the schema.

 Documentation/devicetree/bindings/clock/fsl,plldig.yaml:
 $id: relative path/filename doesn't match actual path or filename
         expected: http://devicetree.org/schemas/clock/fsl,plldig.yaml#

Remove it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Wen He <wen.he_1@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/clock/fsl,plldig.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
index ad37d3273229..c8350030b374 100644
--- a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/bindings/clock/fsl,plldig.yaml#
+$id: http://devicetree.org/schemas/clock/fsl,plldig.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NXP QorIQ Layerscape LS1028A Display PIXEL Clock Binding
-- 
Sent by a computer, using git, on the internet

