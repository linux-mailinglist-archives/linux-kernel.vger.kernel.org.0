Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA014B51E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 14:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA1NeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 08:34:14 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58869 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1NeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:34:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133411euoutp01110d3c70792ebc7a1517a9b426e26805~uEE9Dzo_i0195601956euoutp01A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133411euoutp01110d3c70792ebc7a1517a9b426e26805~uEE9Dzo_i0195601956euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218451;
        bh=fQRPpY/j6R22KpyWirOw9I+9JR4nX2LGrBjD+UV1aaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oh+z9LWdlggJNC5uVxQMxN7xO0730nIM+ohFTJP1tf0Xu0PQjy89FgUyu1rUBmlnp
         JjHhRqVPNG451fkrzkKTKswgLPu/Hkh08u3Co79hySzXFwE1MF0oW75y8su+NvMQTF
         WGF/c2umK5WPRiWVPOD8HLlrxZBtOAaHSl4+Zg/Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133411eucas1p172fca709f85ccf515477a53ed483effc~uEE832lXW1586715867eucas1p1B;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4E.4A.60679.358303E5; Tue, 28
        Jan 2020 13:34:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133411eucas1p2db496c50fea321b621b1a07b4b8a8cc2~uEE8gECm51390313903eucas1p2w;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133411eusmtrp205895dffee8bd31b612f12f0979d677f~uEE8fiGqa0330003300eusmtrp2o;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-3c-5e303853fc83
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.82.08375.358303E5; Tue, 28
        Jan 2020 13:34:11 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133410eusmtip21f35e33ca5b9f1a849cce97583c15484~uEE8Hr_Lv0657406574eusmtip2Z;
        Tue, 28 Jan 2020 13:34:10 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 02/28] ata: expose ncq_enable_prio sysfs attribute only on
 NCQ capable hosts
Date:   Tue, 28 Jan 2020 14:33:17 +0100
Message-Id: <20200128133343.29905-3-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87rBFgZxBk8uqFusvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK6N95WKWgh/8FS9mzGVpYDzE28XIySEhYCKxfN4iti5GLg4hgRWMEqc3zmEG
        SQgJfGGUePY3ByLxmVFi0boZjF2MHGAdmy76QMSXM0rcvnWRFcIBarh7dyIjSDebgJXExPZV
        YLaIgIJEz++VYCuYBdYwSqw63ASWEBaIk+j6PAnMZhFQlfj/9hWYzStgK3Hh6FdWiPvkJbZ+
        +8QKsplTwE6iZ685RImgxMmZT1hAbGagkuats5lB5ksItLNLfGn6xwLR6yKx68p0ZghbWOLV
        8S3sELaMxP+d85kgGtYxSvzteAHVvZ1RYvnkf2wQVdYSd879YgPZzCygKbF+lz5E2FGiad1m
        JkhQ8EnceCsIcQSfxKRtILtAwrwSHW1CENVqEhuWbWCDWdu1cyXUOR4SD9deY53AqDgLyTuz
        kLwzC2HvAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHp5fS/4192MO76k3SIUYCD
        UYmHd4aKQZwQa2JZcWXuIUYJDmYlEd5OJqAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OF
        BNITS1KzU1MLUotgskwcnFINjLO3rApsc2OdKt5+rZH7xucl59czWxuYS6hlrV/kcfvGswvy
        LjUTG1vUtBRuKH91yK/0jJGOSeuN8/R89Uxl+a7ln3TOTLpX+3EXl/U3tj8db9me1+7vmcF9
        /9+pG5NmC1jcP8+b75rLsfbdQZNj10U+Vp7t0tbN/O3XGfoo9v7i+XpfU9XMI5VYijMSDbWY
        i4oTAZAZU8crAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4Pd1gC4M4gydt3Bar7/azWWycsZ7V
        4tmtvUwWx3Y8YrK4vGsOm8Xc1unsDmweO2fdZfe4fLbU49DhDkaPvi2rGD0+b5ILYI3SsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy2hfuZil4Ad/
        xYsZc1kaGA/xdjFycEgImEhsuujTxcjJISSwlFFi/bFEiLCMxPH1ZSBhCQFhiT/Xuti6GLmA
        Sj4xSsz92sQIkmATsJKY2L4KzBYRUJDo+b0SrIhZYAOjxKubX1hABgkLxEgs+5ALUsMioCrx
        /+0rsHpeAVuJC0e/skIskJfY+u0TK0g5p4CdRM9ec4hzbCXWn3nKClEuKHFy5hMWEJsZqLx5
        62zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYAduO/dy8g/HSxuBD
        jAIcjEo8vDNUDOKEWBPLiitzDzFKcDArifB2MgGFeFMSK6tSi/Lji0pzUosPMZoC/TCRWUo0
        OR8YnXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhh1ljhe8+QM
        eWfLmV42xzORX8lrnsnM9RO/XTvWwu4X/6S0PiZngXj88mXr9+wPnbq7eP0lQWbVxYfNQna4
        fpvkPcv4ZJPN78c3bgXt2hNp6XxifudVto9l+9eeXfp202yVzTnPlS1TUjPW6Xttf9v6SvXz
        jzsKE7e92abU8DZFt1BhNveyygxlJZbijERDLeai4kQAIWuzA5YCAAA=
X-CMS-MailID: 20200128133411eucas1p2db496c50fea321b621b1a07b4b8a8cc2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133411eucas1p2db496c50fea321b621b1a07b4b8a8cc2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133411eucas1p2db496c50fea321b621b1a07b4b8a8cc2
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133411eucas1p2db496c50fea321b621b1a07b4b8a8cc2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in exposing ncq_enable_prio sysfs attribute for
devices on PATA and non-NCQ capable SATA hosts so:

* remove dev_attr_ncq_prio_enable from ata_common_sdev_attrs[]

* add ata_ncq_sdev_attrs[]

* update ATA_NCQ_SHT() macro to use ata_ncq_sdev_attrs[]

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-scsi.c | 8 +++++++-
 include/linux/libata.h    | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 11eb25b6e2cd..161e5d84bd82 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -462,11 +462,17 @@ EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
 
 struct device_attribute *ata_common_sdev_attrs[] = {
 	&dev_attr_unload_heads,
-	&dev_attr_ncq_prio_enable,
 	NULL
 };
 EXPORT_SYMBOL_GPL(ata_common_sdev_attrs);
 
+struct device_attribute *ata_ncq_sdev_attrs[] = {
+	&dev_attr_unload_heads,
+	&dev_attr_ncq_prio_enable,
+	NULL
+};
+EXPORT_SYMBOL_GPL(ata_ncq_sdev_attrs);
+
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
  *	@sdev: SCSI device for which BIOS geometry is to be determined
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a36bdcb8d9e9..2a9d50b0e219 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1335,6 +1335,7 @@ extern int ata_link_nr_enabled(struct ata_link *link);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern struct device_attribute *ata_common_sdev_attrs[];
+extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1361,6 +1362,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 
 #define ATA_NCQ_SHT(drv_name)					\
 	ATA_BASE_SHT(drv_name),					\
+	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 
 /*
-- 
2.24.1

