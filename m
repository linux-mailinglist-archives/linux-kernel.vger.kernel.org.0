Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF31332CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfFCJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 05:24:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:54536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbfFCJYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096371"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:18 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 5/7] mei: docs: add a short description for nfc behind mei
Date:   Mon,  3 Jun 2019 12:14:04 +0300
Message-Id: <20190603091406.28915-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603091406.28915-1-tomas.winkler@intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/driver-api/mei/index.rst        |  2 +-
 .../driver-api/mei/mei-client-bus.rst         |  7 +++++
 Documentation/driver-api/mei/nfc.rst          | 28 +++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/mei/nfc.rst

diff --git a/Documentation/driver-api/mei/index.rst b/Documentation/driver-api/mei/index.rst
index d261afac6852..3a22b522ee78 100644
--- a/Documentation/driver-api/mei/index.rst
+++ b/Documentation/driver-api/mei/index.rst
@@ -16,7 +16,7 @@ Intel(R) Management Engine Interface (Intel(R) MEI)
         Table of Contents
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 3
 
    mei
    mei-client-bus
diff --git a/Documentation/driver-api/mei/mei-client-bus.rst b/Documentation/driver-api/mei/mei-client-bus.rst
index 7310dd45c484..bfe28ebc3ca8 100644
--- a/Documentation/driver-api/mei/mei-client-bus.rst
+++ b/Documentation/driver-api/mei/mei-client-bus.rst
@@ -158,3 +158,10 @@ process received data.
 
         }
 
+MEI Client Bus Drivers
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   nfc
diff --git a/Documentation/driver-api/mei/nfc.rst b/Documentation/driver-api/mei/nfc.rst
new file mode 100644
index 000000000000..b5b6fc96f85e
--- /dev/null
+++ b/Documentation/driver-api/mei/nfc.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+MEI NFC
+-------
+
+Some Intel 8 and 9 Serieses chipsets supports NFC devices connected behind
+the Intel Management Engine controller.
+MEI client bus exposes the NFC chips as NFC phy devices and enables
+binding with Microread and NXP PN544 NFC device driver from the Linux NFC
+subsystem.
+
+.. kernel-render:: DOT
+   :alt: MEI NFC digraph
+   :caption: **MEI NFC** Stack
+
+   digraph NFC {
+    cl_nfc -> me_cl_nfc;
+    "drivers/nfc/mei_phy" -> cl_nfc [lhead=bus];
+    "drivers/nfc/microread/mei" -> cl_nfc;
+    "drivers/nfc/microread/mei" -> "drivers/nfc/mei_phy";
+    "drivers/nfc/pn544/mei" -> cl_nfc;
+    "drivers/nfc/pn544/mei" -> "drivers/nfc/mei_phy";
+    "net/nfc" -> "drivers/nfc/microread/mei";
+    "net/nfc" -> "drivers/nfc/pn544/mei";
+    "neard" -> "net/nfc";
+    cl_nfc [label="mei/bus(nfc)"];
+    me_cl_nfc [label="me fw (nfc)"];
+   }
-- 
2.20.1

