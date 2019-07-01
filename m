Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075753A350
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 04:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfFICa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 22:30:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfFIC1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=muUeH0qSiPs93hB+5K+jC1fsJtuqBjZ9628QruMrh+E=; b=S90t6OD8NbAYCtOBY9DUoxXAun
        lTLPrxeWwZYwDryJXUeJlmg0ENShgT0nzG1DHBupRt92frJ8sjCeXw/ZsYZpLvR0Pu9On4pkB9OkX
        kVndC1HPJ4jiN8R4Jo9BjlgHG7RyB2HpZjG+FC5Tnd2+oWPU96SaM64FppRftxOj0QGpKrf56a4zT
        Yfs70nTXbZgMAECQaFVAmD7JkbsBu0PNw5sj3Y+qrvSfG9o8z5Zyz5gyLq9t5tP6TUU2bQTzPZWR3
        JZ46/JXP6wYt75uuYmFw/JzTr2la5SpMoC7YhvG61H5EVH07lsFmNpWfxlyf+yxgooWmUtXrUCbcW
        zI9SV8Zw==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYO-0001mw-1S; Sun, 09 Jun 2019 02:27:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000Jd-Ao; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v3 19/33] docs: pcmcia: convert docs to ReST and rename to *.rst
Date:   Sat,  8 Jun 2019 23:27:09 -0300
Message-Id: <d1b05720154bdbc4b75f5583cd4d1740e58b4cde.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pcmcia docs to ReST format. Most of the changes here
are trivial.

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{devicetable.txt => devicetable.rst}      |  4 ++
 ...{driver-changes.txt => driver-changes.rst} | 35 +++++++++++------
 .../pcmcia/{driver.txt => driver.rst}         | 18 ++++-----
 Documentation/pcmcia/index.rst                | 20 ++++++++++
 .../pcmcia/{locking.txt => locking.rst}       | 39 +++++++++++++------
 drivers/pcmcia/ds.c                           |  2 +-
 include/pcmcia/ds.h                           |  2 +-
 include/pcmcia/ss.h                           |  2 +-
 8 files changed, 86 insertions(+), 36 deletions(-)
 rename Documentation/pcmcia/{devicetable.txt => devicetable.rst} (97%)
 rename Documentation/pcmcia/{driver-changes.txt => driver-changes.rst} (90%)
 rename Documentation/pcmcia/{driver.txt => driver.rst} (66%)
 create mode 100644 Documentation/pcmcia/index.rst
 rename Documentation/pcmcia/{locking.txt => locking.rst} (81%)

diff --git a/Documentation/pcmcia/devicetable.txt b/Documentation/pcmcia/devicetable.rst
similarity index 97%
rename from Documentation/pcmcia/devicetable.txt
rename to Documentation/pcmcia/devicetable.rst
index 5f3e00ab54c4..fd1d60d12ca1 100644
--- a/Documentation/pcmcia/devicetable.txt
+++ b/Documentation/pcmcia/devicetable.rst
@@ -1,3 +1,7 @@
+============
+Device table
+============
+
 Matching of PCMCIA devices to drivers is done using one or more of the
 following criteria:
 
diff --git a/Documentation/pcmcia/driver-changes.txt b/Documentation/pcmcia/driver-changes.rst
similarity index 90%
rename from Documentation/pcmcia/driver-changes.txt
rename to Documentation/pcmcia/driver-changes.rst
index 78355c4c268a..33fe9ebec049 100644
--- a/Documentation/pcmcia/driver-changes.txt
+++ b/Documentation/pcmcia/driver-changes.rst
@@ -1,15 +1,21 @@
+==============
+Driver changes
+==============
+
 This file details changes in 2.6 which affect PCMCIA card driver authors:
+
 * pcmcia_loop_config() and autoconfiguration (as of 2.6.36)
-   If struct pcmcia_device *p_dev->config_flags is set accordingly,
+   If `struct pcmcia_device *p_dev->config_flags` is set accordingly,
    pcmcia_loop_config() now sets up certain configuration values
    automatically, though the driver may still override the settings
    in the callback function. The following autoconfiguration options
    are provided at the moment:
-	CONF_AUTO_CHECK_VCC : check for matching Vcc
-	CONF_AUTO_SET_VPP   : set Vpp
-	CONF_AUTO_AUDIO     : auto-enable audio line, if required
-	CONF_AUTO_SET_IO    : set ioport resources (->resource[0,1])
-	CONF_AUTO_SET_IOMEM : set first iomem resource (->resource[2])
+
+	- CONF_AUTO_CHECK_VCC : check for matching Vcc
+	- CONF_AUTO_SET_VPP   : set Vpp
+	- CONF_AUTO_AUDIO     : auto-enable audio line, if required
+	- CONF_AUTO_SET_IO    : set ioport resources (->resource[0,1])
+	- CONF_AUTO_SET_IOMEM : set first iomem resource (->resource[2])
 
 * pcmcia_request_configuration -> pcmcia_enable_device (as of 2.6.36)
    pcmcia_request_configuration() got renamed to pcmcia_enable_device(),
@@ -19,14 +25,14 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
 
 * pcmcia_request_window changes (as of 2.6.36)
    Instead of win_req_t, drivers are now requested to fill out
-   struct pcmcia_device *p_dev->resource[2,3,4,5] for up to four ioport
+   `struct pcmcia_device *p_dev->resource[2,3,4,5]` for up to four ioport
    ranges. After a call to pcmcia_request_window(), the regions found there
    are reserved and may be used immediately -- until pcmcia_release_window()
    is called.
 
 * pcmcia_request_io changes (as of 2.6.36)
    Instead of io_req_t, drivers are now requested to fill out
-   struct pcmcia_device *p_dev->resource[0,1] for up to two ioport
+   `struct pcmcia_device *p_dev->resource[0,1]` for up to two ioport
    ranges. After a call to pcmcia_request_io(), the ports found there
    are reserved, after calling pcmcia_request_configuration(), they may
    be used.
@@ -42,7 +48,8 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
 * New IRQ request rules (as of 2.6.35)
    Instead of the old pcmcia_request_irq() interface, drivers may now
    choose between:
-   - calling request_irq/free_irq directly. Use the IRQ from *p_dev->irq.
+
+   - calling request_irq/free_irq directly. Use the IRQ from `*p_dev->irq`.
    - use pcmcia_request_irq(p_dev, handler_t); the PCMCIA core will
      clean up automatically on calls to pcmcia_disable_device() or
      device ejection.
@@ -72,13 +79,16 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
    exports for them were removed.
 
 * Unify detach and REMOVAL event code, as well as attach and INSERTION
-  code (as of 2.6.16)
+  code (as of 2.6.16)::
+
        void (*remove)          (struct pcmcia_device *dev);
        int (*probe)            (struct pcmcia_device *dev);
 
-* Move suspend, resume and reset out of event handler (as of 2.6.16)
+* Move suspend, resume and reset out of event handler (as of 2.6.16)::
+
        int (*suspend)          (struct pcmcia_device *dev);
        int (*resume)           (struct pcmcia_device *dev);
+
   should be initialized in struct pcmcia_driver, and handle
   (SUSPEND == RESET_PHYSICAL) and (RESUME == CARD_RESET) events
 
@@ -117,7 +127,8 @@ This file details changes in 2.6 which affect PCMCIA card driver authors:
 * core functions no longer available (as of 2.6.11)
    The following functions have been removed from the kernel source
    because they are unused by all in-kernel drivers, and no external
-   driver was reported to rely on them:
+   driver was reported to rely on them::
+
 	pcmcia_get_first_region()
 	pcmcia_get_next_region()
 	pcmcia_modify_window()
diff --git a/Documentation/pcmcia/driver.txt b/Documentation/pcmcia/driver.rst
similarity index 66%
rename from Documentation/pcmcia/driver.txt
rename to Documentation/pcmcia/driver.rst
index 0ac167920778..5c4fe84d51c1 100644
--- a/Documentation/pcmcia/driver.txt
+++ b/Documentation/pcmcia/driver.rst
@@ -1,16 +1,16 @@
+=============
 PCMCIA Driver
--------------
-
+=============
 
 sysfs
 -----
 
 New PCMCIA IDs may be added to a device driver pcmcia_device_id table at
-runtime as shown below:
+runtime as shown below::
 
-echo "match_flags manf_id card_id func_id function device_no \
-prod_id_hash[0] prod_id_hash[1] prod_id_hash[2] prod_id_hash[3]" > \
-/sys/bus/pcmcia/drivers/{driver}/new_id
+  echo "match_flags manf_id card_id func_id function device_no \
+  prod_id_hash[0] prod_id_hash[1] prod_id_hash[2] prod_id_hash[3]" > \
+  /sys/bus/pcmcia/drivers/{driver}/new_id
 
 All fields are passed in as hexadecimal values (no leading 0x).
 The meaning is described in the PCMCIA specification, the match_flags is
@@ -22,9 +22,9 @@ PCMCIA device listed in its (newly updated) pcmcia_device_id list.
 
 A common use-case is to add a new device according to the manufacturer ID
 and the card ID (form the manf_id and card_id file in the device tree).
-For this, just use:
+For this, just use::
 
-echo "0x3 manf_id card_id 0 0 0 0 0 0 0" > \
-        /sys/bus/pcmcia/drivers/{driver}/new_id
+  echo "0x3 manf_id card_id 0 0 0 0 0 0 0" > \
+    /sys/bus/pcmcia/drivers/{driver}/new_id
 
 after loading the driver.
diff --git a/Documentation/pcmcia/index.rst b/Documentation/pcmcia/index.rst
new file mode 100644
index 000000000000..779c8527109e
--- /dev/null
+++ b/Documentation/pcmcia/index.rst
@@ -0,0 +1,20 @@
+:orphan:
+
+======
+pcmcia
+======
+
+.. toctree::
+    :maxdepth: 1
+
+    driver
+    devicetable
+    locking
+    driver-changes
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/pcmcia/locking.txt b/Documentation/pcmcia/locking.rst
similarity index 81%
rename from Documentation/pcmcia/locking.txt
rename to Documentation/pcmcia/locking.rst
index b2c9b478906b..e35257139c89 100644
--- a/Documentation/pcmcia/locking.txt
+++ b/Documentation/pcmcia/locking.rst
@@ -1,3 +1,7 @@
+=======
+Locking
+=======
+
 This file explains the locking and exclusion scheme used in the PCCARD
 and PCMCIA subsystems.
 
@@ -5,16 +9,21 @@ and PCMCIA subsystems.
 A) Overview, Locking Hierarchy:
 ===============================
 
-pcmcia_socket_list_rwsem	- protects only the list of sockets
-- skt_mutex			- serializes card insert / ejection
-  - ops_mutex			- serializes socket operation
+pcmcia_socket_list_rwsem
+	- protects only the list of sockets
+
+- skt_mutex
+	- serializes card insert / ejection
+
+  - ops_mutex
+	- serializes socket operation
 
 
 B) Exclusion
 ============
 
 The following functions and callbacks to struct pcmcia_socket must
-be called with "skt_mutex" held:
+be called with "skt_mutex" held::
 
 	socket_detect_change()
 	send_event()
@@ -31,7 +40,7 @@ be called with "skt_mutex" held:
 	struct pcmcia_callback	*callback
 
 The following functions and callbacks to struct pcmcia_socket must
-be called with "ops_mutex" held:
+be called with "ops_mutex" held::
 
 	socket_reset()
 	socket_setup()
@@ -39,7 +48,7 @@ be called with "ops_mutex" held:
 	struct pccard_operations	*ops
 	struct pccard_resource_ops	*resource_ops;
 
-Note that send_event() and struct pcmcia_callback *callback must not be
+Note that send_event() and `struct pcmcia_callback *callback` must not be
 called with "ops_mutex" held.
 
 
@@ -60,19 +69,23 @@ The resource_ops and their data are protected by ops_mutex.
 The "main" struct pcmcia_socket is protected as follows (read-only fields
 or single-use fields not mentioned):
 
-- by pcmcia_socket_list_rwsem:
+- by pcmcia_socket_list_rwsem::
+
 	struct list_head	socket_list;
 
-- by thread_lock:
+- by thread_lock::
+
 	unsigned int		thread_events;
 
-- by skt_mutex:
+- by skt_mutex::
+
 	u_int			suspended_state;
 	void			(*tune_bridge);
 	struct pcmcia_callback	*callback;
 	int			resume_status;
 
-- by ops_mutex:
+- by ops_mutex::
+
 	socket_state_t		socket;
 	u_int			state;
 	u_short			lock_count;
@@ -100,7 +113,8 @@ The "main" struct pcmcia_device is protected as follows (read-only fields
 or single-use fields not mentioned):
 
 
-- by pcmcia_socket->ops_mutex:
+- by pcmcia_socket->ops_mutex::
+
 	struct list_head	socket_device_list;
 	struct config_t		*function_config;
 	u16			_irq:1;
@@ -111,7 +125,8 @@ or single-use fields not mentioned):
 	u16			suspended:1;
 	u16			_removed:1;
 
-- by the PCMCIA driver:
+- by the PCMCIA driver::
+
 	io_req_t		io;
 	irq_req_t		irq;
 	config_req_t		conf;
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index a9258f641cee..5230e284bb20 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -67,7 +67,7 @@ static void pcmcia_check_driver(struct pcmcia_driver *p_drv)
 			       "be 0x%x\n", p_drv->name, did->prod_id[i],
 			       did->prod_id_hash[i], hash);
 			printk(KERN_DEBUG "pcmcia: see "
-				"Documentation/pcmcia/devicetable.txt for "
+				"Documentation/pcmcia/devicetable.rst for "
 				"details\n");
 		}
 		did++;
diff --git a/include/pcmcia/ds.h b/include/pcmcia/ds.h
index 3037157855f0..4e58c20dabcb 100644
--- a/include/pcmcia/ds.h
+++ b/include/pcmcia/ds.h
@@ -39,7 +39,7 @@ struct config_t;
 struct net_device;
 
 /* dynamic device IDs for PCMCIA device drivers. See
- * Documentation/pcmcia/driver.txt for details.
+ * Documentation/pcmcia/driver.rst for details.
 */
 struct pcmcia_dynids {
 	struct mutex		lock;
diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 731cde010f42..89629ee57840 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -190,7 +190,7 @@ struct pcmcia_socket {
 	unsigned int			sysfs_events;
 
 	/* For the non-trivial interaction between these locks,
-	 * see Documentation/pcmcia/locking.txt */
+	 * see Documentation/pcmcia/locking.rst */
 	struct mutex			skt_mutex;
 	struct mutex			ops_mutex;
 
-- 
2.21.0

