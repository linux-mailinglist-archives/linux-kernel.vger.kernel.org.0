Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59959198E89
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgCaIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 04:32:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33954 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729425AbgCaIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:32:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V8SjZ2011728;
        Tue, 31 Mar 2020 10:32:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=3duVQKRlkCqQDo1E3CRZnFiVn5ck9hvVRKVRTqMhtbc=;
 b=CCaNM200syr4N0AsSmvYKxV5CIzQW/3KUTGVbqCzRe/U3y7ipCZXyxEXCdw1A6tqkqh0
 m3gihbFetmxgIqeVlQlyh76HiLGSvZkvtekvr/udTkijCzUQF+o/N0Zbx829N3or/BH4
 tCgcZlrPH6u/LKAOI5zKvISb8U1I/KvTUw4alrKh7OFNmd9xaHR2IS/bGzQjjsn/ho14
 FoRYx0k9T8Lj/5sP3JRO92vuUUsVi9g93qOtWr+sLRUhQGl5qxyfuop3Y74Y7mobJs9R
 WzkXN9JB2obsFVCL3X2/SByQjmSZgbnem15naeCdQZrWC5sHvHFmWLArUkwGvTHiJVm2 Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbmdsun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 10:32:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6ED0F10002A;
        Tue, 31 Mar 2020 10:32:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5283021E677;
        Tue, 31 Mar 2020 10:32:00 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 10:31:59
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v5 0/6] clockevent: add low power STM32 timer
Date:   Tue, 31 Mar 2020 10:31:40 +0200
Message-ID: <20200331083146.10462-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add low power timer as boadcast clockevent device.
Low power timer could runs even when CPUs are in idle mode and 
could wakeup them.

version 5:
- document interrupts and interrupt-names bindings
- use a different wake up interrupt
- add device-tree patch
- make STM32MP157 select low power timer configuration flag
- enable fast_io in regmap configuration

version 4:
- move defines in mfd/stm32-lptimer.h
- change compatible and subnode names
- document wakeup-source property
- reword commit message
- make driver Kconfig depends of MFD_STM32_LPTIMER
- remove useless include
- remove rate and clk fields from the private structure
- to add comments about the registers sequence in stm32_clkevent_lp_set_timer
- rework probe function and use devm_request_irq()
- do not allow module to be removed

version 3:
- fix timer set sequence
- don't forget to free irq on remove function
- use devm_kzalloc to simplify errors handling in probe function

version 2:
- stm32 clkevent driver is now a child of the stm32 lp timer node
- add a probe function and adpat the driver to use regmap provide
  by it parent
- stop using timer_of helpers

Benjamin Gaignard (6):
  dt-bindings: mfd: Document STM32 low power timer bindings
  ARM: dts: stm32: Add timer subnodes on stm32mp15 SoCs
  mfd: stm32: Add defines to be used for clkevent purpose
  mfd: stm32: enable regmap fast_io for stm32-lptimer
  clocksource: Add Low Power STM32 timers driver
  ARM: mach-stm32: select low power timer for STM32MP157

 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |  34 +++
 arch/arm/boot/dts/stm32mp151.dtsi                  |  45 ++++
 arch/arm/mach-stm32/Kconfig                        |   1 +
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-stm32-lp.c               | 231 +++++++++++++++++++++
 drivers/mfd/stm32-lptimer.c                        |   1 +
 include/linux/mfd/stm32-lptimer.h                  |   5 +
 8 files changed, 322 insertions(+)
 create mode 100644 drivers/clocksource/timer-stm32-lp.c

-- 
2.15.0

