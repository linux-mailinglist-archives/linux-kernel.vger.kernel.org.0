Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2A81943BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgCZP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:59:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58866 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgCZP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:58:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155850euoutp017ab5126b3c8ea1765fed9d23c37eda60~-5dy60-_83032230322euoutp01K
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:58:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155850euoutp017ab5126b3c8ea1765fed9d23c37eda60~-5dy60-_83032230322euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238330;
        bh=vGtux1WiegvO/UUDLPVSnOePgjBue0cxSOaZFFwOA0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jauiz6NlE5IR7sJYw+1Rq0RB4O0yJJPaikrX4+Sx+yZyB3f4CIbkB9syZZkSTmATz
         eXKLMIJJnj2/jSjgLwtWsf2Fz4948nR91sBOt4bUR0zTFVt/a6Q0kX+bOfh8O6izGW
         oDtViTk7W6fzG0fF6ywNvcbHQi1B8IHmEFXdZD4M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155849eucas1p2ece3135eb66cc4632dd1a82d474cc4f7~-5dyiTSy23015130151eucas1p27;
        Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.E9.60679.931DC7E5; Thu, 26
        Mar 2020 15:58:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155849eucas1p2c1c0d059d5474597bd1eec3a6855ed8a~-5dySLE_O2254022540eucas1p2K;
        Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155849eusmtrp10d0ffdf0d8922e481d392a5f3596e67b~-5dyRlS8j2091520915eusmtrp1c;
        Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-e0-5e7cd1396012
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.DA.07950.931DC7E5; Thu, 26
        Mar 2020 15:58:49 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155848eusmtip16cabfd6934476f0488c53c84ec50c54f~-5dx49A821572015720eusmtip1a;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 27/27] ata: make "libata.force" kernel parameter optional
Date:   Thu, 26 Mar 2020 16:58:22 +0100
Message-Id: <20200326155822.19400-28-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87qWF2viDNacVrVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlLv71gLTinVjGtfTVrA+NN+S5GTg4J
        AROJoxuvsYHYQgIrGCWWP2eGsL8wSlyfEdDFyAVkf2aUOL7tHiNMw9Sz1xghEssZJWZMmsAE
        4QB1tC75CNbOJmAlMbF9FViHiICCRM/vlWwgRcwC7xklVkzaywKSEBbwkXi47BfYbhYBVYmn
        q2eCNfAK2Encu7GIDWKdvMTWb59YQWxOoPjydfOZIWoEJU7OfAI2hxmopnnrbGaQBRICq9gl
        7rfdZododpG48OY+C4QtLPHq+BaouIzE6ck9LBAN6xgl/na8gOreDgyByf+gVltL3DkHch4H
        0ApNifW79CHCjhKzPj9mAglLCPBJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMl
        M4TtITFn0322CYyKs5C8MwvJO7MQ9i5gZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kR
        mIhO/zv+ZQfjrj9JhxgFOBiVeHg1WmrihFgTy4orcw8xSnAwK4nwPo0ECvGmJFZWpRblxxeV
        5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cBY25Xenv0m/xezf2pGmtn0QKMK
        zuNhDx49ZY+ZZeXT6NBW3yf0yV2f6cDPfZz1Cz97zl0cuLBowsyPDvVaZ77/7S02m5C4ZXNz
        /6k3Vtzz2KvSGI7MlQh4saSzpnLW+9i+FNlOvsRfzYfMNKYnGv6fPiNIyz5w+ubEjrQKjSuX
        LPZvVsn4UK3EUpyRaKjFXFScCABDtMsOQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qWF2viDKauELZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlLv71gLTinVjGtfTVrA+NN+S5GTg4JAROJqWevMXYxcnEICSxllHi9
        4QtTFyMHUEJG4vj6MogaYYk/17rYIGo+MUo87GthBkmwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRusCJhAR+Jh8t+sYHYLAKqEk9XzwRr4BWwk7h3YxEbxAZ5ia3fPrGC2JxA8eXr5oP1
        CgnYSiz+8oEJol5Q4uTMJywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3
        uDQvXS85P3cTIzBith37uWUHY9e74EOMAhyMSjy8Gi01cUKsiWXFlbmHGCU4mJVEeJ9GAoV4
        UxIrq1KL8uOLSnNSiw8xmgI9MZFZSjQ5HxjNeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNIT
        S1KzU1MLUotg+pg4OKUaGFcIF/8Of3L60Lcdi2ReT7FS0D/g+CCcJfnxohMfJzNHyd1Snf1Y
        KzWRqfbzmnq/Csf2LjYny2ULjS+tqZ968etmPaeiilsS5zf5V+s5P9u8aGHJhlN2aV9m/Tlv
        kflnpeDBuaYpba842i/rbL7NmHLQ2nu15NSIBTczn3RxL+D5dUtqb/mlrEtKLMUZiYZazEXF
        iQA73+eGrgIAAA==
X-CMS-MailID: 20200326155849eucas1p2c1c0d059d5474597bd1eec3a6855ed8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155849eucas1p2c1c0d059d5474597bd1eec3a6855ed8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155849eucas1p2c1c0d059d5474597bd1eec3a6855ed8a
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155849eucas1p2c1c0d059d5474597bd1eec3a6855ed8a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ATA_FORCE config option (visible only if EXPERT config
option is enabled) and make "libata.force" kernel parameter
optional.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
w/ CONFIG_ATA_FORCE=y:
  31983     572      40   32595    7f53 drivers/ata/libata-core.o
w/ CONFIG_ATA_FROCE=n:
  28958     316      32   29306    727a drivers/ata/libata-core.o

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig       | 16 ++++++++++++++++
 drivers/ata/libata-core.c | 22 ++++++++++++++++++++--
 drivers/ata/libata.h      |  4 ++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5b55ebf56b5a..05ecdce1b702 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -51,6 +51,22 @@ config ATA_VERBOSE_ERROR
 
 	  If unsure, say Y.
 
+config ATA_FORCE
+	bool "\"libata.force=\" kernel parameter support" if EXPERT
+	default y
+	help
+	  This option adds support for "libata.force=" kernel parameter for
+	  forcing configuration settings.
+
+	  For further information, please read
+	  <file:Documentation/admin-guide/kernel-parameters.txt>.
+
+	  This option will enlarge the kernel by approx. 3KB. Disable it if
+	  kernel size is more important than ability to override the default
+	  configuration settings.
+
+	  If unsure, say Y.
+
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 20c22dbc1f24..beca5f91bb4c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -89,6 +89,7 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 atomic_t ata_print_id = ATOMIC_INIT(0);
 
+#ifdef CONFIG_ATA_FORCE
 struct ata_force_param {
 	const char	*name;
 	u8		cbl;
@@ -112,6 +113,7 @@ static char ata_force_param_buf[COMMAND_LINE_SIZE] __initdata;
 /* param_buf is thrown away after initialization, disallow read */
 module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0);
 MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link speed and transfer mode (see Documentation/admin-guide/kernel-parameters.rst for details)");
+#endif
 
 static int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
@@ -303,6 +305,7 @@ struct ata_link *ata_dev_phys_link(struct ata_device *dev)
 	return ap->slave_link;
 }
 
+#ifdef CONFIG_ATA_FORCE
 /**
  *	ata_force_cbl - force cable type according to libata.force
  *	@ap: ATA port of interest
@@ -483,6 +486,11 @@ static void ata_force_horkage(struct ata_device *dev)
 			       fe->param.name);
 	}
 }
+#else
+static inline void ata_force_link_limits(struct ata_link *link) { }
+static inline void ata_force_xfermask(struct ata_device *dev) { }
+static inline void ata_force_horkage(struct ata_device *dev) { }
+#endif
 
 /**
  *	atapi_cmd_type - Determine ATAPI command type from SCSI opcode
@@ -6080,6 +6088,7 @@ int ata_platform_remove_one(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 
+#ifdef CONFIG_ATA_FORCE
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
 				      const char **reason)
@@ -6259,6 +6268,15 @@ static void __init ata_parse_force_param(void)
 	ata_force_tbl_size = idx;
 }
 
+static void ata_free_force_param(void)
+{
+	kfree(ata_force_tbl);
+}
+#else
+static inline void ata_parse_force_param(void) { }
+static inline void ata_free_force_param(void) { }
+#endif
+
 static int __init ata_init(void)
 {
 	int rc;
@@ -6267,7 +6285,7 @@ static int __init ata_init(void)
 
 	rc = ata_sff_init();
 	if (rc) {
-		kfree(ata_force_tbl);
+		ata_free_force_param();
 		return rc;
 	}
 
@@ -6291,7 +6309,7 @@ static void __exit ata_exit(void)
 	ata_release_transport(ata_scsi_transport_template);
 	libata_transport_exit();
 	ata_sff_exit();
-	kfree(ata_force_tbl);
+	ata_free_force_param();
 }
 
 subsys_initcall(ata_init);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 6c808cf39135..68cdd81d747c 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -37,7 +37,11 @@ extern int libata_noacpi;
 extern int libata_allow_tpm;
 extern const struct device_type ata_port_type;
 extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
+#ifdef CONFIG_ATA_FORCE
 extern void ata_force_cbl(struct ata_port *ap);
+#else
+static inline void ata_force_cbl(struct ata_port *ap) { }
+#endif
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
-- 
2.24.1

