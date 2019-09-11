Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE0BB00CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfIKQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 12:03:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:16353 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbfIKQDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:03:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 09:03:06 -0700
X-IronPort-AV: E=Sophos;i="5.64,494,1559545200"; 
   d="scan'208";a="184526906"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 09:03:06 -0700
Subject: [PATCH v2 1/3] MAINTAINERS: Reclaim the P: tag for Maintainer Entry
 Profile
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Wed, 11 Sep 2019 08:48:48 -0700
Message-ID: <156821692805.2951081.1395288717170089573.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup some P: entries to be M: and delete the others that do not include an
email address. The P: tag will be used to indicate the location of a
Profile for a given MAINTAINERS entry.

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7a47b5210fd..3f171339df53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -76,7 +76,6 @@ trivial patch so apply some common sense.
 
 Descriptions of section entries:
 
-	P: Person (obsolete)
 	M: Mail patches to: FullName <address@domain>
 	R: Designated reviewer: FullName <address@domain>
 	   These reviewers should be CCed on patches.
@@ -811,7 +810,7 @@ S:	Orphan
 F:	drivers/usb/gadget/udc/amd5536udc.*
 
 AMD GEODE PROCESSOR/CHIPSET SUPPORT
-P:	Andres Salomon <dilinger@queued.net>
+M:	Andres Salomon <dilinger@queued.net>
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
 W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
 S:	Supported
@@ -10085,7 +10084,6 @@ F:	drivers/staging/media/tegra-vde/
 
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
-P:	LinuxTV.org Project
 L:	linux-media@vger.kernel.org
 W:	https://linuxtv.org
 Q:	http://patchwork.kernel.org/project/linux-media/list/
@@ -13452,7 +13450,6 @@ S:	Maintained
 F:	arch/mips/ralink
 
 RALINK RT2X00 WIRELESS LAN DRIVER
-P:	rt2x00 project
 M:	Stanislaw Gruszka <sgruszka@redhat.com>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
 L:	linux-wireless@vger.kernel.org
@@ -13787,7 +13784,6 @@ S:	Supported
 F:	drivers/net/ethernet/rocker/
 
 ROCKETPORT DRIVER
-P:	Comtrol Corp.
 W:	http://www.comtrol.com
 S:	Maintained
 F:	Documentation/driver-api/serial/rocket.rst
@@ -14668,15 +14664,13 @@ F:	drivers/video/fbdev/simplefb.c
 F:	include/linux/platform_data/simplefb.h
 
 SIMTEC EB110ATX (Chalice CATS)
-P:	Ben Dooks
-P:	Vincent Sanders <vince@simtec.co.uk>
+M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 W:	http://www.simtec.co.uk/products/EB110ATX/
 S:	Supported
 
 SIMTEC EB2410ITX (BAST)
-P:	Ben Dooks
-P:	Vincent Sanders <vince@simtec.co.uk>
+M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 W:	http://www.simtec.co.uk/products/EB2410ITX/
 S:	Supported

