Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6C56DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfFZPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 11:30:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40617 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfFZPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:30:42 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so2586559ioc.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=47jXrca/VLnvTViduml7tRENXk9Vm4pzuTXdi0htwSI=;
        b=bRTbbNqpz27JcaELNMaS595xLsjJ2iZR7o/Zi3u9KMHMtQCVyCGoImqgSCPUjZnc9C
         LHAyaKsDhOZozOCxG75IloZD/OcQLRRSnunyLEjKyoOruiTs9odjyzrjibUnGdWgulnY
         wmOklJwNOkJWgvgCrHLVXzCg+vi7rozAUUVwDlhCZifpHsmXNr2JPArX3OlCDK3xMBOo
         QOeW46uaidFx+SfkWH5IGUx5hmKzm0J374lMyziCP5hG6eRa3Mmfk+1cxgYto8fVsrgc
         OucAX9s5pcExmgrX3P772wZIZXfgdlodYfIucoQLOs0cvhKEFCn1Hr+SYNp1ymg1p+To
         esYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=47jXrca/VLnvTViduml7tRENXk9Vm4pzuTXdi0htwSI=;
        b=iD+QpbYl2duETo5jyEUzyHQzULVe0FsklJxelLak++cvQtBaLiG+tfR4x8Mb+2F2T8
         DxeaSgKomK7o16x74SoZ+cJ87uLeZg5DlK3hn5rxZZABBzF2MtNDaR6eEC9r5KPfIUds
         YQV+qNgLrfvF+VKE+ZDv40nLRw+WZphQk0ArAn8EGbV3IZVgBPiHsfITAGeC7NolOfZS
         VYyJIVyuz0FSXt7l44lQuH5EGv6uW3M+/mSZqQKsZAEc+vOnDtt1q1aRkcfo8oupyKWg
         Dto6lXINFzHL1gYyIKKWb+UG9ZmswASu5Vz/IGfMdC7ToBpJsFZf6GwGDSOEmU8Vwy22
         4iwg==
X-Gm-Message-State: APjAAAVXw8PXuyYAFdK1wiO6diFZNEZjVaJ3SYYoQu2f1gQRRor3EiqC
        1oniHFpg6YA/cUSSF6oy9xZdqw==
X-Google-Smtp-Source: APXvYqxxv99ftWybjb752ByTOs3EepgyGpjVVV0N/HtQbeNhEIL7ps//XlR9m9QlFx9cyXF2gB9B3Q==
X-Received: by 2002:a5d:9e48:: with SMTP id i8mr5666557ioi.51.1561563042093;
        Wed, 26 Jun 2019 08:30:42 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r139sm35785253iod.61.2019.06.26.08.30.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:30:41 -0700 (PDT)
Date:   Wed, 26 Jun 2019 08:30:40 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, robh@kernel.org
Subject: [PATCH] dt-bindings: riscv: resolve 'make dt_binding_check'
 warnings
Message-ID: <alpine.DEB.2.21.9999.1906260829030.21507@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob pointed out that one of the examples in the RISC-V 'cpus' YAML schema 
results in warnings from 'make dt_binding_check'.  Fix these.

While here, make the whitespace in the second example consistent with the 
first example.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 27f02ec4bb45..f97a4ecd7b91 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -152,17 +152,19 @@ examples:
   - |
     // Example 2: Spike ISA Simulator with 1 Hart
     cpus {
-            cpu@0 {
-                    device_type = "cpu";
-                    reg = <0>;
-                    compatible = "riscv";
-                    riscv,isa = "rv64imafdc";
-                    mmu-type = "riscv,sv48";
-                    interrupt-controller {
-                            #interrupt-cells = <1>;
-                            interrupt-controller;
-                            compatible = "riscv,cpu-intc";
-                    };
-            };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cpu@0 {
+                device_type = "cpu";
+                reg = <0>;
+                compatible = "riscv";
+                riscv,isa = "rv64imafdc";
+                mmu-type = "riscv,sv48";
+                interrupt-controller {
+                        #interrupt-cells = <1>;
+                        interrupt-controller;
+                        compatible = "riscv,cpu-intc";
+                };
+        };
     };
 ...
-- 
2.20.1

