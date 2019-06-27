Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA958CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfF0VQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 17:16:48 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:54024 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:16:48 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id DF4E380348;
        Thu, 27 Jun 2019 23:16:44 +0200 (CEST)
Date:   Thu, 27 Jun 2019 23:16:43 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH] MAINTAINERS: add Sam Ravnborg for drm/atmel_hlcdc
Message-ID: <20190627211643.GA19853@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=VwQbUJbxAAAA:8 a=XYAwZIGsAAAA:8
        a=P-IC7800AAAA:8 a=e5mUnYsNAAAA:8 a=swgTEDU7tAKFpF940fYA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=E8ToXWR_bxluHZ7gmE-Z:22 a=d3PnA9EDa4IxuAV0gXij:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have agreed with Boris Brezillon that we will share the
maintainer role for the drm/atmel_hlcdc driver.
Nicolas Ferre from Microchip has donated a few boards that
allows me to test things - thanks!

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 515a81fdb7d6..0a76716874bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5251,6 +5251,7 @@ F:	Documentation/gpu/meson.rst
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR ATMEL HLCDC
+M:	Sam Ravnborg <sam@ravnborg.org>
 M:	Boris Brezillon <bbrezillon@kernel.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-- 
2.20.1

