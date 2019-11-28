Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE910C740
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 11:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfK1KzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 05:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1KzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:55:16 -0500
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBE521787;
        Thu, 28 Nov 2019 10:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574938515;
        bh=ad9+SWSKrOlB9g1376mkxAgY2Hz+I4lxYJjKgkKvaHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7iD1hT2nyhscrbQezzTnDcOSShOEczC76I/vKfILPqUZcpvqK0KeoO+xTSTHnm3S
         aYjkQG2DkMuwJldH3txVc7lkpFfTapZQdv+HNmHzLXjXQq7EqliTP98xm1q2aF/9CY
         FRP/g0WB8DvCrsrmnXKSBcNjegiQfgeBrLqFkKcY=
From:   kbingham@kernel.org
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Simon Goda <simon.goda@doulos.com>
Cc:     Kieran Bingham <kbingham@kernel.org>
Subject: [PATCH 1/3] dt-bindings: vendor: Add JHD LCD vendor
Date:   Thu, 28 Nov 2019 10:55:06 +0000
Message-Id: <20191128105508.3916-2-kbingham@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128105508.3916-1-kbingham@kernel.org>
References: <20191128105508.3916-1-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kbingham@kernel.org>

Jing Handa Electronics is an LCD manufacturer based in Shenzhen, China.
 http://www.jhdlcd.com.cn/Company.html

Signed-off-by: Kieran Bingham <kbingham@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 05b3904a995b..5c671263a1f0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -473,6 +473,8 @@ patternProperties:
     description: JEDEC Solid State Technology Association
   "^jesurun,.*":
     description: Shenzhen Jesurun Electronics Business Dept.
+  "^jhd,.*":
+    description: Jing Handa Electronics
   "^jianda,.*":
     description: Jiandangjing Technology Co., Ltd.
   "^karo,.*":
-- 
2.20.1

