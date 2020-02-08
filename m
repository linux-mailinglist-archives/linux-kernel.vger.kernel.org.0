Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497D21567FD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 23:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBHW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 17:28:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50232 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBHW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:28:05 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0YZw-0001Px-Iz; Sat, 08 Feb 2020 22:27:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: remove redundant assignment to variable timeout
Date:   Sat,  8 Feb 2020 22:27:56 +0000
Message-Id: <20200208222756.37707-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable timeout is being assigned with the value 200 that is never
read, it is assigned a new value in a following do-loop. The assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/hda_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 2609e391ce54..9765652a73d7 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -373,7 +373,7 @@ static int azx_get_sync_time(ktime_t *device,
 	u32 wallclk_ctr, wallclk_cycles;
 	bool direction;
 	u32 dma_select;
-	u32 timeout = 200;
+	u32 timeout;
 	u32 retry_count = 0;
 
 	runtime = substream->runtime;
-- 
2.25.0

