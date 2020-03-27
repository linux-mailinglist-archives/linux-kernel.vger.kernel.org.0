Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72F1195307
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 09:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC0IfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 04:35:02 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:32782 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgC0IfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:35:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D8BBD408AF;
        Fri, 27 Mar 2020 08:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585298100; bh=5lvr85wmUB+ig2sjTf8GoiI7NOjmJtqmkcAiDXQQ+iE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=TZHuwz3H5eNA7EYxS892ep1aVCLanQL2wHYtC7TQ1GACbF04PWZcVKFGvVcwkiHP1
         CYLRWXaWk05eYI1h1R7VJvIzByK6EqIn9bFvU5GboH+n76NT5uw/zga/pX/YBLqaaR
         CDPlysiYElKGoT7ELcRtwexNbR8LB48sFJ9f1mMz2HSyfwtLhXyQj7E8cmDy6Kwyh+
         JWRh/qgvTfFtA2h1lc+7ueGfIOyDyo/qNcR48XZf/xN58RVCM+0jpyZNUr+V5wFa//
         OX/xFkj7QplQsUJZUHqqGWNPUpFuI53NEUp9tDSw/nBlm9poo2Md+EJOFsYbw5E8Ck
         rSx6MV7u9iPVQ==
Received: from tejas-VirtualBox (joglekar-e7480.internal.synopsys.com [10.146.16.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 3D1BAA005B;
        Fri, 27 Mar 2020 08:34:56 +0000 (UTC)
Received: by tejas-VirtualBox (sSMTP sendmail emulation); Fri, 27 Mar 2020 14:04:53 +0530
Date:   Fri, 27 Mar 2020 14:04:53 +0530
Message-Id: <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
In-Reply-To: <cover.1585297723.git.joglekar@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Subject: [RFC PATCH 1/4] dt-bindings: usb: Add snps,consolidate-sgl & consolidate-sgl
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     John Youn <John.Youn@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the documentation for consolidate-sgl, and
snps,consolidate-sgl property. These when set enables the quirk for
XHCI driver for consolidation of sg list into a temporary buffer when small
buffer sizes are scattered over the sg list not making up to MPS or total
transfer size within TRB cache size with Synopsys xHC.

Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt     | 3 +++
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9946ff9ba735..292d1f7969e4 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -104,6 +104,9 @@ Optional properties:
 			this and tx-thr-num-pkt-prd to a valid, non-zero value
 			1-16 (DWC_usb31 programming guide section 1.2.3) to
 			enable periodic ESS TX threshold.
+ - snps,consolidate-sgl: enable sg list consolidation - host mode only. Set to use
+			SG buffers of at least MPS size by consolidating smaller SG
+			buffers list into a single buffer.
 
  - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
  - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 3f378951d624..a90d853557ee 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -43,6 +43,9 @@ Optional properties:
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
   - imod-interval-ns: default interrupt moderation interval is 5000ns
   - phys : see usb-hcd.yaml in the current directory
+  - consolidate-sgl: indicate if you need to consolidate sg list into a
+    temporary buffer when small SG buffer sizes does not make upto MPS
+    size or total transfer size across the TRB cache size.
 
 additionally the properties from usb-hcd.yaml (in the current directory) are
 supported.
-- 
2.11.0

