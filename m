Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA18E499D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503752AbfJYLOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:14:39 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:48630 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439807AbfJYLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:14:38 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9PBEF1w067244
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Oct 2019 19:14:15 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 25 Oct 2019 19:14:03
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 2/5] dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC specific
Date:   Fri, 25 Oct 2019 19:13:35 +0800
Message-ID: <20191025111338.27324-3-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9PBEF1w067244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Only SC9860 clocks were described in sprd.txt, rename it with a SoC
specific name, so that we can add more SoC support.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)

diff --git a/Documentation/devicetree/bindings/clock/sprd.txt b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
similarity index 98%
rename from Documentation/devicetree/bindings/clock/sprd.txt
rename to Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
index e9d179e882d9..aaaf02ca2a6a 100644
--- a/Documentation/devicetree/bindings/clock/sprd.txt
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
@@ -1,4 +1,4 @@
-Spreadtrum Clock Binding
+Spreadtrum SC9860 Clock Binding
 ------------------------
 
 Required properties:
-- 
2.20.1


