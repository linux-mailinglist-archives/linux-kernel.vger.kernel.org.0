Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4752C284
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfE1JFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 05:05:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbfE1JFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:05:15 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 929DD88CD603B13F05D2;
        Tue, 28 May 2019 17:05:12 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 17:04:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-serial@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] serial: stm32: Make stm32_get_databits static
Date:   Tue, 28 May 2019 17:04:49 +0800
Message-ID: <20190528090449.22868-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/tty/serial/stm32-usart.c:603:14: warning:
 symbol 'stm32_get_databits' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/stm32-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9c2b04e..4517f2b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -600,7 +600,7 @@ static void stm32_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
-unsigned int stm32_get_databits(struct ktermios *termios)
+static unsigned int stm32_get_databits(struct ktermios *termios)
 {
 	unsigned int bits;
 
-- 
2.7.4


