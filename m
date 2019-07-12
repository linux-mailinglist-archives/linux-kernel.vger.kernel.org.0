Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE69067038
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfGLNhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 09:37:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727353AbfGLNhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:37:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD247AF05;
        Fri, 12 Jul 2019 13:37:23 +0000 (UTC)
Date:   Fri, 12 Jul 2019 15:37:22 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] soc: ixp4xx: List the whole directory in MAINTAINERS
Message-ID: <20190712153722.3d1498be@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the whole directory containing the ixp4xx soc drivers in
MAINTAINERS instead of each driver separately. Otherwise changes
done to Makefile and Kconfig will fail to find a matching entry.
This will also let future drivers match without having to update
the entry each time.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Krzysztof Halasa <khalasa@piap.pl>
---
 MAINTAINERS |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-5.2.orig/MAINTAINERS	2019-07-12 15:33:28.106852821 +0200
+++ linux-5.2/MAINTAINERS	2019-07-12 15:35:54.309067537 +0200
@@ -8023,10 +8023,8 @@ F:	Documentation/media/v4l-drivers/ipu3.
 INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
 M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
-F:	include/linux/soc/ixp4xx/qmgr.h
-F:	include/linux/soc/ixp4xx/npe.h
-F:	drivers/soc/ixp4xx/ixp4xx-qmgr.c
-F:	drivers/soc/ixp4xx/ixp4xx-npe.c
+F:	include/linux/soc/ixp4xx/
+F:	drivers/soc/ixp4xx/
 F:	drivers/net/ethernet/xscale/ixp4xx_eth.c
 F:	drivers/net/wan/ixp4xx_hss.c
 

-- 
Jean Delvare
SUSE L3 Support
