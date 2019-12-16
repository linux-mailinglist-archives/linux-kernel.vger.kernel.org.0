Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621D5120429
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 12:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLPLlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 06:41:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38885 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfLPLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:41:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so3536632pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=InvFUNRiPxXOxYMHgJ0FZcGWdDLWenQO6uankp4X5co=;
        b=nADux0vgGYhjTFCUKXHhIWUyVNZN7zUWF+jzINL9cAlftMEI7yvP3uAhnf0qC5aqs9
         ZAC50zT4UcWrldyVj1tYig3kl4eBmyesPlq0/0emalFkMOEWGBxOGllFTnbHqL8a4sGZ
         VuaprGjVGzFE/A9973VW3r3MckU7sDNAUUlYUKQbrPZQA9pr7s5OZgWdz2rwMB+3bCrS
         Q4wop3/z6bfDNabuFmjdajkkZrQUfOfPbHf+h/P1JwyVnK1C8C0cokhWUoZG6SjaQFIL
         SxE5+9Ov/CHFb1E4kHykmD+MMl95f7Rxkue9x4IT+TYBCSjMV2d0LWGgEME3dCZfFA6w
         GfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=InvFUNRiPxXOxYMHgJ0FZcGWdDLWenQO6uankp4X5co=;
        b=BUSatIF6A3ucR9fxldEyhClhkrM0ZI8Bf80p/+qfyPh8qbt9BtTbqPUu8Q1b1yAak4
         1QKWOMH6EIPJxz1LReQ5bMdaV/UvCCGJU/t4uUFxgarP4YVCiqEx9Cobwsh/D3BCgE7V
         hrb8ie6YkYkmzjGjNlFLW5mR8AFtLK8UzTeZop4r2BKkNmJMn4ioZgU7as3EcwNMHhhe
         yQyC8Fqji+83l0TyumGbrT33UKUepU6Wgtm47TSuQnLcfv8zYQuYebbhqSCez2kkleeI
         lX5ACE3cfUTNtsvUQ7RtdLwslMFjB1EynKfJ2lkhNqhte8iUoT6dfJwG99MZkRb/ABya
         Eqgw==
X-Gm-Message-State: APjAAAXQx0uKlY2n4ZWC0idJd50uGY8h58ZEqsUKxYYDqd7nqWcXpVPb
        zMxEIiGYpnyWqMMxBMTXEMI=
X-Google-Smtp-Source: APXvYqzoCwWyOB7xgr9PWVX+nFjSqj0UEyCoBMAPL5V0qPlpHL1r/1iaM4C//Z29d+DrxlA1BYDugw==
X-Received: by 2002:a62:e215:: with SMTP id a21mr15100265pfi.208.1576496464398;
        Mon, 16 Dec 2019 03:41:04 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p124sm22432269pfb.52.2019.12.16.03.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2019 03:41:03 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v1 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Mon, 16 Dec 2019 19:40:14 +0800
Message-Id: <1576496419-12409-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576496419-12409-1-git-send-email-kevin3.tang@gmail.com>
References: <1576496419-12409-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/drm.yaml      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
new file mode 100644
index 0000000..1614ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc DRM master device
+
+maintainers:
+  - David Airlie <airlied@linux.ie>
+  - Daniel Vetter <daniel@ffwll.ch>
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+description: |
+  The Unisoc DRM master device is a virtual device needed to list all
+  DPU devices or other display interface nodes that comprise the
+  graphics subsystem.
+
+properties:
+  compatible:
+    const: sprd,display-subsystem
+
+  ports:
+    description:
+      Should contain a list of phandles pointing to display interface port
+      of DPU devices.
+
+required:
+  - compatible
+  - ports
+
+examples:
+  - |
+    display-subsystem {
+        compatible = "sprd,display-subsystem";
+        ports = <&dpu_out>;
+    };
\ No newline at end of file
-- 
2.7.4

