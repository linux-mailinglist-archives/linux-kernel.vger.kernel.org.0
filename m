Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9949BD795F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbfJOPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 11:03:17 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51371 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfJOPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:03:17 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKOLu-0005j5-VJ; Tue, 15 Oct 2019 16:03:11 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKOLu-0004Wp-A0; Tue, 15 Oct 2019 16:03:10 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: musb: fix __iomem in trace functions
Date:   Tue, 15 Oct 2019 16:03:09 +0100
Message-Id: <20191015150309.17364-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace functions should have __iomem on the addr
pointers. Add __iomem to avoid the following warnings
from sparse:

drivers/usb/musb/musb_core.c:253:55: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:253:55:    expected void const *addr
drivers/usb/musb/musb_core.c:253:55:    got void const [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:259:56: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:259:56:    expected void const *addr
drivers/usb/musb/musb_core.c:259:56:    got void [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:267:55: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:267:55:    expected void const *addr
drivers/usb/musb/musb_core.c:267:55:    got void const [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:273:56: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:273:56:    expected void const *addr
drivers/usb/musb/musb_core.c:273:56:    got void [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:383:55: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:383:55:    expected void const *addr
drivers/usb/musb/musb_core.c:383:55:    got void const [noderef] <asn:2> *addr
drivers/usb/musb/musb_core.c:390:56: warning: incorrect type in argument 2 (different address spaces)
drivers/usb/musb/musb_core.c:390:56:    expected void const *addr
drivers/usb/musb/musb_core.c:390:56:    got void [noderef] <asn:2> *addr

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/musb/musb_trace.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_trace.h b/drivers/usb/musb/musb_trace.h
index a97d618fe8ff..b193daf69685 100644
--- a/drivers/usb/musb/musb_trace.h
+++ b/drivers/usb/musb/musb_trace.h
@@ -38,11 +38,12 @@ TRACE_EVENT(musb_log,
 );
 
 DECLARE_EVENT_CLASS(musb_regb,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u8 data),
+	TP_PROTO(void *caller, const void  __iomem *addr,
+		 unsigned int offset, u8 data),
 	TP_ARGS(caller, addr, offset, data),
 	TP_STRUCT__entry(
 		__field(void *, caller)
-		__field(const void *, addr)
+		__field(const void __iomem *, addr)
 		__field(unsigned int, offset)
 		__field(u8, data)
 	),
@@ -57,21 +58,24 @@ DECLARE_EVENT_CLASS(musb_regb,
 );
 
 DEFINE_EVENT(musb_regb, musb_readb,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u8 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u8 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DEFINE_EVENT(musb_regb, musb_writeb,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u8 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u8 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DECLARE_EVENT_CLASS(musb_regw,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u16 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u16 data),
 	TP_ARGS(caller, addr, offset, data),
 	TP_STRUCT__entry(
 		__field(void *, caller)
-		__field(const void *, addr)
+		__field(const void __iomem *, addr)
 		__field(unsigned int, offset)
 		__field(u16, data)
 	),
@@ -86,21 +90,24 @@ DECLARE_EVENT_CLASS(musb_regw,
 );
 
 DEFINE_EVENT(musb_regw, musb_readw,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u16 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u16 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DEFINE_EVENT(musb_regw, musb_writew,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u16 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u16 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DECLARE_EVENT_CLASS(musb_regl,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u32 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u32 data),
 	TP_ARGS(caller, addr, offset, data),
 	TP_STRUCT__entry(
 		__field(void *, caller)
-		__field(const void *, addr)
+		__field(const void __iomem *, addr)
 		__field(unsigned int, offset)
 		__field(u32, data)
 	),
@@ -115,12 +122,14 @@ DECLARE_EVENT_CLASS(musb_regl,
 );
 
 DEFINE_EVENT(musb_regl, musb_readl,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u32 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u32 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
 DEFINE_EVENT(musb_regl, musb_writel,
-	TP_PROTO(void *caller, const void *addr, unsigned int offset, u32 data),
+	TP_PROTO(void *caller, const void __iomem *addr,
+		 unsigned int offset, u32 data),
 	TP_ARGS(caller, addr, offset, data)
 );
 
-- 
2.23.0

