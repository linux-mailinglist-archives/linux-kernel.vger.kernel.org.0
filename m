Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7839395EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfHTMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 08:36:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730042AbfHTMgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:36:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 657D8505C93C0B5FABDC;
        Tue, 20 Aug 2019 20:36:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 20 Aug 2019 20:36:24 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [PATCH linux-next] tty: serial: add dependence for CONFIG_SERIAL_FSL_LINFLEXUART
Date:   Tue, 20 Aug 2019 20:40:15 +0800
Message-ID: <20190820124015.28409-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SERIAL_FSL_LINFLEXUART=y and CONFIG_PRINTK is not set,
one compilation error is found as below:
drivers/tty/serial/fsl_linflexuart.c: In function linflex_earlycon_putchar:
drivers/tty/serial/fsl_linflexuart.c:608:31: error: CONFIG_LOG_BUF_SHIFT undeclared
(first use in this function); did you mean CONFIG_ISA_BUS_API?
  if (earlycon_buf.len >= 1 << CONFIG_LOG_BUF_SHIFT)
                               ^~~~~~~~~~~~~~~~~~~~
                               CONFIG_ISA_BUS_API
This because CONFIG_LOG_BUF_SHIFT is depended on CONFIG_PRINTK, fix this
by adding dependence for CONFIG_SERIAL_FSL_LINFLEXUART.

Fixes: b953815b819b ("tty: serial: Add linflexuart driver for S32V234")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d9caf3242b25..4789b5d62f63 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1392,6 +1392,7 @@ config SERIAL_FSL_LPUART_CONSOLE
 
 config SERIAL_FSL_LINFLEXUART
 	tristate "Freescale linflexuart serial port support"
+	depends on PRINTK
 	select SERIAL_CORE
 	help
 	  Support for the on-chip linflexuart on some Freescale SOCs.
-- 
2.20.1

