Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871EEF4C83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 14:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfKHNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 08:03:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42887 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbfKHNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so6124257ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rl5uwkPm7ODgb0mKXC73DMWhjRD0JTB3vFmrVrN5ZB0=;
        b=iVy3OBxWjNuefDddBNbhbl7Cs/NtWVdjCC/od1h2NY+gSnjfqrNC9xMyzWE6JCHadL
         meWz1TdGa1kFUaFe1LBV/jM67MkOrHyRosHmDMbLKH/YlGIs4KIFUjA0IRlMr2sAmplm
         OZODn39ovzWFKJB/jcopkfA5Ou+HMW8/g56bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rl5uwkPm7ODgb0mKXC73DMWhjRD0JTB3vFmrVrN5ZB0=;
        b=U66sjXOhtfZvy0FGBirt9bkHxkOPCmHijRfryCwGOqsdLZtmPvU8KTas9WbWwytcfN
         vZvX3NYta0dPExrs1C0xF1bkOg7/S2qoNK3VPoLd+tWdXDIV9qjw6WlvHUEwbCVn2dmO
         L45E7KmvnKiiOo1gQToFwPAFiQBzxkn+GoylaU+6K4DVT6WuP59SD94SuW632uxQuUzf
         isQl9d826K8fdwwPRzpvIEki4ic7WkxwtruAbhBRAvz2keUXpMKBOBOQ8K72VFCPrqoY
         Oicp+yG7frvuOI5TInzzJW54DnjXYcNyYRjOiYGV3HP/t/G8w/KFDk8L/nhbWMvTpVBH
         azzw==
X-Gm-Message-State: APjAAAWuH+Ms1Txdp/q+3NBqic5ovtpowulxjYPFObf1/DNJL3mtwWkx
        G9/1dkL3joBG/4MrEQVg2Wq5tg==
X-Google-Smtp-Source: APXvYqzZa5jEsgyjO4bjCEsZXjRtgdus6spNSgtKC++GgbqHCKBa6/dHZb1FcDGJ/haiGgd6jr0bwA==
X-Received: by 2002:a05:651c:1124:: with SMTP id e4mr6831944ljo.52.1573218130055;
        Fri, 08 Nov 2019 05:02:10 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:09 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 33/47] serial: ucc_uart: access __be32 field using be32_to_cpu
Date:   Fri,  8 Nov 2019 14:01:09 +0100
Message-Id: <20191108130123.6839-34-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buf member of struct qe_bd is a __be32, so to make this work on
little-endian hosts, use be32_to_cpu when reading it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index f5ea84928a3b..a5330582b610 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -343,7 +343,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 		/* Pick next descriptor and fill from buffer */
 		bdp = qe_port->tx_cur;
 
-		p = qe2cpu_addr(bdp->buf, qe_port);
+		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 
 		*p++ = port->x_char;
 		qe_iowrite16be(1, &bdp->length);
@@ -371,7 +371,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 	while (!(qe_ioread16be(&bdp->status) & BD_SC_READY) &&
 	       (xmit->tail != xmit->head)) {
 		count = 0;
-		p = qe2cpu_addr(bdp->buf, qe_port);
+		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 		while (count < qe_port->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -491,7 +491,7 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 		}
 
 		/* get pointer */
-		cp = qe2cpu_addr(bdp->buf, qe_port);
+		cp = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
-- 
2.23.0

