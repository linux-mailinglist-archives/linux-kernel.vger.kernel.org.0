Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB90724FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 04:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGXC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 22:57:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41915 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGXC5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:57:02 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so82208247ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9LuYZGeTTRh9jWydJ51h+aLs5iCAt31ogMM0zlo+joQ=;
        b=k5ugUzpElphl/a1Ru+wxJ/t788bj7DWn4ZtCOF7bjTxCVc2E912sOW11VOsK20Px+n
         CRtHDYholNFHeKhZbkBvXxT1j14Nz4YVXf5bog2+l4e60PhFeLd4D965SaRyuk04mIJ7
         UXFKYjp8yx4OBEUsbAq5NyjhYRM6QZV6RWEdTNkZFAsxDY20FNDgQKJmoDu09kMuB9y9
         LcgDyn3/AJhiQrq32/frrZiVUt3Kkpmv+i5cfwdKd84/U4/4Wpsgx25iyko5HcsNJ+In
         Tp5t1BSIU0Xa6FjWIx7F6vtVu5pWgIlEUSCoigYQRr3bLGAKScXZNs/ayCpywo5PSZ3H
         3L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9LuYZGeTTRh9jWydJ51h+aLs5iCAt31ogMM0zlo+joQ=;
        b=SpXuH/6NHW1kxl1+x/Pw0FNQubJX5xrvct6u8jr2P8NpWy6avdpYH7nhcpc3LbHMgo
         K8n3D0OlFNsgny+1JxQjXwhvHmkrv6dhLR+m9Hm9VqduSejRpfLWcAtXL3/LB2jGoIC+
         oMPckEE3qnjQFAM93rg+fcytW8/XMRpPNHHjbrdUNMk7kG+PfuSYnVnu7dIhIRBrTJ21
         t+gSYG6LoLm0ogqb0YDajMV7X7floHX1z3qXZaqIf4lXmp1jO+aw51cHzdwHnRcqo/ys
         GDSjUQ3IkAZD4QrPIY6mQJZnMsSjvnmZweNWYyHUjn+jeQxmV9BrOAmW2SSm3tIqafQz
         g2eA==
X-Gm-Message-State: APjAAAVTkxQiLXiuRb0ISYYB9geW9cfb57WC+6bstFlmBOTLt6iuGUHi
        FGMRJwCxCpzRfQunUsD8x8M=
X-Google-Smtp-Source: APXvYqxeOFjGHKvmnyj7si7F3C+wNy21FAYf7FWnUifFXE3BDOY54y6bzL7+qggxsL0/SbVhzf8hHg==
X-Received: by 2002:a05:6638:201:: with SMTP id e1mr3127273jaq.45.1563937021448;
        Tue, 23 Jul 2019 19:57:01 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id 20sm49019979iog.62.2019.07.23.19.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 19:57:00 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     emamd001@umn.edu
Cc:     kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpi_touchscreen_probe: check for failure case
Date:   Tue, 23 Jul 2019 21:56:43 -0500
Message-Id: <20190724025644.17163-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_graph_get_next_endpoint may return NULL, so null check is needed.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 28c0620dfe0f..2e0977e26fab 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -399,6 +399,8 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 
 	/* Look up the DSI host.  It needs to probe before we do. */
 	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
+	if (!endpoint)
+		return -ENODEV;
 	dsi_host_node = of_graph_get_remote_port_parent(endpoint);
 	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
 	of_node_put(dsi_host_node);
-- 
2.17.1

