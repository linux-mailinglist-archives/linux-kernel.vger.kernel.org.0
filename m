Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D434FF4C56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 14:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfKHNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 08:02:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46630 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfKHNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so6090779ljp.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=XkJAhXffjW6sLGidyoW6envOidVvdJ8BQkPq8vG0pGpA/4S0zQDW1cQiCFn6AbkNVu
         lKSJ/fyLaTVT9YpDlOYtgCF6M0vAak9InlnDdRLV8faRxFEFc/5zQeELf0teqgHziaP1
         mc28TbmJQsB2/p7ad853POos5LlDUzylHoJ/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=ckCGpCBtcqXYc7m5LzmS3eNLmgHVdQ3gSsh6eNbSClz+TgyEYhQLuJU+hogd9FEVwE
         CJA45DEqAkYsBEaZY/JryRylw8LhWCPejaWF+ekMRTY221Mt3DmBP75BZVe1t7A7gu6f
         AGaA8fvalOU9Ncqi+WH01VDvwd9ogpZrldB512r/a21bbr8KqP65xJkSGO7dKLVl5pRp
         esJB0mRkraEpk+JlLEVi0zrEwg7xQBpW2d3uSP5eeBqjb9B7YdlQbfUnneMsAyKjPdQp
         P6ArnqbEszEpaRXl2QdOllXHuRm6fk/MAE5poJvHjpupyyNPQyCZ2J4cuJUJLHABSm9U
         9W8A==
X-Gm-Message-State: APjAAAXZdbRg3kx3S+xinKCOwF+vbCL549WmcRJXUSGpkGset3XRVsO9
        I0gvoI8JP9IAwFttz75ZhiZQ+Q==
X-Google-Smtp-Source: APXvYqxbFlgCtl6tta2OpdTxU9LRwd/l2khasl25WtDrijVbgbWeE5FWCtL/GrDLKg+orNEgarZjCg==
X-Received: by 2002:a2e:558:: with SMTP id 85mr6765994ljf.67.1573218123603;
        Fri, 08 Nov 2019 05:02:03 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:03 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 28/47] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date:   Fri,  8 Nov 2019 14:01:04 +0100
Message-Id: <20191108130123.6839-29-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

