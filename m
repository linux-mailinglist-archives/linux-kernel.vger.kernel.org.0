Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176B51003F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfKRLZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:25:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfKRLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so18998866wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8f4zkDbM2vRjhOU8bSiNRa1yRbCbXojjY2BLWPzI+4=;
        b=CcHL/wr1MdHVku5NXqYEh205MsV8nNbDhvOTjyrzGp7E05+OZTj+AZ65Mq6w5E7fC4
         QUUsnYvwWfYNPoDOFKaiWLBxE8orb1Uaokk6+Yh/3Va8yKkEh4CwI3Bvmo4RGmqS5LuR
         7JMzpGl4mSsJFAgOgGnawmUsoJc5NQxoI5Jzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8f4zkDbM2vRjhOU8bSiNRa1yRbCbXojjY2BLWPzI+4=;
        b=nnpsYaT6EhLjMAkhZV2sRozI5g/NEAOeXZURlM2iFpKa8eRox4wvxwOZYgd2/k3r99
         nVSmaJ7vwDeD8jjz2uCrhEHSqfxrAvAt2zsDUZVBZ8IF5C5ddQILnmh/e+v+o9i286xc
         L0XnmVwlt9cra6Dr2/TPnZZg7/R7FelZEaMvX1c39xTiHI4++1r71NCtaPlhn5kUt1J4
         jZRnR6WpvOllDXjl60wqqowfw9bem/4a7QQxJkCJoOXHh98Dacl0siKSnW4ZoYqS2Rs/
         uZgV1veqM6+du3zLrPBcne0qqtTdZhsC3DUF+YHseaX//2P4/oaj8OZoC8600YRM9rTr
         X2FQ==
X-Gm-Message-State: APjAAAVrORnlWAtZkj5RGcFUymdvvLKuHS7TlXrU9Mf6/AI0GTZKJ60G
        3LSbTO2bvCO4S8l/4uZSHWNOKg==
X-Google-Smtp-Source: APXvYqxiVIfcvMPElvIDiGYFueIrSfkJiIqk8i4Ft8HAmwqiGb21aiYg0hu8lk7xe2G5zIrvZe7G8Q==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr31691608wru.342.1574076255340;
        Mon, 18 Nov 2019 03:24:15 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:14 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 33/48] serial: ucc_uart: limit brg-frequency workaround to PPC32
Date:   Mon, 18 Nov 2019 12:23:09 +0100
Message-Id: <20191118112324.22725-34-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Timur Tabi

    This bug in older U-Boots is definitely PowerPC-specific

So before allowing this driver to be built for platforms other than
PPC32, make sure that we don't accept malformed device trees on those
other platforms.

Suggested-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index c055abf4c919..9436b93d5cfa 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1392,6 +1392,13 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	if (val)
 		qe_port->port.uartclk = val;
 	else {
+		if (!IS_ENABLED(CONFIG_PPC32)) {
+			dev_err(&ofdev->dev,
+				"invalid brg-frequency in device tree\n");
+			ret = -EINVAL;
+			goto out_np;
+		}
+
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
-- 
2.23.0

