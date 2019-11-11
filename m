Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6702FF72C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKLJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 06:09:30 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:65317 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:09:29 -0500
IronPort-SDR: JVhqusIsfRZNFhM2Kq/l4ZZ+LTzuUI2X7q93hoiaSwgPlX4PtvRrYiS6qIzDiJAa+kLZbZksCg
 AWbr5/WYmpbFBs0w0g3A8YZ4Bi0O2SfW/x+sfSzaOLqTRXwBP8D9EDPJ8UB6PyNFhaifSoJ8kt
 ZfQFYv7vcrW3WU1ag8AqJ2mKT5bB3yzAcnciyKX2BHvw+I56OeiLE0vUAKtUvPoTL20/v+FNWD
 BOXZdgN31tq3JwlhpBzf/CAVW8pqOmhB1sLvAYA//6gx6k/0I6faw2yiSH9kB3bx/JsHWKqUp8
 DRU=
X-IronPort-AV: E=Sophos;i="5.68,292,1569312000"; 
   d="scan'208";a="43051107"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 11 Nov 2019 03:09:29 -0800
IronPort-SDR: Ljtjv3fR9c7VCXF6BWzclaR6POPzKc2fpoySZPWSobspxQvozd16o0PhBz+DrD1mfF+rvgwOly
 ZOiC9GtS97L5RpSfDMYVwZ2lgiBxMMCqwPU/KzMgK/RqgXVKa00MmgOkZYMpG2bx5+yD2ASQMm
 4+7ecwEpdOZvH3wgPH4L6z4cQlPc/lZdlbz81wHLInZm87OaCqncRoqEYGuT84YWKxF3gJTPPq
 lwGCZ1dwhxzCZVZKzy+ogg43Kdhshfl47DnBYOO8o9HgxfvWunyH4RmmbXeOplmbU0umkEJ0Ol
 w2k=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v3 1/7] ALSA: aloop: Describe units of variables
Date:   Mon, 11 Nov 2019 05:08:40 -0600
Message-ID: <20191111110846.18223-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
References: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

Describe the unit of the variables used to calculate the hw pointer
depending on jiffies ticks.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 9ccdad89c288..1f5982e09025 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -102,8 +102,10 @@ struct loopback_pcm {
 	/* flags */
 	unsigned int period_update_pending :1;
 	/* timer stuff */
-	unsigned int irq_pos;		/* fractional IRQ position */
-	unsigned int period_size_frac;
+	unsigned int irq_pos;		/* fractional IRQ position in jiffies
+					 * ticks
+					 */
+	unsigned int period_size_frac;	/* period size in jiffies ticks */
 	unsigned int last_drift;
 	unsigned long last_jiffies;
 	struct timer_list timer;
-- 
2.21.0

