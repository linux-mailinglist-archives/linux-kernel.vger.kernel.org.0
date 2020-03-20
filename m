Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83AA18C622
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 04:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCTDwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 23:52:10 -0400
Received: from gateway20.websitewelcome.com ([192.185.47.18]:16648 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbgCTDwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:52:10 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 99329400C3970
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 21:36:38 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id F8hcjXMfoVQh0F8hcjmJNk; Thu, 19 Mar 2020 22:52:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ToOek1kJGYOcHP+qxPbLVVm/EbHQvW2obG9/9yoCjw=; b=b3pdFZJLolQqckbfzlnn0BkFxk
        96Sr6PDqx5YmJ2YgfAIZ9ZQm0Lg6+XU1rRufs4/rvHNVTrKs3qHdpN/SbLTaXgecJWPX9dwtlcmpE
        GhlPs/uj3iy7967ztw0v/bCCIgWtOQRaZfmvS/KuGcdJ9rD+QUpSybYLJCtxbgzMXZ6I1Wb+Eols6
        hRPrkBEhTS+pqPQBvsCziiBUK4/04/jkbEtHDgRzIBwqhwH9CkOJ8lKpfFfuuaSYrfRtnvXQm8J9a
        z/P6x6HtkheEHPyJSVmFEveYLNLhxKIcCpWJJSbq50q8KiX0+D7OM6jQFoFK0xdE78OpcvHvGULzj
        c+fNuqaw==;
Received: from [191.31.203.148] (port=48890 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jF8hb-000OUT-Jy; Fri, 20 Mar 2020 00:52:08 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
Date:   Fri, 20 Mar 2020 00:51:02 -0300
Message-Id: <20200320035104.26139-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200320035104.26139-1-matheus@castello.eng.br>
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.203.148
X-Source-L: No
X-Exim-ID: 1jF8hb-000OUT-Jy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.203.148]:48890
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 12
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Caninos Loucos Program develops Single Board Computers with an open
structure. The Program wants to form a community of developers to use
IoT technologies and disseminate the learning of embedded systems in
Brazil.

It is an initiative of the Technological Integrated Systems Laboratory
(LSI-TEC) with the support of Polytechnic School of the University of
São Paulo (Poli-USP) and Jon "Maddog" Hall.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..16ee382dc6b2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -165,6 +165,8 @@ patternProperties:
     description: CALAO Systems SAS
   "^calxeda,.*":
     description: Calxeda
+  "^caninos,.*":
+    description: Caninos Loucos Program
   "^capella,.*":
     description: Capella Microsystems, Inc
   "^cascoda,.*":
--
2.25.0

