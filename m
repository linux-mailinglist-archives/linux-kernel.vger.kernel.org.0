Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB0188A79
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfHJKBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 06:01:04 -0400
Received: from unicom145.biz-email.net ([210.51.26.145]:1832 "EHLO
        unicom145.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 06:01:04 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Aug 2019 06:01:01 EDT
Received: from ([60.208.111.195])
        by unicom145.biz-email.net (Antispam) with ASMTP (SSL) id BRQ49939;
        Sat, 10 Aug 2019 17:58:39 +0800
Received: from localhost (10.100.1.52) by Jtjnmail201618.home.langchao.com
 (10.100.2.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 10 Aug
 2019 17:58:36 +0800
From:   John Wang <wangzqbj@inspur.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <duanzhijia01@inspur.com>, <linux@roeck-us.net>
Subject: [PATCH] dt-bindings: Add vendor prefix for Inspur Corporation
Date:   Sat, 10 Aug 2019 17:58:36 +0800
Message-ID: <20190810095836.6573-1-wangzqbj@inspur.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.1.52]
X-ClientProxiedBy: jtjnmail201604.home.langchao.com (10.100.2.4) To
 Jtjnmail201618.home.langchao.com (10.100.2.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: John Wang <wangzqbj@inspur.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 33a65a45e319..cc07237b8b89 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -401,6 +401,8 @@ patternProperties:
     description: Innolux Corporation
   "^inside-secure,.*":
     description: INSIDE Secure
+  "^inspur,.*":
+    description: Inspur Corporation
   "^intel,.*":
     description: Intel Corporation
   "^intercontrol,.*":
-- 
2.17.1

