Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313E24D4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfFTRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:23:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFTRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C0W3exYft1KrUqFyOJUCPkgo7W6ZH/A+goYD/OL6mwQ=; b=MHaJ1AAp1KTaghNr6IhcV1l7jW
        XJzUHpIStnpHouqWDla9WQd7GjexetPRqCWlOxLQYce5t2OlojC8B/4TTARwb7E9CHfrFQ2i1Wc5F
        ZahE+rgwD7d2VwangNt/YzEVoDLay/EgFC+AIObP6e/IXtwSpFStTzYjYYdiVtfXuFeQtATxsQt6t
        JSkKDmmI59J89xM1b+bkzWTt9QygIOVMARoa6X2lNqCd5PZcSIDe3PRNtgzCRukhPbv+U13SlrOdf
        k9ws3MxA5EeLIeGojhD0GI27YbJL+aB5dJ6PUJgI10zbb3Aj8T42w0FP6M9tjJSIg9FCeC4a7e/Ur
        RuHDtZsw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mL-0008Rm-QN; Thu, 20 Jun 2019 17:23:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Cf-HE; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>
Subject: [PATCH v2 01/22] ABI: sysfs-bus-pci-devices-aer_stats uses an invalid tag
Date:   Thu, 20 Jun 2019 14:22:53 -0300
Message-Id: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According with Documentation/ABI/, the right tag to describe
an ABI symbol is "What:", and not "Where:".

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../ABI/testing/sysfs-bus-pci-devices-aer_stats      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 4b0318c99507..ff229d71961c 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner and not the
 problematic endpoint itself (which may report all counters as 0 as it never
 saw any problems).
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
+What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -31,7 +31,7 @@ Header Log Overflow 0
 TOTAL_ERR_COR 2
 -------------------------------------------------------------------------
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
+What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -62,7 +62,7 @@ TLP Prefix Blocked Error 0
 TOTAL_ERR_FATAL 0
 -------------------------------------------------------------------------
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -103,19 +103,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-Where:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-- 
2.21.0

