Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31864C354
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfFSVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 17:52:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39166 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfFSVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:52:06 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so732758iod.6;
        Wed, 19 Jun 2019 14:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dd4ooG4oZ5quaRJjovQGgQXOJNXz7s0BukxLIFDFMFQ=;
        b=jnorcqLBTsAoVg1s+p6/2A49XYfA798KbAXUrWBie5FVEg/X61D0CasZQ8wNm3g4OZ
         MvkwBAjous1d+Iu7CNgDGkvltJML1wKLATw1rq7QkMWlXaIdroKbSM45P8xZD6gV6IkS
         4FBwsMHnZbrv1QoJ1ZZBksYrf5knq3eH7dLcvb5m9XyaMlEd+Wjlj6Pf5tedLUh+ZoGo
         7/8LkwE4Jh/aSMfC8ErRVD7hP7QILy5RRDoghv80ts70v0ZzjkQ4iwjPzqY2I8GWjG/S
         wv0erVJa46cGeH+DWGnkRuakk2KdeuzMQfToN4uoFhiIwiHk/Yz4yYJbqUPJ1I2Sujd/
         vrYQ==
X-Gm-Message-State: APjAAAXZiUZHYIf9kHEz/Wvjfksb3oNCvcSDbHw/a62gy+cSnoYom1Wm
        /CnNGROpkKzoFAy056wmrg==
X-Google-Smtp-Source: APXvYqwE+rBJQkU4kUQX0ZcDA2CS6gXiPS9jFB3GaDr51ImQSjFmxMcfECk9Z2iW7YLikj0LRhpASQ==
X-Received: by 2002:a5d:9957:: with SMTP id v23mr2607174ios.117.1560981124982;
        Wed, 19 Jun 2019 14:52:04 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id e84sm37754698iof.39.2019.06.19.14.52.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 14:52:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC PATCH 4/4] dt-bindings: display: Convert innolux,ee101ia-01 panel to DT schema
Date:   Wed, 19 Jun 2019 15:51:56 -0600
Message-Id: <20190619215156.27795-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619215156.27795-1-robh@kernel.org>
References: <20190619215156.27795-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the innolux,ee101ia-01 LVDS panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/innolux,ee101ia-01d.txt     |  7 -------
 .../display/panel/innolux,ee101ia-01d.yaml    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
deleted file mode 100644
index e5ca4ccd55ed..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
-
-Required properties:
-- compatible: should be "innolux,ee101ia-01d"
-
-This binding is compatible with the lvds-panel binding, which is specified
-in panel-lvds.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
new file mode 100644
index 000000000000..53d0e9c6169f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,ee101ia-01d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: panel-lvds.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: innolux,ee101ia-01d
+      - {} # panel-lvds, but not listed here to avoid false select
+
+...
-- 
2.20.1

