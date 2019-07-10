Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A399628E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfGHTDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:03:15 -0400
Received: from first.geanix.com ([116.203.34.67]:59810 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbfGHTDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:03:14 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 301FB1697;
        Mon,  8 Jul 2019 19:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562612506; bh=eUvEBsk9YXwvgLqf5OTAVLdqkkv/UdScF9UtNiuiDbQ=;
        h=From:To:Cc:Subject:Date;
        b=LL61Qi7p2jP05T3Y3BEQuHJwXmHeMmp9QvAR3B0GXbrHcHnaaWkWXTvHeZ/+OlSU2
         oCADjdMoiaiRc32JblBklePWBvUPedP/XhzcF3U3Csf15qGNGzltgW1PpCJIpaq0wI
         6qFaWf6YkZzTshkZLP2BgHKfcx2rj7onNwVtUfwi5PlmxoBE4YNyK2d3219aMMXZVo
         7RjUx3stbqkrlHLm3zNndygmBYpF506UYw0uoPnPStwO5Xa5t/U1QBwt2Q7l8jwe9P
         VzmJuJN9aSaA2z2F/5oUWIR1R5SJHMEVN8teR7upoZoLQqIn/qn9NY3OaweJjQl8si
         IbZpftWQjHOBA==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCH 1/4] tty: n_gsm: remove obsolete mknod doc example
Date:   Mon,  8 Jul 2019 21:02:49 +0200
Message-Id: <20190708190252.24628-1-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The n_gsm driver handles registration of /dev/gsmttyX nodes, so there's
no need to do mknod manually.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 Documentation/serial/n_gsm.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/serial/n_gsm.rst b/Documentation/serial/n_gsm.rst
index f3ad9fd26408..78f91ce06956 100644
--- a/Documentation/serial/n_gsm.rst
+++ b/Documentation/serial/n_gsm.rst
@@ -63,16 +63,6 @@ Major parts of the initialization program :
 	daemon(0,0);
 	pause();
 
-4. create the devices corresponding to the "virtual" serial ports (take care,
-   each modem has its configuration and some DLC have dedicated functions,
-   for example GPS), starting with minor 1 (DLC0 is reserved for the management
-   of the mux)::
-
-     MAJOR=`cat /proc/devices |grep gsmtty | awk '{print $1}`
-     for i in `seq 1 4`; do
-	mknod /dev/ttygsm$i c $MAJOR $i
-     done
-
 5. use these devices as plain serial ports.
 
    for example, it's possible:
-- 
2.22.0

