Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4117ED0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 01:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCJAEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 20:04:41 -0400
Received: from smtpweb146.aruba.it ([62.149.158.146]:42866 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCJAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:04:41 -0400
Received: from ubuntu.localdomain ([146.241.70.103])
        by smtpcmd05.ad.aruba.it with bizsmtp
        id CPxW2200V2DhmGq01PxWb4; Tue, 10 Mar 2020 00:57:31 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clk: fix example for single-output provider
Date:   Tue, 10 Mar 2020 00:57:22 +0100
Message-Id: <20200309235722.26278-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1583798251; bh=t09PIkcfDqhH2smlQIxEEW+HTkXTi0Jg/uM+cRD92JQ=;
        h=From:To:Subject:Date:MIME-Version;
        b=lm+H5tfRdd64vO8PqQ/QkUPZb5KfLRQEoV+Oe3REcO+x6sz2j7441t+0B85lxwjuQ
         s1gbNdi+BXI4PuQOtGCSXaO4IeKqsdIiz2Y2+pwi6U9hB8x7AaXFpNRLJte+kAW3/C
         HtOLc+IPQmf5Ip41uFkplHSBix91p13yMFKMjW3a3rcuhzPsFFsCY/6GdeTPJYKImh
         ymY6v/JPpzgoFGJ5OyNsHI6cyt5bE4mNY1EgRvI3f/R7DI/c+uvpaQ6H5sX6ax9AUy
         LFHUHgjT22JVvRG0E/6SXlBwqHwUrKmjr3dPuXBadMxUIQ/uwDzHx6sREf0S5/iRwb
         XuxbJ0+1O6CvA==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described above single-output clock provider should have
0 cells number, so let's fix it by using 0 as cells number.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 Documentation/devicetree/bindings/clock/clock-bindings.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index b646bbcf7f92..8a55fdcf96ee 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -94,7 +94,7 @@ clock is connected to output 0 of the &ref.
     /* external oscillator */
     osc: oscillator {
         compatible = "fixed-clock";
-        #clock-cells = <1>;
+        #clock-cells = <0>;
         clock-frequency  = <32678>;
         clock-output-names = "osc";
     };
-- 
2.20.1

