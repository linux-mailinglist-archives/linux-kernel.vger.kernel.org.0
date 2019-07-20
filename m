Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA426EF46
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfGTMFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 08:05:55 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:30478 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfGTMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:05:55 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6KC5TD2027657;
        Sat, 20 Jul 2019 21:05:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6KC5TD2027657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563624330;
        bh=PlqRxZpGx0lOam9T/VREmCDkQVEbRoPfBxPqGOy+QWw=;
        h=From:To:Cc:Subject:Date:From;
        b=iG7FrbSfoyn7dFgAfshNE6gxv6mGNxGPGDUmcIFQqy/gHgLcMFDk5uREb0RqxGUT8
         s/+GFXYPaTrmOVnB1QFq7vVunnd/nxgVNddLUwp8rzTTwkZUjvzAduJT4ONPJiDPPX
         oKS0ztwIB0J2SaEXxGPx3E8dR4ym5mUzL/XN+fN/cMJfml0dvbFfHUR/PM3Go0fWSf
         JbqnXKfvzDSc2Xx21kKrgksPMCuwUVnjzIDK4oI55WbeqaCHk1JE5pMdW7mx6Z0wBA
         6UMdMwWKbUMaKXLNoBzn0tVIHjC5q54d9jPz9mQXw0arKXgi54IS+LZnukwRD72CKy
         IZr6s3uWkOh4Q==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: pg: add header include guard
Date:   Sat, 20 Jul 2019 21:05:25 +0900
Message-Id: <20190720120526.7722-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/linux/pg.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pg.h b/include/uapi/linux/pg.h
index 364c350e85cd..62b6f69bd9fb 100644
--- a/include/uapi/linux/pg.h
+++ b/include/uapi/linux/pg.h
@@ -35,6 +35,9 @@
 
 */
 
+#ifndef _UAPI_LINUX_PG_H
+#define _UAPI_LINUX_PG_H
+
 #define PG_MAGIC	'P'
 #define PG_RESET	'Z'
 #define PG_COMMAND	'C'
@@ -61,4 +64,4 @@ struct pg_read_hdr {
 
 };
 
-/* end of pg.h */
+#endif /* _UAPI_LINUX_PG_H */
-- 
2.17.1

