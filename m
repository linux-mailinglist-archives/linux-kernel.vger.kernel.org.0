Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD37F7013
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 10:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKKJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 04:03:59 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:40291 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727078AbfKKJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:03:56 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xAB93EMn061091
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 11 Nov 2019 17:03:14 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.88) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 11 Nov 2019 17:03:32
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 4/5] dt-bindings: serial: Add a new compatible string for SC9863A
Date:   Mon, 11 Nov 2019 17:02:29 +0800
Message-ID: <20191111090230.3402-5-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.88]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xAB93EMn061091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


SC9863A use the same serial device which SC9836 uses.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index 0cc4668a9b9c..a6cce10c8b9d 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - sprd,sc9860-uart
+              - sprd,sc9863a-uart
           - const: sprd,sc9836-uart
       - const: sprd,sc9836-uart
 
-- 
2.20.1


