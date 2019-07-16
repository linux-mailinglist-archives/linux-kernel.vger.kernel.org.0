Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44316A1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 07:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfGPFwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 01:52:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34122 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGPFwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 01:52:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so8547211pfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 22:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ce2jLaPMXCD72bYLNYA258BHhaEVo6iHpiDOQC+FQ4=;
        b=EAwSpvRDJq+pmpj66q3k5ybcsXODYdq5DsVuGohdjomZqzaWnyjtHa4csnTmaJBP8c
         AfVkOKu7rxy98rwfZ21ktcwDVp3f/5u4jPrLJEEKt+9Dz+FsNDA+u1OJkaeb0AolyS9u
         kl6rWU6TWJ6vS2768Df+Ju39dhPkqqQLzNUTUyEF4C2yrihujftpCB5+LeQQzbqstIu6
         SgzkDFrdO5pohStfGmYpI0BCY/O1ugaBHSt4gzq4X56VHm6rpiIWcdnfeP6I3RJoEgKQ
         GzdGdYE17ohW0ITu1+g6i8ZAAUMpu4wd/c6xIVyNP7pBnHx8lyzoVky6QXdZ8sfk0uxB
         w2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ce2jLaPMXCD72bYLNYA258BHhaEVo6iHpiDOQC+FQ4=;
        b=JRqFHkhLvCPpqF49gDVOqrsWjVcW/idYG45n5KnBxwRwsSk2Sbt1R36B5b/d+qJZMa
         Hnhkkk8vA11rlpth12zgusfhT+XqUphtTUAJ+GbFJ9F5eHzt8t6L41oy0UwO8q22PVfL
         B7U1dhc46QoT4OgSY2vJJrN4EWQRHj1gW9okvoOLmwW8EGk6k6xEYzNR7/ICQpIXGOk1
         pCKJwa/6MWbr23fQyNXt2k/Faekqas1YkR4xG4+qKrMoW1/nt0ZYmW3QDuDrrdn6ZLiC
         c44ahRUly895JmBMjcaqe6V+CQa5VokuNGRHUl9GwDV7eqYUAprC7yhULV5Xlh6dyrCG
         9CYg==
X-Gm-Message-State: APjAAAVxYo6RTUYnPfe22TBJiR7qqqmBNkKEI3HulKw4sJU3vJ7Pl5WJ
        /qAde7ZLhvtGohHwHye3pCQ=
X-Google-Smtp-Source: APXvYqzx4hfoudsn20kqkHppNgNdYwx+84sqj5bdXMTSW+r2/DCd/Sz0FgmKJ5WhQT7kXkrxknU/KQ==
X-Received: by 2002:a17:90a:d997:: with SMTP id d23mr32413440pjv.84.1563256352791;
        Mon, 15 Jul 2019 22:52:32 -0700 (PDT)
Received: from localhost.localdomain ([103.83.147.246])
        by smtp.gmail.com with ESMTPSA id i3sm20839496pfo.138.2019.07.15.22.52.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 22:52:31 -0700 (PDT)
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     yamada.masahiro@socionext.com
Cc:     Julia.Lawall@lip6.fr, linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH v2] coccinelle: api: add devm_platform_ioremap_resource script
Date:   Tue, 16 Jul 2019 11:22:22 +0530
Message-Id: <20190716055222.7578-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use recently introduced devm_platform_ioremap_resource
helper which wraps platform_get_resource() and
devm_ioremap_resource() together. This helps produce much
cleaner code and remove local `struct resource` declaration.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
---

v2:
   - added SPDX License
   - used IORESOURCE_MEM instead of generic argument.
   - added Julia's SoB.

 .../api/devm_platform_ioremap_resource.cocci  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci

diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
new file mode 100644
index 000000000000..56a2e261d61d
--- /dev/null
+++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Use devm_platform_ioremap_resource helper which wraps
+/// platform_get_resource() and devm_ioremap_resource() together.
+///
+// Confidence: High
+// Copyright: (C) 2019 Himanshu Jha GPLv2.
+// Copyright: (C) 2019 Julia Lawall, Inria/LIP6. GPLv2.
+// Keywords: platform_get_resource, devm_ioremap_resource,
+// Keywords: devm_platform_ioremap_resource
+
+virtual patch
+virtual report
+
+@r depends on patch && !report@
+expression e1, e2, arg1, arg2, arg3;
+identifier id;
+@@
+
+(
+- id = platform_get_resource(arg1, IORESOURCE_MEM, arg2);
+|
+- struct resource *id = platform_get_resource(arg1, IORESOURCE_MEM, arg2);
+)
+  ... when != id
+- e1 = devm_ioremap_resource(arg3, id);
++ e1 = devm_platform_ioremap_resource(arg1, arg2);
+  ... when != id
+? id = e2
+
+@r1 depends on patch && !report@
+identifier r.id;
+type T;
+@@
+
+- T *id;
+  ...when != id
+
+@r2 depends on report && !patch@
+identifier id;
+expression e1, e2, arg1, arg2, arg3;
+position j0;
+@@
+
+(
+  id = platform_get_resource(arg1, IORESOURCE_MEM, arg2);
+|
+  struct resource *id = platform_get_resource(arg1, IORESOURCE_MEM, arg2);
+)
+  ... when != id
+  e1@j0 = devm_ioremap_resource(arg3, id);
+  ... when != id
+? id = e2
+
+@script:python depends on report && !patch@
+e1 << r2.e1;
+j0 << r2.j0;
+@@
+
+msg = "WARNING: Use devm_platform_ioremap_resource for %s" % (e1)
+coccilib.report.print_report(j0[0], msg)
-- 
2.17.1

