Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CECE01A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfD2KEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 06:04:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24810 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727793AbfD2KEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:04:04 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3TA3DII007867;
        Mon, 29 Apr 2019 12:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=al4la5HQX8Z1t7Cy9I7E+Bey99nYJ0hFNlGek6Bi6hM=;
 b=GE2s6ojfDyRa6E8ARGxkynpH0sC/qma850/3fz3Ls2l1TKGHMDgrY1D1TxGuIrDoLCMd
 u3YZbOmbCxh6y8I+gMfuSnrA+i/P3gCdJdFjH1pld7amJL6gRn7ECYaphky8/cxn07xt
 sAIx5NJL9z9aVssFLcT1JrQn3BUfa0hoJvv3C2A/+PdANZEgCHjax/HX4xEZZfMqrj7V
 BywEFlnB1pBZV4DOkhOwfHmMbNsw1u30EKMhlS4OVLSSXwQrGY/9GDqKsQsVB4azlR9C
 8E7x9BA1LL3a8QGOA/YnbxdicwMM1yEmgPk2RgLg29/umTV91imZB3XfyzeluGAqapmu 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s4cutud3q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Apr 2019 12:03:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE20B31;
        Mon, 29 Apr 2019 10:03:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 968DD1514;
        Mon, 29 Apr 2019 10:03:38 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Apr
 2019 12:03:38 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 29 Apr 2019 12:03:38 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH 3/5] perf: stm32: ddrperfm driver creation
Thread-Topic: [PATCH 3/5] perf: stm32: ddrperfm driver creation
Thread-Index: AQHU/nLQy+579AvVAkG6wDNe4OL1GA==
Date:   Mon, 29 Apr 2019 10:03:38 +0000
Message-ID: <1556532194-27904-4-git-send-email-gerald.baeza@st.com>
References: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.

This perf drivers supports the read, write, activate, idle and total
time counters, described in the reference manual RM0436.

A 'bandwidth' attribute is added in the 'ddrperfm' event_source in order
to directly get the read and write bandwidths (in MB/s), from the last
read, write and total time counters reading.
This attribute is aside the 'events' attributes group because it is not
a counter, as seen by perf tool.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/perf/Kconfig         |   6 +
 drivers/perf/Makefile        |   1 +
 drivers/perf/stm32_ddr_pmu.c | 502 +++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 509 insertions(+)
 create mode 100644 drivers/perf/stm32_ddr_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index af9bc17..d2dde80 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -96,6 +96,12 @@ config THUNDERX2_PMU
 	   The SoC has PMU support in its L3 cache controller (L3C) and
 	   in the DDR4 Memory Controller (DMC).
=20
+config STM32_DDR_PMU
+       tristate "STM32 DDR PMU"
+       depends on MACH_STM32MP157
+       help
+         Support for STM32 DDR performance monitor (DDRPERFM).
+
 config XGENE_PMU
         depends on ARCH_XGENE
         bool "APM X-Gene SoC PMU"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 909f27f..67505e1 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARM_PMU_ACPI) +=3D arm_pmu_acpi.o
 obj-$(CONFIG_HISI_PMU) +=3D hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+=3D qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
+obj-$(CONFIG_STM32_DDR_PMU) +=3D stm32_ddr_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
new file mode 100644
index 0000000..a7a6487
--- /dev/null
+++ b/drivers/perf/stm32_ddr_pmu.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is the STM32 DDR performance monitor (DDRPERFM) driver
+ *
+ * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
+ * Author: Gerald Baeza <gerald.baeza@st.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define POLL_MS		4000	/* The counter roll over after ~8s @533MHz */
+#define WORD_LENGTH	4	/* Bytes */
+#define BURST_LENGTH	8	/* Words */
+
+#define DDRPERFM_CTL	0x000
+#define DDRPERFM_CFG	0x004
+#define DDRPERFM_STATUS 0x008
+#define DDRPERFM_CCR	0x00C
+#define DDRPERFM_IER	0x010
+#define DDRPERFM_ISR	0x014
+#define DDRPERFM_ICR	0x018
+#define DDRPERFM_TCNT	0x020
+#define DDRPERFM_CNT(X)	(0x030 + 8 * (X))
+#define DDRPERFM_HWCFG	0x3F0
+#define DDRPERFM_VER	0x3F4
+#define DDRPERFM_ID	0x3F8
+#define DDRPERFM_SID	0x3FC
+
+#define CTL_START	0x00000001
+#define CTL_STOP	0x00000002
+#define CCR_CLEAR_ALL	0x8000000F
+#define SID_MAGIC_ID	0xA3C5DD01
+
+#define STRING "Read =3D %llu, Write =3D %llu, Read & Write =3D %llu (MB/s=
)\n"
+
+enum {
+	READ_CNT,
+	WRITE_CNT,
+	ACTIVATE_CNT,
+	IDLE_CNT,
+	TIME_CNT,
+	PMU_NR_COUNTERS
+};
+
+struct stm32_ddr_pmu {
+	struct pmu pmu;
+	void __iomem *membase;
+	struct clk *clk;
+	struct clk *clk_ddr;
+	unsigned long clk_ddr_rate;
+	struct hrtimer hrtimer;
+	ktime_t poll_period;
+	spinlock_t lock; /* for shared registers access */
+	struct perf_event *events[PMU_NR_COUNTERS];
+	u64 events_cnt[PMU_NR_COUNTERS];
+};
+
+static inline struct stm32_ddr_pmu *pmu_to_stm32_ddr_pmu(struct pmu *p)
+{
+	return container_of(p, struct stm32_ddr_pmu, pmu);
+}
+
+static inline struct stm32_ddr_pmu *hrtimer_to_stm32_ddr_pmu(struct hrtime=
r *h)
+{
+	return container_of(h, struct stm32_ddr_pmu, hrtimer);
+}
+
+static u64 stm32_ddr_pmu_compute_bw(struct stm32_ddr_pmu *stm32_ddr_pmu,
+				    int counter)
+{
+	u64 bw =3D stm32_ddr_pmu->events_cnt[counter], tmp;
+	u64 div =3D stm32_ddr_pmu->events_cnt[TIME_CNT];
+	u32 prediv =3D 1, premul =3D 1;
+
+	if (bw && div) {
+		/* Maximize the dividend into 64 bits */
+		while ((bw < 0x8000000000000000ULL) &&
+		       (premul < 0x40000000UL)) {
+			bw =3D bw << 1;
+			premul *=3D 2;
+		}
+		/* Minimize the dividor to fit in 32 bits */
+		while ((div > 0xffffffffUL) && (prediv < 0x40000000UL)) {
+			div =3D div >> 1;
+			prediv *=3D 2;
+		}
+		/* Divide counter per time and multiply per DDR settings */
+		do_div(bw, div);
+		tmp =3D bw * BURST_LENGTH * WORD_LENGTH;
+		tmp *=3D stm32_ddr_pmu->clk_ddr_rate;
+		if (tmp < bw)
+			goto error;
+		bw =3D tmp;
+		/* Cancel the prediv and premul factors */
+		while (prediv > 1) {
+			bw =3D bw >> 1;
+			prediv /=3D 2;
+		}
+		while (premul > 1) {
+			bw =3D bw >> 1;
+			premul /=3D 2;
+		}
+		/* Convert MHz to Hz and B to MB, to finally get MB/s */
+		tmp =3D bw * 1000000;
+		if (tmp < bw)
+			goto error;
+		bw =3D tmp;
+		premul =3D 1024 * 1024;
+		while (premul > 1) {
+			bw =3D bw >> 1;
+			premul /=3D 2;
+		}
+	}
+	return bw;
+
+error:
+	pr_warn("stm32-ddr-pmu: overflow detected\n");
+	return 0;
+}
+
+static void stm32_ddr_pmu_event_configure(struct perf_event *event)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long lock_flags, config_base =3D event->hw.config_base;
+	u32 val;
+
+	spin_lock_irqsave(&stm32_ddr_pmu->lock, lock_flags);
+	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+
+	if (config_base < TIME_CNT) {
+		val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_CFG);
+		val |=3D (1 << config_base);
+		writel_relaxed(val, stm32_ddr_pmu->membase + DDRPERFM_CFG);
+	}
+	spin_unlock_irqrestore(&stm32_ddr_pmu->lock, lock_flags);
+}
+
+static void stm32_ddr_pmu_event_read(struct perf_event *event)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long flags, config_base =3D event->hw.config_base;
+	struct hw_perf_event *hw =3D &event->hw;
+	u64 prev_count, new_count, mask;
+	u32 val, offset, bit;
+
+	spin_lock_irqsave(&stm32_ddr_pmu->lock, flags);
+
+	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+
+	if (config_base =3D=3D TIME_CNT) {
+		offset =3D DDRPERFM_TCNT;
+		bit =3D 1 << 31;
+	} else {
+		offset =3D DDRPERFM_CNT(config_base);
+		bit =3D 1 << config_base;
+	}
+	val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_STATUS);
+	if (val & bit)
+		pr_warn("stm32_ddr_pmu hardware overflow\n");
+	val =3D readl_relaxed(stm32_ddr_pmu->membase + offset);
+	writel_relaxed(bit, stm32_ddr_pmu->membase + DDRPERFM_CCR);
+	writel_relaxed(CTL_START, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+
+	do {
+		prev_count =3D local64_read(&hw->prev_count);
+		new_count =3D prev_count + val;
+	} while (local64_xchg(&hw->prev_count, new_count) !=3D prev_count);
+
+	mask =3D GENMASK_ULL(31, 0);
+	local64_add(val & mask, &event->count);
+
+	if (new_count < prev_count)
+		pr_warn("STM32 DDR PMU counter saturated\n");
+
+	spin_unlock_irqrestore(&stm32_ddr_pmu->lock, flags);
+}
+
+static void stm32_ddr_pmu_event_start(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	struct hw_perf_event *hw =3D &event->hw;
+	unsigned long lock_flags;
+
+	if (WARN_ON_ONCE(!(hw->state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hw->state & PERF_HES_UPTODATE));
+
+	stm32_ddr_pmu_event_configure(event);
+
+	/* Clear all counters to synchronize them, then start */
+	spin_lock_irqsave(&stm32_ddr_pmu->lock, lock_flags);
+	writel_relaxed(CCR_CLEAR_ALL, stm32_ddr_pmu->membase + DDRPERFM_CCR);
+	writel_relaxed(CTL_START, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+	spin_unlock_irqrestore(&stm32_ddr_pmu->lock, lock_flags);
+
+	hw->state =3D 0;
+}
+
+static void stm32_ddr_pmu_event_stop(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long lock_flags, config_base =3D event->hw.config_base;
+	struct hw_perf_event *hw =3D &event->hw;
+	u32 val, bit;
+
+	if (WARN_ON_ONCE(hw->state & PERF_HES_STOPPED))
+		return;
+
+	spin_lock_irqsave(&stm32_ddr_pmu->lock, lock_flags);
+	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+	if (config_base =3D=3D TIME_CNT)
+		bit =3D 1 << 31;
+	else
+		bit =3D 1 << config_base;
+	writel_relaxed(bit, stm32_ddr_pmu->membase + DDRPERFM_CCR);
+	if (config_base < TIME_CNT) {
+		val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_CFG);
+		val &=3D ~bit;
+		writel_relaxed(val, stm32_ddr_pmu->membase + DDRPERFM_CFG);
+	}
+	spin_unlock_irqrestore(&stm32_ddr_pmu->lock, lock_flags);
+
+	hw->state |=3D PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_UPDATE) {
+		stm32_ddr_pmu_event_read(event);
+		hw->state |=3D PERF_HES_UPTODATE;
+	}
+}
+
+static int stm32_ddr_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long config_base =3D event->hw.config_base;
+	struct hw_perf_event *hw =3D &event->hw;
+
+	stm32_ddr_pmu->events_cnt[config_base] =3D 0;
+	stm32_ddr_pmu->events[config_base] =3D event;
+
+	clk_enable(stm32_ddr_pmu->clk);
+	hrtimer_start(&stm32_ddr_pmu->hrtimer, stm32_ddr_pmu->poll_period,
+		      HRTIMER_MODE_REL);
+
+	stm32_ddr_pmu_event_configure(event);
+
+	hw->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		stm32_ddr_pmu_event_start(event, 0);
+
+	return 0;
+}
+
+static void stm32_ddr_pmu_event_del(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long config_base =3D event->hw.config_base;
+	bool stop =3D true;
+	int i;
+
+	stm32_ddr_pmu_event_stop(event, PERF_EF_UPDATE);
+
+	stm32_ddr_pmu->events_cnt[config_base] +=3D local64_read(&event->count);
+	stm32_ddr_pmu->events[config_base] =3D NULL;
+
+	for (i =3D 0; i < PMU_NR_COUNTERS; i++)
+		if (stm32_ddr_pmu->events[i])
+			stop =3D false;
+	if (stop)
+		hrtimer_cancel(&stm32_ddr_pmu->hrtimer);
+
+	clk_disable(stm32_ddr_pmu->clk);
+}
+
+static int stm32_ddr_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hw =3D &event->hw;
+
+	if (is_sampling_event(event))
+		return -EINVAL;
+
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	if (event->attr.exclude_user   ||
+	    event->attr.exclude_kernel ||
+	    event->attr.exclude_hv     ||
+	    event->attr.exclude_idle   ||
+	    event->attr.exclude_host   ||
+	    event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	hw->config_base =3D event->attr.config;
+
+	return 0;
+}
+
+static enum hrtimer_restart stm32_ddr_pmu_poll(struct hrtimer *hrtimer)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D hrtimer_to_stm32_ddr_pmu(hrtimer)=
;
+	int i;
+
+	for (i =3D 0; i < PMU_NR_COUNTERS; i++)
+		if (stm32_ddr_pmu->events[i])
+			stm32_ddr_pmu_event_read(stm32_ddr_pmu->events[i]);
+
+	hrtimer_forward_now(hrtimer, stm32_ddr_pmu->poll_period);
+
+	return HRTIMER_RESTART;
+}
+
+static ssize_t stm32_ddr_pmu_sysfs_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr =3D container_of(attr, struct dev_ext_attribute, attr);
+
+	return sprintf(buf, "config=3D0x%lx\n", (unsigned long)eattr->var);
+}
+
+static ssize_t bandwidth_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D dev_get_drvdata(dev);
+	u64 r_bw, w_bw;
+	int ret;
+
+	if (stm32_ddr_pmu->events_cnt[TIME_CNT]) {
+		r_bw =3D stm32_ddr_pmu_compute_bw(stm32_ddr_pmu, READ_CNT);
+		w_bw =3D stm32_ddr_pmu_compute_bw(stm32_ddr_pmu, WRITE_CNT);
+
+		ret =3D snprintf(buf, PAGE_SIZE, STRING,
+			       r_bw, w_bw, (r_bw + w_bw));
+	} else {
+		ret =3D snprintf(buf, PAGE_SIZE, "No data available\n");
+	}
+
+	return ret;
+}
+
+#define STM32_DDR_PMU_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]) {				\
+		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
+	})[0].attr.attr)
+
+#define STM32_DDR_PMU_EVENT_ATTR(_name, _config)		\
+	STM32_DDR_PMU_ATTR(_name, stm32_ddr_pmu_sysfs_show,	\
+			   (unsigned long)_config)
+
+static struct attribute *stm32_ddr_pmu_event_attrs[] =3D {
+	STM32_DDR_PMU_EVENT_ATTR(read_cnt, READ_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(write_cnt, WRITE_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(activate_cnt, ACTIVATE_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(idle_cnt, IDLE_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(time_cnt, TIME_CNT),
+	NULL
+};
+
+static DEVICE_ATTR_RO(bandwidth);
+static struct attribute *stm32_ddr_pmu_bandwidth_attrs[] =3D {
+	&dev_attr_bandwidth.attr,
+	NULL,
+};
+
+static struct attribute_group stm32_ddr_pmu_event_attrs_group =3D {
+	.name =3D "events",
+	.attrs =3D stm32_ddr_pmu_event_attrs,
+};
+
+static struct attribute_group stm32_ddr_pmu_bandwidth_attrs_group =3D {
+	.attrs =3D stm32_ddr_pmu_bandwidth_attrs,
+};
+
+static const struct attribute_group *stm32_ddr_pmu_attr_groups[] =3D {
+	&stm32_ddr_pmu_event_attrs_group,
+	&stm32_ddr_pmu_bandwidth_attrs_group,
+	NULL,
+};
+
+static int stm32_ddr_pmu_device_probe(struct platform_device *pdev)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu;
+	struct resource *res;
+	int i, ret;
+	u32 val;
+
+	stm32_ddr_pmu =3D devm_kzalloc(&pdev->dev, sizeof(struct stm32_ddr_pmu),
+				     GFP_KERNEL);
+	if (!stm32_ddr_pmu)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, stm32_ddr_pmu);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	stm32_ddr_pmu->membase =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(stm32_ddr_pmu->membase)) {
+		pr_warn("Unable to get STM32 DDR PMU membase\n");
+		return PTR_ERR(stm32_ddr_pmu->membase);
+	}
+
+	stm32_ddr_pmu->clk =3D devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(stm32_ddr_pmu->clk)) {
+		pr_warn("Unable to get STM32 DDR PMU clock\n");
+		return PTR_ERR(stm32_ddr_pmu->clk);
+	}
+
+	ret =3D clk_prepare_enable(stm32_ddr_pmu->clk);
+	if (ret) {
+		pr_warn("Unable to prepare STM32 DDR PMU clock\n");
+		return ret;
+	}
+
+	stm32_ddr_pmu->clk_ddr =3D devm_clk_get(&pdev->dev, "ddr");
+	if (IS_ERR(stm32_ddr_pmu->clk_ddr)) {
+		pr_warn("Unable to get STM32 DDR clock\n");
+		return PTR_ERR(stm32_ddr_pmu->clk_ddr);
+	}
+	stm32_ddr_pmu->clk_ddr_rate =3D clk_get_rate(stm32_ddr_pmu->clk_ddr);
+	stm32_ddr_pmu->clk_ddr_rate /=3D 1000000;
+
+	stm32_ddr_pmu->poll_period =3D ms_to_ktime(POLL_MS);
+	hrtimer_init(&stm32_ddr_pmu->hrtimer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	stm32_ddr_pmu->hrtimer.function =3D stm32_ddr_pmu_poll;
+	spin_lock_init(&stm32_ddr_pmu->lock);
+
+	for (i =3D 0; i < PMU_NR_COUNTERS; i++) {
+		stm32_ddr_pmu->events[i] =3D NULL;
+		stm32_ddr_pmu->events_cnt[i] =3D 0;
+	}
+
+	val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_SID);
+	if (val !=3D SID_MAGIC_ID)
+		return -EINVAL;
+
+	stm32_ddr_pmu->pmu =3D (struct pmu) {
+		.task_ctx_nr =3D perf_invalid_context,
+		.start =3D stm32_ddr_pmu_event_start,
+		.stop =3D stm32_ddr_pmu_event_stop,
+		.add =3D stm32_ddr_pmu_event_add,
+		.del =3D stm32_ddr_pmu_event_del,
+		.event_init =3D stm32_ddr_pmu_event_init,
+		.attr_groups =3D stm32_ddr_pmu_attr_groups,
+	};
+	ret =3D perf_pmu_register(&stm32_ddr_pmu->pmu, "ddrperfm", -1);
+	if (ret) {
+		pr_warn("Unable to register STM32 DDR PMU\n");
+		return ret;
+	}
+
+	pr_info("stm32-ddr-pmu: probed (ID=3D0x%08x VER=3D0x%08x), DDR@%luMHz\n",
+		readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_ID),
+		readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_VER),
+		stm32_ddr_pmu->clk_ddr_rate);
+
+	clk_disable(stm32_ddr_pmu->clk);
+
+	return 0;
+}
+
+static int stm32_ddr_pmu_device_remove(struct platform_device *pdev)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&stm32_ddr_pmu->pmu);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_ddr_pmu_of_match[] =3D {
+	{ .compatible =3D "st,stm32-ddr-pmu" },
+	{ },
+};
+
+static struct platform_driver stm32_ddr_pmu_driver =3D {
+	.driver =3D {
+		.name	=3D "stm32-ddr-pmu",
+		.of_match_table =3D of_match_ptr(stm32_ddr_pmu_of_match),
+	},
+	.probe =3D stm32_ddr_pmu_device_probe,
+	.remove =3D stm32_ddr_pmu_device_remove,
+};
+
+module_platform_driver(stm32_ddr_pmu_driver);
+
+MODULE_DESCRIPTION("Perf driver for STM32 DDR performance monitor");
+MODULE_AUTHOR("Gerald Baeza <gerald.baeza@st.com>");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4
