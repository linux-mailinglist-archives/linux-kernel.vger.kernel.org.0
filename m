Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55168EFFE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbfKEOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:34:00 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:56726 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389702AbfKEOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:33:59 -0500
IronPort-SDR: dDp/r6zJOZBQRbtkqo4/4Dltc+zCpq2dj9rARBo8olag33hlDboK+d0fY9OUZ0efUIFo77cQCf
 yjLrQV7XxQ6uJEfmj92jSxDLJGWHEZxM84/G3K4EoFMyCAzGntZcv0t827MgcrdRl5gxy/kx9f
 TU1eFIoKzRTNzQvCdVfh/yhhucZjmT+OwEeW316CSiQxo2eHdE0lfS1nsVXfNf411IWFpGuGhX
 G4T4SIQE1nNDS1c2fkt41THSjDuj/+RiTOOAiAxOyMgpLc6ViI8alH4+ekidDD41YMPXU7yxhf
 hhQ=
X-IronPort-AV: E=Sophos;i="5.68,271,1569312000"; 
   d="scan'208";a="44730616"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 05 Nov 2019 06:33:58 -0800
IronPort-SDR: qjebKaLnrsPkMpPO+bqlb4ZUFikKKsuV6qLx0X33fJ9CyK6rnqiKzlpyIn4NfiQsDDJ1ZRjJU1
 yoTEvNcyJq7KB2W16812TynYTQ5p4KVtd2zTeJqDtnET7JITaLxqqRMf6hlCYRJXAplcE+X1nx
 1A2F6vGsvo566KlHPTXupHTditAVIXn/uXbl4J4F0hlHrQTm26gR+NKMYZbseSXKrPeqoPxZdP
 6TV5zSKr1mjCxXEYZtmPKjbgdrly7aJLtW+r+zIB5pHtY/ZZp5jb7NymgvBbxvolbjsCIAZUW1
 PQc=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v2 1/8] ALSA: aloop: Describe units of variables
Date:   Tue, 5 Nov 2019 08:32:11 -0600
Message-ID: <20191105143218.5948-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
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

