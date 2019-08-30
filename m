Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8CA39C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfH3PDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:03:11 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:39018 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfH3PDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:03:10 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id vT382000605gfCL01T38c0; Fri, 30 Aug 2019 17:03:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0003go-7O; Fri, 30 Aug 2019 17:03:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0005MS-6X; Fri, 30 Aug 2019 17:03:08 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5] dt-bindings: arm: idle-states: Add punctuation to improve readability
Date:   Fri, 30 Aug 2019 17:03:01 +0200
Message-Id: <20190830150302.20551-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830150302.20551-1-geert+renesas@glider.be>
References: <20190830150302.20551-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 4ef0de5c0c7f5990..eb9d725be7a93f4a 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -214,8 +214,8 @@ processor idle states, defined as device tree nodes, are listed.
 
 	Usage: Optional - On ARM systems, it is a container of processor idle
 			  states nodes. If the system does not provide CPU
-			  power management capabilities or the processor just
-			  supports idle_standby an idle-states node is not
+			  power management capabilities, or the processor just
+			  supports idle_standby, an idle-states node is not
 			  required.
 
 	Description: idle-states node is a container node, where its
@@ -342,8 +342,8 @@ follows:
 			    state.
 
 	In addition to the properties listed above, a state node may require
-	additional properties specifics to the entry-method defined in the
-	idle-states node, please refer to the entry-method bindings
+	additional properties specific to the entry-method defined in the
+	idle-states node. Please refer to the entry-method bindings
 	documentation for properties definitions.
 
 ===========================================
-- 
2.17.1

