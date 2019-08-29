Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD4A2AED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 01:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfH2XdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 19:33:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:19536 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfH2XdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:33:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 16:33:19 -0700
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="175427416"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 16:33:19 -0700
Subject: [PATCH v2] libata/ahci: Drop PCS quirk for Denverton and beyond
From:   Dan Williams <dan.j.williams@intel.com>
To:     axboe@kernel.dk
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Aug 2019 16:19:02 -0700
Message-ID: <156712072444.1601704.7392596435870876837.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux ahci driver has historically implemented a configuration fixup
for platforms / platform-firmware that fails to enable the ports prior
to OS hand-off at boot. The fixup was originally implemented way back
before ahci moved from drivers/scsi/ to drivers/ata/, and was updated in
2007 via commit 49f290903935 "ahci: update PCS programming". The quirk
sets a port-enable bitmap in the PCS register at offset 0x92.

This quirk could be applied generically up until the arrival of the
Denverton (DNV) platform. The DNV AHCI controller architecture supports
more than 6 ports and along with that the PCS register location and
format were updated to allow for more possible ports in the bitmap. DNV
AHCI expands the register to 32-bits and moves it to offset 0x94.

As it stands there are no known problem reports with existing Linux
trying to set bits at offset 0x92 which indicates that the quirk is not
applicable. Likely it is not applicable on a wider range of platforms,
but it is difficult to discern which platforms if any still depend on
the quirk.

Rather than try to fix the PCS quirk to consider the DNV register layout
instead require explicit opt-in. The assumption is that the OS driver
need not touch this register, and platforms can be added with a new
boad_ahci_pcs7 board-id when / if problematic platforms are found in the
future. The logic in ahci_intel_pcs_quirk() looks for all Intel AHCI
instances with "legacy" board-ids and otherwise skips the quirk if the
board was matched by class-code.

Reported-by: Stephen Douthit <stephend@silicom-usa.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1 [1]:
- Find a way to not duplicate a large portion of the ahci_pci_tbl[]
  array (Stephen).
- Add a definition for the PCS register offset rather than hard code
  (Stephen)

[1]: https://lore.kernel.org/r/a04c0ae7-ef4d-4275-de05-b74beaeef86c@silicom-usa.com/

 drivers/ata/ahci.c |   70 ++++++++++++++++++++++++++++++++--------------------
 drivers/ata/ahci.h |    2 +
 2 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f7652baa6337..847e3796d505 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -65,6 +65,12 @@ enum board_ids {
 	board_ahci_sb700,	/* for SB700 and SB800 */
 	board_ahci_vt8251,
 
+	/*
+	 * board IDs for Intel chipsets that support more than 6 ports
+	 * *and* end up needing the PCS quirk.
+	 */
+	board_ahci_pcs7,
+
 	/* aliases */
 	board_ahci_mcp_linux	= board_ahci_mcp65,
 	board_ahci_mcp67	= board_ahci_mcp65,
@@ -623,30 +629,6 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 	ahci_save_initial_config(&pdev->dev, hpriv);
 }
 
-static int ahci_pci_reset_controller(struct ata_host *host)
-{
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	int rc;
-
-	rc = ahci_reset_controller(host);
-	if (rc)
-		return rc;
-
-	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
-		struct ahci_host_priv *hpriv = host->private_data;
-		u16 tmp16;
-
-		/* configure PCS */
-		pci_read_config_word(pdev, 0x92, &tmp16);
-		if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
-			tmp16 |= hpriv->port_map;
-			pci_write_config_word(pdev, 0x92, tmp16);
-		}
-	}
-
-	return 0;
-}
-
 static void ahci_pci_init_controller(struct ata_host *host)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
@@ -849,7 +831,7 @@ static int ahci_pci_device_runtime_resume(struct device *dev)
 	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
-	rc = ahci_pci_reset_controller(host);
+	rc = ahci_reset_controller(host);
 	if (rc)
 		return rc;
 	ahci_pci_init_controller(host);
@@ -884,7 +866,7 @@ static int ahci_pci_device_resume(struct device *dev)
 		ahci_mcp89_apple_enable(pdev);
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_pci_reset_controller(host);
+		rc = ahci_reset_controller(host);
 		if (rc)
 			return rc;
 
@@ -1619,6 +1601,34 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 		ap->target_lpm_policy = policy;
 }
 
+static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv)
+{
+	const struct pci_device_id *id = pci_match_id(ahci_pci_tbl, pdev);
+	u16 tmp16;
+
+	/*
+	 * Only apply the 6-port PCS quirk for known legacy platforms.
+	 */
+	if (!id || id->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+	if (((enum board_ids) id->driver_data) < board_ahci_pcs7)
+		return;
+
+	/*
+	 * port_map is determined from PORTS_IMPL PCI register which is
+	 * implemented as write or write-once register.  If the register
+	 * isn't programmed, ahci automatically generates it from number
+	 * of ports, which is good enough for PCS programming. It is
+	 * otherwise expected that platform firmware enables the ports
+	 * before the OS boots.
+	 */
+	pci_read_config_word(pdev, PCS_6, &tmp16);
+	if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
+		tmp16 |= hpriv->port_map;
+		pci_write_config_word(pdev, PCS_6, tmp16);
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1731,6 +1741,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* save initial config */
 	ahci_pci_save_initial_config(pdev, hpriv);
 
+	/*
+	 * If platform firmware failed to enable ports, try to enable
+	 * them here.
+	 */
+	ahci_intel_pcs_quirk(pdev, hpriv);
+
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ) {
 		pi.flags |= ATA_FLAG_NCQ;
@@ -1840,7 +1856,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = ahci_pci_reset_controller(host);
+	rc = ahci_reset_controller(host);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0570629d719d..3dbf398c92ea 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -247,6 +247,8 @@ enum {
 					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN,
 
 	ICH_MAP				= 0x90, /* ICH MAP register */
+	PCS_6				= 0x92, /* 6 port PCS */
+	PCS_7				= 0x94, /* 7+ port PCS (Denverton) */
 
 	/* em constants */
 	EM_MAX_SLOTS			= 8,

