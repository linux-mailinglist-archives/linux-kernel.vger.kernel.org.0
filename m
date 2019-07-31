Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8602D7CA63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfGaRbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:31:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34320 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbfGaRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so30805665plt.1;
        Wed, 31 Jul 2019 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDqoJuUDc0pfMMhVm9i/41YEg5ZzqjvFPep6mT8qx0c=;
        b=f/VCF9KxnW7V9Se6378U6f/91XDcjDYiOM0+kriHKDCuzIaeupEcnYunBBtBA3XAPJ
         nNgh7laKu8NSU29snu8TlLCDbycZHY2WRpHv+cY6kgjxCXydp+SkpuNQ0nUGhc5cn6R5
         d34ZNBP6NgHA0sDZiXy8Pd7S5zbthlxFg779SKFQbg7QIAyGtOZwGyWckisMFaF01Lk6
         mRd3xRoWMPgHL48nvHupmPhW3obgomhGk8nvCwEv/DHzHz5vvrzrv0Q3tIreyTiuTP5O
         2E4qwRzEoF+pq0MfjtWyqNOoZufId6w0FJaEMnH5sPVSYcESEjVOAvSOa5MTA1iod2nE
         /Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDqoJuUDc0pfMMhVm9i/41YEg5ZzqjvFPep6mT8qx0c=;
        b=bbKmMlT+MjJjcjym5vx1YRf1wUadhLjM5oVVO8F+udz/5EqF/j2+dXK0kiJd5Vaqf4
         lcDH4nC8DtZxaKZ4QGvqCKuQTwRvuP6g09lzqZbpbAVnLYXlyx6nlYfaPJPwVWH9jANU
         uiIjIg9lnz/kx4UvRyC5etZ8OGTYuK1bpLfoy+QxYei7i76tXBmPpfa8nnFhiz+qpRgH
         M44kiU7zKkmUdUVy4TFNxRZcxc8/9pMqY7v5S0b0t/G5qu9YgTWwg+t841B7x/EgT7vt
         MwYL73MSciN0NDAnD7T2kXL0a3jH5Q69eNxYS8zWgYu/RtkF8rlVRbR4GAPGOUpx2Goi
         mHDA==
X-Gm-Message-State: APjAAAVr28q2ehVcudl0q23DEDRsjSHGxSwYvySbDNO/wX7yZlxFSR/p
        6ENyrMO16nXqbCsTvsByKchcNbvWrBM=
X-Google-Smtp-Source: APXvYqy08IupmUZhmzMcDU06KFjO3bRJSmYJWLt9Y3m0xctR1NTWwKEMpBE5JuBZTOMgqp+zEHkAPQ==
X-Received: by 2002:a17:902:8489:: with SMTP id c9mr123055601plo.327.1564594300909;
        Wed, 31 Jul 2019 10:31:40 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:40 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/23] tty: serial: fsl_lpuart: Drop unnecessary lpuart*_stop_tx()
Date:   Wed, 31 Jul 2019 10:30:38 -0700
Message-Id: <20190731173045.11718-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the time lpuart_shutdown() calls lpuart_stop_tx() UARTCR2_TE and
UARTCR2_TIE (which the latter will clear) are already cleared, so that
function call should effectively be a no-op. Moreso, lpuart_stop_tx()
is expected to be executed with port spinlock held, which the caller
doesn't. Given all that, drop the call to lpuart_stop_tx() in
lpuart_shutdown().

In case of lpuart32_shutdown()/lpuart32_stop_tx(), TIE won't even be
set if lpuart_dma_tx_use is true. Drop it there as well.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e59dd90fc34c..2597a877d639 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1574,8 +1574,6 @@ static void lpuart_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart_stop_tx(port);
 	}
 }
 
@@ -1607,8 +1605,6 @@ static void lpuart32_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart32_stop_tx(port);
 	}
 }
 
-- 
2.21.0

