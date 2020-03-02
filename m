Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708C7175508
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCBIAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgCBH7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:43 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B38246C8;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135982;
        bh=E3ydo3V7XAnhWZlK0zMKUkqChrgx7I5Q7v3YH0JirqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDy4PUCeiC6tGP4lQXwKGcpHnk9CtUxklBWF6tkBXNyK309itZ3OZm+fvkMKFM+4k
         HTTWt+wTW3zry+qgc8YyAO2n1p1wP3s391BOBuJjQeLbyEElrOZdq1NTuw3NetZpnC
         Ro2w0//z4a8KgVWKCf+r8oJipUVJPxJHJ/Cj6FaU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzH-0003h6-9S; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 11/12] docs: dt: convert submitting-patches.txt to ReST format
Date:   Mon,  2 Mar 2020 08:59:36 +0100
Message-Id: <4daa548a98f7fde56ed20cc30bcb31b7e8b1a9aa.1583135507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Mark literal blocks as such;
- Add it to bindings/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/index.rst          |  1 +
 ...submitting-patches.txt => submitting-patches.rst} | 12 +++++++++---
 .../devicetree/bindings/writing-bindings.txt         |  2 +-
 Documentation/process/submitting-patches.rst         |  2 +-
 .../it_IT/process/submitting-patches.rst             |  2 +-
 scripts/checkpatch.pl                                |  2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/{submitting-patches.txt => submitting-patches.rst} (92%)

diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
index 98ebdab24b51..6b87875a049c 100644
--- a/Documentation/devicetree/bindings/index.rst
+++ b/Documentation/devicetree/bindings/index.rst
@@ -8,3 +8,4 @@ Device Tree
    :maxdepth: 1
 
    ABI
+   submitting-patches
diff --git a/Documentation/devicetree/bindings/submitting-patches.txt b/Documentation/devicetree/bindings/submitting-patches.rst
similarity index 92%
rename from Documentation/devicetree/bindings/submitting-patches.txt
rename to Documentation/devicetree/bindings/submitting-patches.rst
index 98bee6240b65..0aab2b3f16d0 100644
--- a/Documentation/devicetree/bindings/submitting-patches.txt
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -1,13 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-  Submitting devicetree (DT) binding patches
+==========================================
+Submitting devicetree (DT) binding patches
+==========================================
 
 I. For patch submitters
+=======================
 
   0) Normal patch submission rules from Documentation/process/submitting-patches.rst
      applies.
 
   1) The Documentation/ and include/dt-bindings/ portion of the patch should
-     be a separate patch. The preferred subject prefix for binding patches is:
+     be a separate patch. The preferred subject prefix for binding patches is::
 
        "dt-bindings: <binding dir>: ..."
 
@@ -17,7 +21,7 @@ I. For patch submitters
 
   2) DT binding files are written in DT schema format using json-schema
      vocabulary and YAML file format. The DT binding files must pass validation
-     by running:
+     by running::
 
        make dt_binding_check
 
@@ -60,6 +64,7 @@ I. For patch submitters
 
 
 II. For kernel maintainers
+==========================
 
   1) If you aren't comfortable reviewing a given binding, reply to it and ask
      the devicetree maintainers for guidance.  This will help them prioritize
@@ -76,6 +81,7 @@ II. For kernel maintainers
      kept with the driver using the binding.
 
 III. Notes
+==========
 
   0) Please see ...bindings/ABI.txt for details regarding devicetree ABI.
 
diff --git a/Documentation/devicetree/bindings/writing-bindings.txt b/Documentation/devicetree/bindings/writing-bindings.txt
index 27dfd2d8016e..ca024b9c7433 100644
--- a/Documentation/devicetree/bindings/writing-bindings.txt
+++ b/Documentation/devicetree/bindings/writing-bindings.txt
@@ -4,7 +4,7 @@ This is a list of common review feedback items focused on binding design. With
 every rule, there are exceptions and bindings have many gray areas.
 
 For guidelines related to patches, see
-Documentation/devicetree/bindings/submitting-patches.txt
+Documentation/devicetree/bindings/submitting-patches.rst
 
 
 Overall design
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index ba5e944c7a63..1699b7f8e63a 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -16,7 +16,7 @@ for a list of items to check before
 submitting code.  If you are submitting a driver, also read
 :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`;
 for device tree binding patches, read
-Documentation/devicetree/bindings/submitting-patches.txt.
+Documentation/devicetree/bindings/submitting-patches.rst.
 
 Many of these steps describe the default behavior of the ``git`` version
 control system; if you use ``git`` to prepare your patches, you'll find much
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index cba1f8cb61ed..7c23c08e4401 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -21,7 +21,7 @@ Leggete anche :ref:`Documentation/translations/it_IT/process/submit-checklist.rs
 per una lista di punti da verificare prima di inviare del codice.  Se state
 inviando un driver, allora leggete anche :ref:`Documentation/translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`;
 per delle patch relative alle associazioni per Device Tree leggete
-Documentation/devicetree/bindings/submitting-patches.txt.
+Documentation/devicetree/bindings/submitting-patches.rst.
 
 Molti di questi passi descrivono il comportamento di base del sistema di
 controllo di versione ``git``; se utilizzate ``git`` per preparare le vostre
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4480d5eec2fa..14c7277e60a0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2607,7 +2607,7 @@ sub process {
 				if (($last_binding_patch != -1) &&
 				    ($last_binding_patch ^ $is_binding_patch)) {
 					WARN("DT_SPLIT_BINDING_PATCH",
-					     "DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt\n");
+					     "DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst\n");
 				}
 			}
 
-- 
2.21.1

