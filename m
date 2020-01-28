Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43014AD43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 01:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgA1Ai1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 19:38:27 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40528 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1Ai0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:38:26 -0500
Received: by mail-yb1-f194.google.com with SMTP id l197so5919520ybf.7;
        Mon, 27 Jan 2020 16:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uwHE2384+f6E6qrGI97uhlNjDcRkcruzPNFIU/quAFo=;
        b=m5egoETD744VGmc+moHM25iFJ6RqvSbosi6paPzf4ezJ/ZHPqGLlxEBY26nU6hytDA
         b/v4B5ys7vEUkVCJ77H2R03J4MLvETSU0PRgv1SU4H6mUxeOfBx3wgvdk1khUFjQd7GD
         VAlHcWhc/r0qTx9sJUIY4sZzLo1irTrinZYkKivPjYzP3pCUliKF0CY/Hr6XQfrLyAMb
         HJxnn7EcUXNcHUh/d1IpuGGp94n/F+GV2D4ZwPIUEWWzYUaqsbAJ7GmPnc7ygAkpcWOw
         wgM/zrViyCMegZfJFbPVcjGwGeY0hyY2qBKVMhwGRSidaOlPRxnb7lY4Jrllev8RPjqs
         5zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uwHE2384+f6E6qrGI97uhlNjDcRkcruzPNFIU/quAFo=;
        b=BzMxLMJBNlYrODn2sxlZWHe4gvuCl+J218ZYt9/8OI6pIh3wgzlqSfLsP2fUoTnt+N
         BunVpEbiBsDr7WZ2Zpf0ZvMN1Ftg6HW8Ib5COHZO1Qd59KonZzg5F6sqohVPgNLhxQbg
         h70hD/f17xB5kIWwEljZSYeq91f6eTvIoVvp+BG60nRBhjI8MgFulosI+Gn1tlZ87LO1
         ltQ3Z3XJhnndPdA0A1R+Os7djxGBYAOXO2wyoG8LbSaTMAWPKCKMgMilZlL3NAziEVHG
         hl/RPL7M8OZDpyxkuBftA0FT1qo8izD9oxaKP+39RB9eX1Vp5vUUf8gAHTgqhGyHsJwS
         OC1w==
X-Gm-Message-State: APjAAAWnHCGluRQUVTxYxaBrRNteVGw52dyICMR1qT4E3JHoe9sqG9iI
        W9uny8bRBQqj77H4urvLIHwtPR3e
X-Google-Smtp-Source: APXvYqxtT0WML5m6Xk2NSVeNWAx8mBGoxmosVg7LFZYZceP6nGBThUyy/8CI/aBnitiv1ekWAkU02w==
X-Received: by 2002:a25:7601:: with SMTP id r1mr15454079ybc.187.1580171904945;
        Mon, 27 Jan 2020 16:38:24 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id q62sm7447436ywg.76.2020.01.27.16.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jan 2020 16:38:24 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2] of: Documentation: change overlay example to use current syntax
Date:   Mon, 27 Jan 2020 18:37:18 -0600
Message-Id: <1580171838-1770-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The overlay implementation details in the compiled (DTB) file are
now properly implemented by the dtc compiler and should no longer
be hard coded in the source file.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since v1:
  - fixed typo in patch comment (implementation)

 Documentation/devicetree/overlay-notes.txt | 85 ++++++++++++------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index 725fb8d255c1..fddc63da7dba 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -19,6 +19,7 @@ Lets take an example where we have a foo board with the following base tree:
 
 ---- foo.dts -----------------------------------------------------------------
 	/* FOO platform */
+	/dts-v1/;
 	/ {
 		compatible = "corp,foo";
 
@@ -30,30 +31,25 @@ Lets take an example where we have a foo board with the following base tree:
 		ocp: ocp {
 			/* peripherals that are always instantiated */
 			peripheral1 { ... };
-		}
+		};
 	};
 ---- foo.dts -----------------------------------------------------------------
 
-The overlay bar.dts, when loaded (and resolved as described in [1]) should
+The overlay bar.dts,
 
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
+---- bar.dts - overlay target location by label ------------------------------
+	/dts-v1/;
+	/plugin/;
+	&ocp {
+		/* bar peripheral */
+		bar {
+			compatible = "corp,bar";
+			... /* various properties and child nodes */
 		};
 	};
-};
 ---- bar.dts -----------------------------------------------------------------
 
-result in foo+bar.dts
+when loaded (and resolved as described in [1]) should result in foo+bar.dts
 
 ---- foo+bar.dts -------------------------------------------------------------
 	/* FOO platform + bar peripheral */
@@ -73,8 +69,8 @@ result in foo+bar.dts
 			bar {
 				compatible = "corp,bar";
 				... /* various properties and child nodes */
-			}
-		}
+			};
+		};
 	};
 ---- foo+bar.dts -------------------------------------------------------------
 
@@ -82,6 +78,27 @@ As a result of the overlay, a new device node (bar) has been created
 so a bar platform device will be registered and if a matching device driver
 is loaded the device will be created as expected.
 
+If the base DT was not compiled with the -@ option then the "&ocp" label
+will not be available to resolve the overlay node(s) to the proper location
+in the base DT. In this case, the target path can be provided. The target
+location by label syntax is preferred because the overlay can be applied to
+any base DT containing the label, no matter where the label occurs in the DT.
+
+The above bar.dts example modified to use target path syntax is:
+
+---- bar.dts - overlay target location by explicit path ----------------------
+	/dts-v1/;
+	/plugin/;
+	&{/ocp} {
+		/* bar peripheral */
+		bar {
+			compatible = "corp,bar";
+			... /* various properties and child nodes */
+		}
+	};
+---- bar.dts -----------------------------------------------------------------
+
+
 Overlay in-kernel API
 --------------------------------
 
@@ -105,35 +122,3 @@ enum of_overlay_notify_action for details.
 Note that a notifier callback is not supposed to store pointers to a device
 tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
 respective node it received.
-
-Overlay DTS Format
-------------------
-
-The DTS of an overlay should have the following format:
-
-{
-	/* ignored properties by the overlay */
-
-	fragment@0 {	/* first child node */
-
-		target=<phandle>;	/* phandle target of the overlay */
-	or
-		target-path="/path";	/* target path of the overlay */
-
-		__overlay__ {
-			property-a;	/* add property-a to the target */
-			node-a {	/* add to an existing, or create a node-a */
-				...
-			};
-		};
-	}
-	fragment@1 {	/* second child node */
-		...
-	};
-	/* more fragments follow */
-}
-
-Using the non-phandle based target method allows one to use a base DT which does
-not contain a __symbols__ node, i.e. it was not compiled with the -@ option.
-The __symbols__ node is only required for the target=<phandle> method, since it
-contains the information required to map from a phandle to a tree location.
-- 
Frank Rowand <frank.rowand@sony.com>

