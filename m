Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819E21162FA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 17:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLHQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 11:19:02 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49666 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbfLHQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:19:01 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 0BD8A2415E8;
        Sun,  8 Dec 2019 17:19:00 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id EDDA9C20BCE; Sun,  8 Dec 2019 17:18:59 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 10/12] PCMCIA: include <linux/io.h> instead of <asm/io.h>
Date:   Sun,  8 Dec 2019 17:18:44 +0100
Message-Id: <20191208161844.22017-2-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index fcc0d8a4209d..fb2654a95f28 100644
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

