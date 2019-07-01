Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5115D3A2DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 04:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfFIC1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 22:27:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfFIC13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1uNdQk2Zc5fugs3exEfsPSxkpKZNR2G+lru/IzqYl5E=; b=a+l6dZgr7ddGGAj3ct7fAeOYe6
        isMsvvgl01QdgygvPd0ZM/AhNZ+KartuPRN/YAt7s0GOVs1Ka8xTTDhR+Nm5KiyK9/4G9ZD4KKXy0
        hL0p0Vfjrw4FJpKDz/fyd1tGISZMgMzTdWtxZ76npF4823RUx6OVAzdC7MXH+I8ARU36nEYo32DkE
        D65VF93++zw+zxP6RIyEFWZuQxkKTHzm8x9GnjlXUSBaCOou2xWCdLhW8petox6A0Zdg+RPOUPelu
        jzuCBPWguRQ1nSZFo3YSB2qzEmxU48c0Axug4W9e0oUFiQjEDsbMhuwbIQtILDnGM81c8/BR3kIf3
        VPJgLe3Q==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYO-0001mf-1j; Sun, 09 Jun 2019 02:27:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYK-0000IA-Pe; Sat, 08 Jun 2019 23:27:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 01/33] docs: aoe: convert docs to ReST and rename to *.rst
Date:   Sat,  8 Jun 2019 23:26:51 -0300
Message-Id: <906b6f6c3d4a0ff95687e78e52a7dcf099b0f569.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two files within Documentation/aoe dir that are
documentation. The remaining ones are examples and shell
scripts.

Convert the two AoE files to ReST format, and add the others
as literal, as they're part of the documentation.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/aoe/{aoe.txt => aoe.rst}   | 63 +++++++++++++-----------
 Documentation/aoe/examples.rst           | 23 +++++++++
 Documentation/aoe/index.rst              | 19 +++++++
 Documentation/aoe/{todo.txt => todo.rst} |  3 ++
 Documentation/aoe/udev.txt               |  2 +-
 5 files changed, 81 insertions(+), 29 deletions(-)
 rename Documentation/aoe/{aoe.txt => aoe.rst} (79%)
 create mode 100644 Documentation/aoe/examples.rst
 create mode 100644 Documentation/aoe/index.rst
 rename Documentation/aoe/{todo.txt => todo.rst} (98%)

diff --git a/Documentation/aoe/aoe.txt b/Documentation/aoe/aoe.rst
similarity index 79%
rename from Documentation/aoe/aoe.txt
rename to Documentation/aoe/aoe.rst
index c71487d399d1..58747ecec71d 100644
--- a/Documentation/aoe/aoe.txt
+++ b/Documentation/aoe/aoe.rst
@@ -1,3 +1,6 @@
+Introduction
+============
+
 ATA over Ethernet is a network protocol that provides simple access to
 block storage on the LAN.
 
@@ -22,7 +25,8 @@ document the use of the driver and are not necessary if you install
 the aoetools.
 
 
-CREATING DEVICE NODES
+Creating Device Nodes
+=====================
 
   Users of udev should find the block device nodes created
   automatically, but to create all the necessary device nodes, use the
@@ -38,7 +42,8 @@ CREATING DEVICE NODES
   confusing when an AoE device is not present the first time the a
   command is run but appears a second later.
 
-USING DEVICE NODES
+Using Device Nodes
+==================
 
   "cat /dev/etherd/err" blocks, waiting for error diagnostic output,
   like any retransmitted packets.
@@ -55,7 +60,7 @@ USING DEVICE NODES
   by sysfs counterparts.  Using the commands in aoetools insulates
   users from these implementation details.
 
-  The block devices are named like this:
+  The block devices are named like this::
 
 	e{shelf}.{slot}
 	e{shelf}.{slot}p{part}
@@ -64,7 +69,8 @@ USING DEVICE NODES
   first shelf (shelf address zero).  That's the whole disk.  The first
   partition on that disk would be "e0.2p1".
 
-USING SYSFS
+Using sysfs
+===========
 
   Each aoe block device in /sys/block has the extra attributes of
   state, mac, and netif.  The state attribute is "up" when the device
@@ -78,29 +84,29 @@ USING SYSFS
 
   There is a script in this directory that formats this information in
   a convenient way.  Users with aoetools should use the aoe-stat
-  command.
+  command::
 
-  root@makki root# sh Documentation/aoe/status.sh 
-     e10.0            eth3              up
-     e10.1            eth3              up
-     e10.2            eth3              up
-     e10.3            eth3              up
-     e10.4            eth3              up
-     e10.5            eth3              up
-     e10.6            eth3              up
-     e10.7            eth3              up
-     e10.8            eth3              up
-     e10.9            eth3              up
-      e4.0            eth1              up
-      e4.1            eth1              up
-      e4.2            eth1              up
-      e4.3            eth1              up
-      e4.4            eth1              up
-      e4.5            eth1              up
-      e4.6            eth1              up
-      e4.7            eth1              up
-      e4.8            eth1              up
-      e4.9            eth1              up
+    root@makki root# sh Documentation/aoe/status.sh
+       e10.0            eth3              up
+       e10.1            eth3              up
+       e10.2            eth3              up
+       e10.3            eth3              up
+       e10.4            eth3              up
+       e10.5            eth3              up
+       e10.6            eth3              up
+       e10.7            eth3              up
+       e10.8            eth3              up
+       e10.9            eth3              up
+        e4.0            eth1              up
+        e4.1            eth1              up
+        e4.2            eth1              up
+        e4.3            eth1              up
+        e4.4            eth1              up
+        e4.5            eth1              up
+        e4.6            eth1              up
+        e4.7            eth1              up
+        e4.8            eth1              up
+        e4.9            eth1              up
 
   Use /sys/module/aoe/parameters/aoe_iflist (or better, the driver
   option discussed below) instead of /dev/etherd/interfaces to limit
@@ -113,12 +119,13 @@ USING SYSFS
   for this purpose.  You can also directly use the
   /dev/etherd/discover special file described above.
 
-DRIVER OPTIONS
+Driver Options
+==============
 
   There is a boot option for the built-in aoe driver and a
   corresponding module parameter, aoe_iflist.  Without this option,
   all network interfaces may be used for ATA over Ethernet.  Here is a
-  usage example for the module parameter.
+  usage example for the module parameter::
 
     modprobe aoe_iflist="eth1 eth3"
 
diff --git a/Documentation/aoe/examples.rst b/Documentation/aoe/examples.rst
new file mode 100644
index 000000000000..91f3198e52c1
--- /dev/null
+++ b/Documentation/aoe/examples.rst
@@ -0,0 +1,23 @@
+Example of udev rules
+---------------------
+
+ .. include:: udev.txt
+    :literal:
+
+Example of udev install rules script
+------------------------------------
+
+ .. literalinclude:: udev-install.sh
+    :language: shell
+
+Example script to get status
+----------------------------
+
+ .. literalinclude:: status.sh
+    :language: shell
+
+Example of AoE autoload script
+------------------------------
+
+ .. literalinclude:: autoload.sh
+    :language: shell
diff --git a/Documentation/aoe/index.rst b/Documentation/aoe/index.rst
new file mode 100644
index 000000000000..4394b9b7913c
--- /dev/null
+++ b/Documentation/aoe/index.rst
@@ -0,0 +1,19 @@
+:orphan:
+
+=======================
+ATA over Ethernet (AoE)
+=======================
+
+.. toctree::
+    :maxdepth: 1
+
+    aoe
+    todo
+    examples
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/aoe/todo.txt b/Documentation/aoe/todo.rst
similarity index 98%
rename from Documentation/aoe/todo.txt
rename to Documentation/aoe/todo.rst
index c09dfad4aed8..dea8db5a33e1 100644
--- a/Documentation/aoe/todo.txt
+++ b/Documentation/aoe/todo.rst
@@ -1,3 +1,6 @@
+TODO
+====
+
 There is a potential for deadlock when allocating a struct sk_buff for
 data that needs to be written out to aoe storage.  If the data is
 being written from a dirty page in order to free that page, and if
diff --git a/Documentation/aoe/udev.txt b/Documentation/aoe/udev.txt
index 1f06daf03f5b..54feda5a0772 100644
--- a/Documentation/aoe/udev.txt
+++ b/Documentation/aoe/udev.txt
@@ -11,7 +11,7 @@
 #   udev_rules="/etc/udev/rules.d/"
 #   bash# ls /etc/udev/rules.d/
 #   10-wacom.rules  50-udev.rules
-#   bash# cp /path/to/linux-2.6.xx/Documentation/aoe/udev.txt \
+#   bash# cp /path/to/linux/Documentation/aoe/udev.txt \
 #           /etc/udev/rules.d/60-aoe.rules
 #  
 
-- 
2.21.0

