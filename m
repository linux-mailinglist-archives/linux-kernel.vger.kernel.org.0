Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019B0A7A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 06:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfIDEnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 00:43:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6745 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfIDEng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f40fa0001>; Tue, 03 Sep 2019 21:43:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:36 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:35 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:34 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f40f30000>; Tue, 03 Sep 2019 21:43:34 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [PATCH V2 05/12] dt-binding: serial: tegra: add new chips
Date:   Wed, 4 Sep 2019 10:13:00 +0530
Message-ID: <1567572187-29820-6-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572218; bh=pZFlCtmCezHOCZ7GsPYweK+xdeMhEPX5x+24u2Ygfm0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oBZKKVVRL0eQX8Aqf7aSXa5+aq8ca7zs07jzV0aDCzCPM0ZBpOF9wqo59vdoWMFsU
         Ig5LfzV/PurRu1n9kzFMw+c17olEfsorugmI5JtVj9FC1j6cokXNoRdBPUy+GFElPl
         L5KAQH59XNSHNdJ/D7fHz8sGNhM38gLhvESQVY4hZKAmY9JzkKY8qE844I0eFOVjbm
         BnEvVjHpTUfATZLZglEjj9qIebdaZAhw1vOFkLE1nkaZ/bKHWnbl3Evpw8W/ZAB9cU
         v6kuiIZJTqzOlK8Tl7p+5w4Q4u0zLwqJUI1SI+H+WF+YHlQgzcoEODZ+dfIpg5ANGc
         WS8WDsNnujOFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for Tegra186. It differs from earlier chips
as it has FIFO mode enable check and 8 byte DMA buffer.
Add new compatible string for Tegra194. Tegra194 has different error
tolerance levels for baud rate compared to older chips.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index d7edf73..dab31d4 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -1,7 +1,12 @@
 NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
 
 Required properties:
-- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
+- compatible : should be,
+  "nvidia,tegra20-hsuart" for Tegra20,
+  "nvidia,tegra30-hsuart" for Tegra30,
+  "nvidia,tegra186-hsuart" for Tegra186,
+  "nvidia,tegra194-hsuart" for Tegra194.
+
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
 - clocks: Must contain one entry, for the module clock.
-- 
2.7.4

