Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C483148B47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbgAXPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:32:50 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:38110 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387724AbgAXPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:32:49 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id C71C4118E1; Fri, 24 Jan 2020 15:25:40 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports hub property
Date:   Fri, 24 Jan 2020 15:25:03 +0000
Message-Id: <20200124152504.23411-1-mans@mansr.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a non-removable-ports property that lists the hardwired downstream
ports of a hub.  Although hubs can provide this information, they are
not always configured correctly.  An alternate means of indicating this
for built-in USB devices is thus useful.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 036be172b1ae..92d863cc96b6 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -66,6 +66,10 @@ Required properties for host-controller nodes with device nodes:
 - #size-cells: shall be 0
 
 
+Optional properties for hub and host-controller nodes:
+- non-removable-ports: list of hardwired downstream ports
+
+
 Example:
 
 &usb1 {	/* host controller */
-- 
2.25.0

