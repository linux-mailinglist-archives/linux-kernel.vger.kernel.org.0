Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9D175506
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCBIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbgCBH7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:43 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876F8246C7;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135982;
        bh=Jzq/d13Lj8z2lnW0mDzJsr013tR8G799MjoHArJrvC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlgTCryL7OO3/DmVSxJTgNxsr2+csmefxXL0oSWybbzboJfJcG61p3bT3fOHoPlx3
         qcaKT4ryTjA0mPAzAFR70MHxrZoiNvt8HaAcJK0VnHZ9t0H/Bu1rA0q8xhHN+3b4mV
         Eq8XT16mKBHi2dFJAwqJ8jf8k8YW6j6LdLiZCumE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzH-0003gq-6l; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 08/12] docs: dt: convert overlay-notes.txt to ReST format
Date:   Mon,  2 Mar 2020 08:59:33 +0100
Message-Id: <1685e79f7b53c70c64e37841fb4df173094ebd17.1583135507.git.mchehab+huawei@kernel.org>
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
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to devicetree/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/index.rst            |   1 +
 .../{overlay-notes.txt => overlay-notes.rst}  | 141 +++++++++---------
 MAINTAINERS                                   |   2 +-
 3 files changed, 74 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (56%)

diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index ca83258fbba5..0669a53fc617 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -13,3 +13,4 @@ Open Firmware and Device Tree
    changesets
    dynamic-resolution-notes
    of_unittest
+   overlay-notes
diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.rst
similarity index 56%
rename from Documentation/devicetree/overlay-notes.txt
rename to Documentation/devicetree/overlay-notes.rst
index 3f20a39e4bc2..7e8e568f64a8 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
 Device Tree Overlay Notes
--------------------------
+=========================
 
 This document describes the implementation of the in-kernel
 device tree overlay functionality residing in drivers/of/overlay.c and is a
@@ -15,68 +18,68 @@ Since the kernel mainly deals with devices, any new device node that result
 in an active device should have it created while if the device node is either
 disabled or removed all together, the affected device should be deregistered.
 
-Lets take an example where we have a foo board with the following base tree:
-
----- foo.dts -----------------------------------------------------------------
-	/* FOO platform */
-	/ {
-		compatible = "corp,foo";
-
-		/* shared resources */
-		res: res {
-		};
-
-		/* On chip peripherals */
-		ocp: ocp {
-			/* peripherals that are always instantiated */
-			peripheral1 { ... };
-		}
-	};
----- foo.dts -----------------------------------------------------------------
-
-The overlay bar.dts, when loaded (and resolved as described in [1]) should
-
----- bar.dts -----------------------------------------------------------------
-/plugin/;	/* allow undefined label references and record them */
-/ {
-	....	/* various properties for loader use; i.e. part id etc. */
-	fragment@0 {
-		target = <&ocp>;
-		__overlay__ {
-			/* bar peripheral */
-			bar {
-				compatible = "corp,bar";
-				... /* various properties and child nodes */
-			}
-		};
-	};
-};
----- bar.dts -----------------------------------------------------------------
-
-result in foo+bar.dts
-
----- foo+bar.dts -------------------------------------------------------------
-	/* FOO platform + bar peripheral */
-	/ {
-		compatible = "corp,foo";
-
-		/* shared resources */
-		res: res {
-		};
-
-		/* On chip peripherals */
-		ocp: ocp {
-			/* peripherals that are always instantiated */
-			peripheral1 { ... };
-
-			/* bar peripheral */
-			bar {
-				compatible = "corp,bar";
-				... /* various properties and child nodes */
-			}
-		}
-	};
----- foo+bar.dts -------------------------------------------------------------
+Lets take an example where we have a foo board with the following base tree::
+
+    ---- foo.dts --------------------------------------------------------------
+	    /* FOO platform */
+	    / {
+		    compatible = "corp,foo";
+
+		    /* shared resources */
+		    res: res {
+		    };
+
+		    /* On chip peripherals */
+		    ocp: ocp {
+			    /* peripherals that are always instantiated */
+			    peripheral1 { ... };
+		    }
+	    };
+    ---- foo.dts --------------------------------------------------------------
+
+The overlay bar.dts, when loaded (and resolved as described in [1]) should::
+
+    ---- bar.dts --------------------------------------------------------------
+    /plugin/;	/* allow undefined label references and record them */
+    / {
+	    ....	/* various properties for loader use; i.e. part id etc. */
+	    fragment@0 {
+		    target = <&ocp>;
+		    __overlay__ {
+			    /* bar peripheral */
+			    bar {
+				    compatible = "corp,bar";
+				    ... /* various properties and child nodes */
+			    }
+		    };
+	    };
+    };
+    ---- bar.dts --------------------------------------------------------------
+
+result in foo+bar.dts::
+
+    ---- foo+bar.dts ----------------------------------------------------------
+	    /* FOO platform + bar peripheral */
+	    / {
+		    compatible = "corp,foo";
+
+		    /* shared resources */
+		    res: res {
+		    };
+
+		    /* On chip peripherals */
+		    ocp: ocp {
+			    /* peripherals that are always instantiated */
+			    peripheral1 { ... };
+
+			    /* bar peripheral */
+			    bar {
+				    compatible = "corp,bar";
+				    ... /* various properties and child nodes */
+			    }
+		    }
+	    };
+    ---- foo+bar.dts ----------------------------------------------------------
 
 As a result of the overlay, a new device node (bar) has been created
 so a bar platform device will be registered and if a matching device driver
@@ -88,11 +91,11 @@ Overlay in-kernel API
 The API is quite easy to use.
 
 1. Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
-return value is an error or a cookie identifying this overlay.
+   return value is an error or a cookie identifying this overlay.
 
 2. Call of_overlay_remove() to remove and cleanup the overlay changeset
-previously created via the call to of_overlay_fdt_apply(). Removal of an
-overlay changeset that is stacked by another will not be permitted.
+   previously created via the call to of_overlay_fdt_apply(). Removal of an
+   overlay changeset that is stacked by another will not be permitted.
 
 Finally, if you need to remove all overlays in one-go, just call
 of_overlay_remove_all() which will remove every single one in the correct
@@ -109,9 +112,9 @@ respective node it received.
 Overlay DTS Format
 ------------------
 
-The DTS of an overlay should have the following format:
+The DTS of an overlay should have the following format::
 
-{
+    {
 	/* ignored properties by the overlay */
 
 	fragment@0 {	/* first child node */
@@ -131,7 +134,7 @@ The DTS of an overlay should have the following format:
 		...
 	};
 	/* more fragments follow */
-}
+    }
 
 Using the non-phandle based target method allows one to use a base DT which does
 not contain a __symbols__ node, i.e. it was not compiled with the -@ option.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1380b1ed69a2..3f679cb4b330 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12459,7 +12459,7 @@ M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/dynamic-resolution-notes.rst
-F:	Documentation/devicetree/overlay-notes.txt
+F:	Documentation/devicetree/overlay-notes.rst
 F:	drivers/of/overlay.c
 F:	drivers/of/resolver.c
 K:	of_overlay_notifier_
-- 
2.21.1

