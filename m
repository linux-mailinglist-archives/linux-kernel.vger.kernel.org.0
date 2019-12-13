Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3211E51E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfLMOBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 09:01:20 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43816 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfLMOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:01:19 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 2BE442417E0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:01:18 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 6CB86C20BC7; Fri, 13 Dec 2019 14:56:12 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v3 08/10] PCMCIA/i82092: include <linux/io.h> instead of <asm/io.h>
Date:   Fri, 13 Dec 2019 14:53:12 +0100
Message-Id: <20191213135311.9111-9-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213135311.9111-1-simon.geis@fau.de>
References: <20191213135311.9111-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the more general linux/io.h instead of asm/io.h
as checkpatch suggests.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 7c9749df47d8..5d7d04657b6d 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -18,7 +18,7 @@
 
 #include <pcmcia/ss.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "i82092aa.h"
 #include "i82365.h"
-- 
2.20.1

