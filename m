Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7D2A981
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfEZLwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 07:52:03 -0400
Received: from www17.your-server.de ([213.133.104.17]:48374 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfEZLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 07:52:02 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hUrh3-00032r-9b; Sun, 26 May 2019 13:52:01 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hUrh1-0008TO-VQ; Sun, 26 May 2019 13:52:01 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Sun, 26 May 2019 13:51:59 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Sun, 26 May 2019 13:51:59 +0200
Message-Id: <E1hUrh1-0008TO-VQ@sslproxy03.your-server.de>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25461/Sun May 26 09:57:08 2019)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From thomas@m3y3r.de Sun May 26 13:49:04 2019
Subject: [PATCH] drm/omap: Make sure device_id tables are NULL terminated
To: tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1558871364611-249425076-1-diffsplit-thomas@m3y3r.de>
References: <1558871364605-1026448693-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1558871364605-1026448693-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 1

Make sure (of/i2c/platform)_device_id tables are NULL terminated.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
--- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
@@ -198,6 +198,7 @@ static const struct of_device_id omapdss
 	{ .compatible = "toppoly,td028ttec1" },
 	{ .compatible = "tpo,td028ttec1" },
 	{ .compatible = "tpo,td043mtea1" },
+	{},
 };
 
 static int __init omapdss_boot_init(void)
