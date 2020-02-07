Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42CB155985
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 15:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBGO3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 09:29:05 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59623 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgBGO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:27:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142756euoutp01969dd412b18a886c30cb9977cd983a14~xJQuoREOA2124721247euoutp011
        for <linux-kernel@vger.kernel.org>; Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142756euoutp01969dd412b18a886c30cb9977cd983a14~xJQuoREOA2124721247euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085676;
        bh=XhnhItCxgDEDsmYqNc+Ns8znHW1JrEOTvP2fj2IHupY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILidTnSgqZc2ZAve7+qFvaTfGxweq3gnSeeW1uy/f9qW6gEMfWgoMo7BFHROqF6Qa
         KFpvM97+ZgCR6SAZJzwKvUSUS2018gSULsrnaU70gy+kZHcn59NVwTsYEDqHldtn4V
         or9+Q3RCDIMKbWccEJIrdN84Uvb+/zjGsH5TeZHc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142755eucas1p1ac9cf31ebd62fbe9d1d4b8e633a03d3e~xJQuJusDj2844428444eucas1p1f;
        Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.4D.60679.BE37D3E5; Fri,  7
        Feb 2020 14:27:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142755eucas1p2a448f8578421c0ac13ff5c47efa8a83f~xJQtqKfKM0410404104eucas1p2e;
        Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142755eusmtrp2a1f27f07e9ddae8b15f3b466d86f7b04~xJQtpjDuk1102911029eusmtrp27;
        Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-72-5e3d73ebad1a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.C5.07950.BE37D3E5; Fri,  7
        Feb 2020 14:27:55 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142754eusmtip209d9bb329f925d581692608a28af1e88~xJQtLE2sR2944029440eusmtip2c;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 08/26] ata: move EXPORT_SYMBOL_GPL()s close to exported
 code
Date:   Fri,  7 Feb 2020 15:27:16 +0100
Message-Id: <20200207142734.8431-9-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzs7GJq9z4ItJ1kIlITXzw6FUGvThQIFF5Icu5ikPztqm
        7ahlQQxEE/FSS/AaXjLnNe/mpkLMnJhmgVAmmqQS6hRLRfDetqPlt9/zPP//+3+fl5fE5A1C
        LzJel8TqdYxGSUjwTtvGyCk7Fx4dPFOqpOon8wiqpbBJSP0a7xVQtfX9AsrWNS2gRi2lBGWa
        bcSoV+kFovMkbS6eFNGjn5Jpa18moAfT13G6+7uBoHPb6wC92nr0sui6JCyW1cSnsPqgiBiJ
        +ktVhyCxZgk8at2JNoAZG8gCJIlgKFrr0mQBCSmHNQBllw/hfLEG0J7FLuSLVYDKCxbwA0da
        owPFjr4JoKkJ33+GqYoS14CAZ9GLZ3XAyQp4DGVv1RJOEQaXAaox9rpEHvAKaujLETkZh75o
        9Webi2UwDC3ONQudjKAP6lhfcbEYhqM/+TsEr3FHg0WzrnMwhyatowRzBiBYLULfPrfhvPkC
        KmsqADx7oIWBdhHP3mjPXCbgDW8B2smc23e/A8j0cpfgVefQxMgm4dwZgydRkyWIb6tQYX8O
        xj+FGxpbcucv4YaMnQX7bRnKzJDzaj/UXN1MHMRmmWv3JTQqnVE9B8eLD21TfGib4v+x5QCr
        A55sMqeNY7kQHfswkGO0XLIuLvBugrYVOP7Q0O7AWhewbN+xAkgCpVQWowqLlguZFC5VawWI
        xJQKWa5veLRcFsukPmb1Cbf1yRqWs4IjJK70lJ2pnL8lh3FMEnufZRNZ/cFUQIq9DMD0EexG
        Gq8x0jcrfj8g+dugiPLPlqZ4W6KsPQ8uBtcH21Qr8+YTpps++Vr/CPXVJjVXtDjAiIumx0KG
        zeMR7pHd4249w3kBoTopbrQn6Ssqtzftl5b9llug4sn7kkH/nD7ThNTzK1yIv1cXs9H8+mnG
        Vn/Vekj1hxumHDJViXNq5nQApueYv2yPFjs/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qvi23jDOb+YrNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkXlmxlKljxlrFi09+4BsbHxxi7GDk4JARMJJrXsnQxcnEICSxllPh+
        qYEVIi4jcXx9WRcjJ5ApLPHnWhcbRM0nRondD56xgyTYBKwkJravYgSxRQQUJHp+rwQrYhb4
        yiixdFI3M0hCWMBfovv+VlYQm0VAVeLzw81gzbwCNhJvXmxghdggL7H12ycwm1PAVuLjlL9s
        ILYQUM3395Og6gUlTs58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OL
        S/PS9ZLzczcxAiNm27GfW3Ywdr0LPsQowMGoxMOb4GgTJ8SaWFZcmXuIUYKDWUmEt0/VNk6I
        NyWxsiq1KD++qDQntfgQoynQExOZpUST84HRnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgdFO6757gu+0vW6i/ueLz73QNsrrbgzY1nSuf35L6r3dPUErwtqF
        pS13F2c7BzwwPz0hgLv/2/bZTUcFZA5dne13Z0HfU7knnXuSea5O13jUzntOf+rJle4SYXHH
        8l1eSLx1aPytbpK60/1+erWGwdEQAfbINWWrmWvyZZ9oP+mRd1yV/YdXXomlOCPRUIu5qDgR
        APZOwo+uAgAA
X-CMS-MailID: 20200207142755eucas1p2a448f8578421c0ac13ff5c47efa8a83f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142755eucas1p2a448f8578421c0ac13ff5c47efa8a83f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142755eucas1p2a448f8578421c0ac13ff5c47efa8a83f
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142755eucas1p2a448f8578421c0ac13ff5c47efa8a83f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move EXPORT_SYMBOL_GPL()s close to exported code like it is
done in other kernel subsystems. As a nice side effect this
results in the removal of few ifdefs.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 206 +++++++++++++++-----------------------
 drivers/ata/libata-eh.c   |  20 +++-
 drivers/ata/libata-scsi.c |   8 ++
 3 files changed, 108 insertions(+), 126 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 47703c8ba0e6..ad724602c47c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -18,6 +18,11 @@
  *	http://www.compactflash.org (CF)
  *	http://www.qic.org (QIC157 - Tape and DSC)
  *	http://www.ce-ata.org (CE-ATA: not supported)
+ *
+ * libata is essentially a library of internal helper functions for
+ * low-level ATA host controller drivers.  As such, the API/ABI is
+ * likely to change as new drivers are added and updated.
+ * Do not depend on ABI/API stability.
  */
 
 #include <linux/kernel.h>
@@ -62,8 +67,11 @@
 
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
 const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 
 const struct ata_port_operations ata_base_port_ops = {
 	.prereset		= ata_std_prereset,
@@ -72,6 +80,7 @@ const struct ata_port_operations ata_base_port_ops = {
 	.sched_eh		= ata_std_sched_eh,
 	.end_eh			= ata_std_end_eh,
 };
+EXPORT_SYMBOL_GPL(ata_base_port_ops);
 
 const struct ata_port_operations sata_port_ops = {
 	.inherits		= &ata_base_port_ops,
@@ -79,6 +88,7 @@ const struct ata_port_operations sata_port_ops = {
 	.qc_defer		= ata_std_qc_defer,
 	.hardreset		= sata_std_hardreset,
 };
+EXPORT_SYMBOL_GPL(sata_port_ops);
 
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
@@ -221,6 +231,7 @@ struct ata_link *ata_link_next(struct ata_link *link, struct ata_port *ap,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(ata_link_next);
 
 /**
  *	ata_dev_next - device iteration helper
@@ -274,6 +285,7 @@ struct ata_device *ata_dev_next(struct ata_device *dev, struct ata_link *link,
 		goto next;
 	return dev;
 }
+EXPORT_SYMBOL_GPL(ata_dev_next);
 
 /**
  *	ata_dev_phys_link - find physical link for a device
@@ -518,6 +530,7 @@ int atapi_cmd_type(u8 opcode)
 		return ATAPI_MISC;
 	}
 }
+EXPORT_SYMBOL_GPL(atapi_cmd_type);
 
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
@@ -562,6 +575,7 @@ void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 	fis[18] = (tf->auxiliary >> 16) & 0xff;
 	fis[19] = (tf->auxiliary >> 24) & 0xff;
 }
+EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 
 /**
  *	ata_tf_from_fis - Convert SATA FIS to ATA taskfile
@@ -591,6 +605,7 @@ void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf)
 	tf->nsect	= fis[12];
 	tf->hob_nsect	= fis[13];
 }
+EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 
 static const u8 ata_rw_cmds[] = {
 	/* pio multi */
@@ -865,6 +880,7 @@ unsigned long ata_pack_xfermask(unsigned long pio_mask,
 		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
 		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
 }
+EXPORT_SYMBOL_GPL(ata_pack_xfermask);
 
 /**
  *	ata_unpack_xfermask - Unpack xfer_mask into pio, mwdma and udma masks
@@ -886,6 +902,7 @@ void ata_unpack_xfermask(unsigned long xfer_mask, unsigned long *pio_mask,
 	if (udma_mask)
 		*udma_mask = (xfer_mask & ATA_MASK_UDMA) >> ATA_SHIFT_UDMA;
 }
+EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
 
 static const struct ata_xfer_ent {
 	int shift, bits;
@@ -920,6 +937,7 @@ u8 ata_xfer_mask2mode(unsigned long xfer_mask)
 			return ent->base + highbit - ent->shift;
 	return 0xff;
 }
+EXPORT_SYMBOL_GPL(ata_xfer_mask2mode);
 
 /**
  *	ata_xfer_mode2mask - Find matching xfer_mask for XFER_*
@@ -943,6 +961,7 @@ unsigned long ata_xfer_mode2mask(u8 xfer_mode)
 				& ~((1 << ent->shift) - 1);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
 
 /**
  *	ata_xfer_mode2shift - Find matching xfer_shift for XFER_*
@@ -965,6 +984,7 @@ int ata_xfer_mode2shift(unsigned long xfer_mode)
 			return ent->shift;
 	return -1;
 }
+EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
 
 /**
  *	ata_mode_string - convert xfer_mask to string
@@ -1011,6 +1031,7 @@ const char *ata_mode_string(unsigned long xfer_mask)
 		return xfer_mode_str[highbit];
 	return "<n/a>";
 }
+EXPORT_SYMBOL_GPL(ata_mode_string);
 
 const char *sata_spd_string(unsigned int spd)
 {
@@ -1091,6 +1112,7 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 	DPRINTK("unknown device\n");
 	return ATA_DEV_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(ata_dev_classify);
 
 /**
  *	ata_id_string - Convert IDENTIFY DEVICE page into string
@@ -1127,6 +1149,7 @@ void ata_id_string(const u16 *id, unsigned char *s,
 		len -= 2;
 	}
 }
+EXPORT_SYMBOL_GPL(ata_id_string);
 
 /**
  *	ata_id_c_string - Convert IDENTIFY DEVICE page into C string
@@ -1154,6 +1177,7 @@ void ata_id_c_string(const u16 *id, unsigned char *s,
 		p--;
 	*p = '\0';
 }
+EXPORT_SYMBOL_GPL(ata_id_c_string);
 
 static u64 ata_id_n_sectors(const u16 *id)
 {
@@ -1511,6 +1535,7 @@ unsigned long ata_id_xfermask(const u16 *id)
 
 	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
+EXPORT_SYMBOL_GPL(ata_id_xfermask);
 
 static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
@@ -1768,6 +1793,7 @@ unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 
 /**
  *	ata_pio_mask_no_iordy	-	Return the non IORDY mask
@@ -1808,6 +1834,7 @@ unsigned int ata_do_dev_read_id(struct ata_device *dev,
 	return ata_exec_internal(dev, tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS, 0);
 }
+EXPORT_SYMBOL_GPL(ata_do_dev_read_id);
 
 /**
  *	ata_dev_read_id - Read ID data from the specified device
@@ -2780,6 +2807,7 @@ int ata_cable_40wire(struct ata_port *ap)
 {
 	return ATA_CBL_PATA40;
 }
+EXPORT_SYMBOL_GPL(ata_cable_40wire);
 
 /**
  *	ata_cable_80wire	-	return 80 wire cable type
@@ -2793,6 +2821,7 @@ int ata_cable_80wire(struct ata_port *ap)
 {
 	return ATA_CBL_PATA80;
 }
+EXPORT_SYMBOL_GPL(ata_cable_80wire);
 
 /**
  *	ata_cable_unknown	-	return unknown PATA cable.
@@ -2805,6 +2834,7 @@ int ata_cable_unknown(struct ata_port *ap)
 {
 	return ATA_CBL_PATA_UNK;
 }
+EXPORT_SYMBOL_GPL(ata_cable_unknown);
 
 /**
  *	ata_cable_ignore	-	return ignored PATA cable.
@@ -2817,6 +2847,7 @@ int ata_cable_ignore(struct ata_port *ap)
 {
 	return ATA_CBL_PATA_IGN;
 }
+EXPORT_SYMBOL_GPL(ata_cable_ignore);
 
 /**
  *	ata_cable_sata	-	return SATA cable type
@@ -2829,6 +2860,7 @@ int ata_cable_sata(struct ata_port *ap)
 {
 	return ATA_CBL_SATA;
 }
+EXPORT_SYMBOL_GPL(ata_cable_sata);
 
 /**
  *	ata_bus_probe - Reset and probe ATA bus
@@ -3011,6 +3043,7 @@ struct ata_device *ata_dev_pair(struct ata_device *adev)
 		return NULL;
 	return pair;
 }
+EXPORT_SYMBOL_GPL(ata_dev_pair);
 
 /**
  *	sata_down_spd_limit - adjust SATA spd limit downward
@@ -3171,6 +3204,7 @@ int sata_set_spd(struct ata_link *link)
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(sata_set_spd);
 
 /*
  * This mode timing computation functionality is ported over from
@@ -3245,6 +3279,7 @@ void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
 	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
 	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
+EXPORT_SYMBOL_GPL(ata_timing_merge);
 
 const struct ata_timing *ata_timing_find_mode(u8 xfer_mode)
 {
@@ -3261,6 +3296,7 @@ const struct ata_timing *ata_timing_find_mode(u8 xfer_mode)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(ata_timing_find_mode);
 
 int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 		       struct ata_timing *t, int T, int UT)
@@ -3337,6 +3373,7 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_timing_compute);
 
 /**
  *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
@@ -3388,6 +3425,7 @@ u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle)
 
 	return last_mode;
 }
+EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
 
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
@@ -3659,6 +3697,7 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 		*r_failed_dev = dev;
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_do_set_mode);
 
 /**
  *	ata_wait_ready - wait for link to become ready
@@ -3768,6 +3807,7 @@ int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 
 	return ata_wait_ready(link, deadline, check_ready);
 }
+EXPORT_SYMBOL_GPL(ata_wait_after_reset);
 
 /**
  *	sata_link_debounce - debounce SATA phy status
@@ -3838,6 +3878,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 			return -EPIPE;
 	}
 }
+EXPORT_SYMBOL_GPL(sata_link_debounce);
 
 /**
  *	sata_link_resume - resume SATA link
@@ -3904,6 +3945,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 
 	return rc != -EINVAL ? rc : 0;
 }
+EXPORT_SYMBOL_GPL(sata_link_resume);
 
 /**
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
@@ -3978,6 +4020,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	ehc->i.serror &= ~SERR_PHYRDY_CHG;
 	return sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
 }
+EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
 
 /**
  *	ata_std_prereset - prepare for reset
@@ -4023,6 +4066,7 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_std_prereset);
 
 /**
  *	sata_link_hardreset - reset link via SATA phy reset
@@ -4135,6 +4179,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(sata_link_hardreset);
 
 /**
  *	sata_std_hardreset - COMRESET w/o waiting or classification
@@ -4161,6 +4206,7 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
 	return online ? -EAGAIN : rc;
 }
+EXPORT_SYMBOL_GPL(sata_std_hardreset);
 
 /**
  *	ata_std_postreset - standard postreset callback
@@ -4189,6 +4235,7 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 
 	DPRINTK("EXIT\n");
 }
+EXPORT_SYMBOL_GPL(ata_std_postreset);
 
 /**
  *	ata_dev_same_device - Determine whether new ID matches configured device
@@ -4976,11 +5023,13 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 
 	return ATA_DEFER_LINK;
 }
+EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 
 enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc)
 {
 	return AC_ERR_OK;
 }
+EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 
 /**
  *	ata_sg_init - Associate command with scatter-gather table.
@@ -5002,6 +5051,7 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 	qc->n_elem = n_elem;
 	qc->cursg = qc->sg;
 }
+EXPORT_SYMBOL_GPL(ata_sg_init);
 
 #ifdef CONFIG_HAS_DMA
 
@@ -5324,6 +5374,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		__ata_qc_complete(qc);
 	}
 }
+EXPORT_SYMBOL_GPL(ata_qc_complete);
 
 /**
  *	ata_qc_get_active - get bitmask of active qcs
@@ -5406,6 +5457,7 @@ int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
 
 	return nr_done;
 }
+EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 
 /**
  *	ata_qc_issue - issue taskfile to device
@@ -5500,6 +5552,7 @@ int sata_scr_valid(struct ata_link *link)
 
 	return (ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read;
 }
+EXPORT_SYMBOL_GPL(sata_scr_valid);
 
 /**
  *	sata_scr_read - read SCR register of the specified port
@@ -5527,6 +5580,7 @@ int sata_scr_read(struct ata_link *link, int reg, u32 *val)
 
 	return sata_pmp_scr_read(link, reg, val);
 }
+EXPORT_SYMBOL_GPL(sata_scr_read);
 
 /**
  *	sata_scr_write - write SCR register of the specified port
@@ -5554,6 +5608,7 @@ int sata_scr_write(struct ata_link *link, int reg, u32 val)
 
 	return sata_pmp_scr_write(link, reg, val);
 }
+EXPORT_SYMBOL_GPL(sata_scr_write);
 
 /**
  *	sata_scr_write_flush - write SCR register of the specified port and flush
@@ -5586,6 +5641,7 @@ int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 
 	return sata_pmp_scr_write(link, reg, val);
 }
+EXPORT_SYMBOL_GPL(sata_scr_write_flush);
 
 /**
  *	ata_phys_link_online - test whether the given link is online
@@ -5660,6 +5716,7 @@ bool ata_link_online(struct ata_link *link)
 	return ata_phys_link_online(link) ||
 		(slave && ata_phys_link_online(slave));
 }
+EXPORT_SYMBOL_GPL(ata_link_online);
 
 /**
  *	ata_link_offline - test whether the given link is offline
@@ -5686,6 +5743,7 @@ bool ata_link_offline(struct ata_link *link)
 	return ata_phys_link_offline(link) &&
 		(!slave || ata_phys_link_offline(slave));
 }
+EXPORT_SYMBOL_GPL(ata_link_offline);
 
 #ifdef CONFIG_PM
 static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
@@ -5872,6 +5930,7 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 	host->dev->power.power_state = mesg;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_host_suspend);
 
 /**
  *	ata_host_resume - resume host
@@ -5883,6 +5942,7 @@ void ata_host_resume(struct ata_host *host)
 {
 	host->dev->power.power_state = PMSG_ON;
 }
+EXPORT_SYMBOL_GPL(ata_host_resume);
 #endif
 
 const struct device_type ata_port_type = {
@@ -6097,11 +6157,13 @@ void ata_host_get(struct ata_host *host)
 {
 	kref_get(&host->kref);
 }
+EXPORT_SYMBOL_GPL(ata_host_get);
 
 void ata_host_put(struct ata_host *host)
 {
 	kref_put(&host->kref, ata_host_release);
 }
+EXPORT_SYMBOL_GPL(ata_host_put);
 
 /**
  *	ata_host_alloc - allocate and init basic ATA host resources
@@ -6175,6 +6237,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	kfree(host);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(ata_host_alloc);
 
 /**
  *	ata_host_alloc_pinfo - alloc host and init with port_info array
@@ -6223,6 +6286,7 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 
 	return host;
 }
+EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
 
 /**
  *	ata_slave_link_init - initialize slave link
@@ -6285,6 +6349,7 @@ int ata_slave_link_init(struct ata_port *ap)
 	ap->slave_link = link;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_slave_link_init);
 
 static void ata_host_stop(struct device *gendev, void *res)
 {
@@ -6433,6 +6498,7 @@ int ata_host_start(struct ata_host *host)
 	devres_free(start_dr);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_host_start);
 
 /**
  *	ata_sas_host_init - Initialize a host struct for sas (ipr, libsas)
@@ -6451,6 +6517,7 @@ void ata_host_init(struct ata_host *host, struct device *dev,
 	host->ops = ops;
 	kref_init(&host->kref);
 }
+EXPORT_SYMBOL_GPL(ata_host_init);
 
 void __ata_port_probe(struct ata_port *ap)
 {
@@ -6606,6 +6673,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	return rc;
 
 }
+EXPORT_SYMBOL_GPL(ata_host_register);
 
 /**
  *	ata_host_activate - start host, request IRQ and register it
@@ -6668,6 +6736,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_host_activate);
 
 /**
  *	ata_port_detach - Detach ATA port in preparation of device removal
@@ -6743,6 +6812,7 @@ void ata_host_detach(struct ata_host *host)
 	/* the host is dead now, dissociate ACPI */
 	ata_acpi_dissociate(host);
 }
+EXPORT_SYMBOL_GPL(ata_host_detach);
 
 #ifdef CONFIG_PCI
 
@@ -6763,6 +6833,7 @@ void ata_pci_remove_one(struct pci_dev *pdev)
 
 	ata_host_detach(host);
 }
+EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 
 /* move to PCI subsystem */
 int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
@@ -6797,6 +6868,7 @@ int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 
 	return (tmp == bits->val) ? 1 : 0;
 }
+EXPORT_SYMBOL_GPL(pci_test_config_bits);
 
 #ifdef CONFIG_PM
 void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
@@ -6807,6 +6879,7 @@ void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	if (mesg.event & PM_EVENT_SLEEP)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 
 int ata_pci_device_do_resume(struct pci_dev *pdev)
 {
@@ -6825,6 +6898,7 @@ int ata_pci_device_do_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
@@ -6839,6 +6913,7 @@ int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
@@ -6850,8 +6925,8 @@ int ata_pci_device_resume(struct pci_dev *pdev)
 		ata_host_resume(host);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PM */
-
 #endif /* CONFIG_PCI */
 
 /**
@@ -6873,6 +6948,7 @@ int ata_platform_remove_one(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
@@ -7097,6 +7173,7 @@ int ata_ratelimit(void)
 {
 	return __ratelimit(&ratelimit);
 }
+EXPORT_SYMBOL_GPL(ata_ratelimit);
 
 /**
  *	ata_msleep - ATA EH owner aware msleep
@@ -7129,6 +7206,7 @@ void ata_msleep(struct ata_port *ap, unsigned int msecs)
 	if (owns_eh)
 		ata_eh_acquire(ap);
 }
+EXPORT_SYMBOL_GPL(ata_msleep);
 
 /**
  *	ata_wait_register - wait until register value changes
@@ -7175,6 +7253,7 @@ u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
 
 	return tmp;
 }
+EXPORT_SYMBOL_GPL(ata_wait_register);
 
 /**
  *	sata_lpm_ignore_phy_events - test if PHY event should be ignored
@@ -7228,10 +7307,12 @@ struct ata_port_operations ata_dummy_port_ops = {
 	.sched_eh		= ata_std_sched_eh,
 	.end_eh			= ata_std_end_eh,
 };
+EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 
 const struct ata_port_info ata_dummy_port_info = {
 	.port_ops		= &ata_dummy_port_ops,
 };
+EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 
 /*
  * Utility print functions
@@ -7299,126 +7380,3 @@ void ata_print_version(const struct device *dev, const char *version)
 	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
 }
 EXPORT_SYMBOL(ata_print_version);
-
-/*
- * libata is essentially a library of internal helper functions for
- * low-level ATA host controller drivers.  As such, the API/ABI is
- * likely to change as new drivers are added and updated.
- * Do not depend on ABI/API stability.
- */
-EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
-EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
-EXPORT_SYMBOL_GPL(sata_deb_timing_long);
-EXPORT_SYMBOL_GPL(ata_base_port_ops);
-EXPORT_SYMBOL_GPL(sata_port_ops);
-EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
-EXPORT_SYMBOL_GPL(ata_dummy_port_info);
-EXPORT_SYMBOL_GPL(ata_link_next);
-EXPORT_SYMBOL_GPL(ata_dev_next);
-EXPORT_SYMBOL_GPL(ata_std_bios_param);
-EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
-EXPORT_SYMBOL_GPL(ata_host_init);
-EXPORT_SYMBOL_GPL(ata_host_alloc);
-EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
-EXPORT_SYMBOL_GPL(ata_slave_link_init);
-EXPORT_SYMBOL_GPL(ata_host_start);
-EXPORT_SYMBOL_GPL(ata_host_register);
-EXPORT_SYMBOL_GPL(ata_host_activate);
-EXPORT_SYMBOL_GPL(ata_host_detach);
-EXPORT_SYMBOL_GPL(ata_sg_init);
-EXPORT_SYMBOL_GPL(ata_qc_complete);
-EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
-EXPORT_SYMBOL_GPL(atapi_cmd_type);
-EXPORT_SYMBOL_GPL(ata_tf_to_fis);
-EXPORT_SYMBOL_GPL(ata_tf_from_fis);
-EXPORT_SYMBOL_GPL(ata_pack_xfermask);
-EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
-EXPORT_SYMBOL_GPL(ata_xfer_mask2mode);
-EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
-EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
-EXPORT_SYMBOL_GPL(ata_mode_string);
-EXPORT_SYMBOL_GPL(ata_id_xfermask);
-EXPORT_SYMBOL_GPL(ata_do_set_mode);
-EXPORT_SYMBOL_GPL(ata_std_qc_defer);
-EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
-EXPORT_SYMBOL_GPL(ata_dev_disable);
-EXPORT_SYMBOL_GPL(sata_set_spd);
-EXPORT_SYMBOL_GPL(ata_wait_after_reset);
-EXPORT_SYMBOL_GPL(sata_link_debounce);
-EXPORT_SYMBOL_GPL(sata_link_resume);
-EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
-EXPORT_SYMBOL_GPL(ata_std_prereset);
-EXPORT_SYMBOL_GPL(sata_link_hardreset);
-EXPORT_SYMBOL_GPL(sata_std_hardreset);
-EXPORT_SYMBOL_GPL(ata_std_postreset);
-EXPORT_SYMBOL_GPL(ata_dev_classify);
-EXPORT_SYMBOL_GPL(ata_dev_pair);
-EXPORT_SYMBOL_GPL(ata_ratelimit);
-EXPORT_SYMBOL_GPL(ata_msleep);
-EXPORT_SYMBOL_GPL(ata_wait_register);
-EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
-EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
-EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
-EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
-EXPORT_SYMBOL_GPL(sata_scr_valid);
-EXPORT_SYMBOL_GPL(sata_scr_read);
-EXPORT_SYMBOL_GPL(sata_scr_write);
-EXPORT_SYMBOL_GPL(sata_scr_write_flush);
-EXPORT_SYMBOL_GPL(ata_link_online);
-EXPORT_SYMBOL_GPL(ata_link_offline);
-#ifdef CONFIG_PM
-EXPORT_SYMBOL_GPL(ata_host_suspend);
-EXPORT_SYMBOL_GPL(ata_host_resume);
-#endif /* CONFIG_PM */
-EXPORT_SYMBOL_GPL(ata_id_string);
-EXPORT_SYMBOL_GPL(ata_id_c_string);
-EXPORT_SYMBOL_GPL(ata_do_dev_read_id);
-EXPORT_SYMBOL_GPL(ata_scsi_simulate);
-
-EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
-EXPORT_SYMBOL_GPL(ata_timing_find_mode);
-EXPORT_SYMBOL_GPL(ata_timing_compute);
-EXPORT_SYMBOL_GPL(ata_timing_merge);
-EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
-
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_remove_one);
-#ifdef CONFIG_PM
-EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
-EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
-EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
-EXPORT_SYMBOL_GPL(ata_pci_device_resume);
-#endif /* CONFIG_PM */
-#endif /* CONFIG_PCI */
-
-EXPORT_SYMBOL_GPL(ata_platform_remove_one);
-
-EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
-EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
-EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
-EXPORT_SYMBOL_GPL(ata_port_desc);
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL_GPL(ata_port_pbar_desc);
-#endif /* CONFIG_PCI */
-EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
-EXPORT_SYMBOL_GPL(ata_link_abort);
-EXPORT_SYMBOL_GPL(ata_port_abort);
-EXPORT_SYMBOL_GPL(ata_port_freeze);
-EXPORT_SYMBOL_GPL(sata_async_notification);
-EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
-EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
-EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
-EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
-EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
-EXPORT_SYMBOL_GPL(ata_do_eh);
-EXPORT_SYMBOL_GPL(ata_std_error_handler);
-
-EXPORT_SYMBOL_GPL(ata_cable_40wire);
-EXPORT_SYMBOL_GPL(ata_cable_80wire);
-EXPORT_SYMBOL_GPL(ata_cable_unknown);
-EXPORT_SYMBOL_GPL(ata_cable_ignore);
-EXPORT_SYMBOL_GPL(ata_cable_sata);
-EXPORT_SYMBOL_GPL(ata_host_get);
-EXPORT_SYMBOL_GPL(ata_host_put);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 53605c8949d8..1d231cfab26f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -180,6 +180,7 @@ void __ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
 	__ata_ehi_pushv_desc(ehi, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 
 /**
  *	ata_ehi_push_desc - push error description with separator
@@ -203,6 +204,7 @@ void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
 	__ata_ehi_pushv_desc(ehi, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
 
 /**
  *	ata_ehi_clear_desc - clean error description
@@ -218,6 +220,7 @@ void ata_ehi_clear_desc(struct ata_eh_info *ehi)
 	ehi->desc[0] = '\0';
 	ehi->desc_len = 0;
 }
+EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
 
 /**
  *	ata_port_desc - append port description
@@ -245,9 +248,9 @@ void ata_port_desc(struct ata_port *ap, const char *fmt, ...)
 	__ata_ehi_pushv_desc(&ap->link.eh_info, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(ata_port_desc);
 
 #ifdef CONFIG_PCI
-
 /**
  *	ata_port_pbar_desc - append PCI BAR description
  *	@ap: target ATA port
@@ -284,7 +287,7 @@ void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 		ata_port_desc(ap, "%s 0x%llx", name,
 				start + (unsigned long long)offset);
 }
-
+EXPORT_SYMBOL_GPL(ata_port_pbar_desc);
 #endif /* CONFIG_PCI */
 
 static int ata_lookup_timeout_table(u8 cmd)
@@ -969,6 +972,7 @@ void ata_port_schedule_eh(struct ata_port *ap)
 	/* see: ata_std_sched_eh, unless you know better */
 	ap->ops->sched_eh(ap);
 }
+EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 
 static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 {
@@ -1011,6 +1015,7 @@ int ata_link_abort(struct ata_link *link)
 {
 	return ata_do_link_abort(link->ap, link);
 }
+EXPORT_SYMBOL_GPL(ata_link_abort);
 
 /**
  *	ata_port_abort - abort all qc's on the port
@@ -1028,6 +1033,7 @@ int ata_port_abort(struct ata_port *ap)
 {
 	return ata_do_link_abort(ap, NULL);
 }
+EXPORT_SYMBOL_GPL(ata_port_abort);
 
 /**
  *	__ata_port_freeze - freeze port
@@ -1084,6 +1090,7 @@ int ata_port_freeze(struct ata_port *ap)
 
 	return nr_aborted;
 }
+EXPORT_SYMBOL_GPL(ata_port_freeze);
 
 /**
  *	sata_async_notification - SATA async notification handler
@@ -1157,6 +1164,7 @@ int sata_async_notification(struct ata_port *ap)
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(sata_async_notification);
 
 /**
  *	ata_eh_freeze_port - EH helper to freeze port
@@ -1178,6 +1186,7 @@ void ata_eh_freeze_port(struct ata_port *ap)
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 
 /**
  *	ata_port_thaw_port - EH helper to thaw port
@@ -1206,6 +1215,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	DPRINTK("ata%u port thawed\n", ap->print_id);
 }
+EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
@@ -1240,6 +1250,7 @@ void ata_eh_qc_complete(struct ata_queued_cmd *qc)
 	scmd->retries = scmd->allowed;
 	__ata_eh_qc_complete(qc);
 }
+EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 
 /**
  *	ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
@@ -1259,6 +1270,7 @@ void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 		scmd->allowed++;
 	__ata_eh_qc_complete(qc);
 }
+EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 /**
  *	ata_dev_disable - disable ATA device
@@ -1285,6 +1297,7 @@ void ata_dev_disable(struct ata_device *dev)
 	 */
 	ata_ering_clear(&dev->ering);
 }
+EXPORT_SYMBOL_GPL(ata_dev_disable);
 
 /**
  *	ata_eh_detach_dev - detach ATA device
@@ -1727,6 +1740,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
+EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
 
 /**
  *	ata_eh_analyze_tf - analyze taskfile of a failed qc
@@ -4027,6 +4041,7 @@ void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 	ata_eh_finish(ap);
 }
+EXPORT_SYMBOL_GPL(ata_do_eh);
 
 /**
  *	ata_std_error_handler - standard error handler
@@ -4048,6 +4063,7 @@ void ata_std_error_handler(struct ata_port *ap)
 
 	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
 }
+EXPORT_SYMBOL_GPL(ata_std_error_handler);
 
 #ifdef CONFIG_PM
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cc8ba49275e7..321b5a1d610a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -501,6 +501,7 @@ int ata_std_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_std_bios_param);
 
 /**
  *	ata_scsi_unlock_native_capacity - unlock native capacity
@@ -530,6 +531,7 @@ void ata_scsi_unlock_native_capacity(struct scsi_device *sdev)
 	spin_unlock_irqrestore(ap->lock, flags);
 	ata_port_wait_eh(ap);
 }
+EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
 
 /**
  *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
@@ -1346,6 +1348,7 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 
 /**
  *	ata_scsi_slave_destroy - SCSI device is about to be destroyed
@@ -1385,6 +1388,7 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 	q->dma_drain_buffer = NULL;
 	q->dma_drain_size = 0;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 
 /**
  *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
@@ -1428,6 +1432,7 @@ int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
 
 	return scsi_change_queue_depth(sdev, queue_depth);
 }
+EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
 
 /**
  *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
@@ -1450,6 +1455,7 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 
 	return __ata_change_queue_depth(ap, sdev, queue_depth);
 }
+EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
@@ -4405,6 +4411,7 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
@@ -4528,6 +4535,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 
 	cmd->scsi_done(cmd);
 }
+EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 {
-- 
2.24.1

