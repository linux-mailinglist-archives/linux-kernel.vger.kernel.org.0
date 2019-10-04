Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA408CBF6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbfJDPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:40:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:25151 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbfJDPkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:40:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 08:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="186298009"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2019 08:40:34 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: buf: drop 'running hook' debug messages.
Date:   Fri,  4 Oct 2019 21:26:59 +0300
Message-Id: <20191004182659.2933-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop 'running hook' debug messages, as this info
can be already retrieved via ftrace.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 0a2b99e1af45..9ad9c01ddf41 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -46,8 +46,6 @@ static const uuid_le mei_nfc_info_guid = MEI_UUID_NFC_INFO;
  */
 static void number_of_connections(struct mei_cl_device *cldev)
 {
-	dev_dbg(&cldev->dev, "running hook %s\n", __func__);
-
 	if (cldev->me_cl->props.max_number_of_connections > 1)
 		cldev->do_match = 0;
 }
@@ -59,8 +57,6 @@ static void number_of_connections(struct mei_cl_device *cldev)
  */
 static void blacklist(struct mei_cl_device *cldev)
 {
-	dev_dbg(&cldev->dev, "running hook %s\n", __func__);
-
 	cldev->do_match = 0;
 }
 
@@ -71,8 +67,6 @@ static void blacklist(struct mei_cl_device *cldev)
  */
 static void whitelist(struct mei_cl_device *cldev)
 {
-	dev_dbg(&cldev->dev, "running hook %s\n", __func__);
-
 	cldev->do_match = 1;
 }
 
@@ -256,7 +250,6 @@ static void mei_wd(struct mei_cl_device *cldev)
 {
 	struct pci_dev *pdev = to_pci_dev(cldev->dev.parent);
 
-	dev_dbg(&cldev->dev, "running hook %s\n", __func__);
 	if (pdev->device == MEI_DEV_ID_WPT_LP ||
 	    pdev->device == MEI_DEV_ID_SPT ||
 	    pdev->device == MEI_DEV_ID_SPT_H)
@@ -410,8 +403,6 @@ static void mei_nfc(struct mei_cl_device *cldev)
 
 	bus = cldev->bus;
 
-	dev_dbg(&cldev->dev, "running hook %s\n", __func__);
-
 	mutex_lock(&bus->device_lock);
 	/* we need to connect to INFO GUID */
 	cl = mei_cl_alloc_linked(bus);
-- 
2.21.0

