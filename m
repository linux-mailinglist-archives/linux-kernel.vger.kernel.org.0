Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE22156812
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 23:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBHWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 17:42:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50305 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgBHWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:42:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0Yne-00026V-Lx; Sat, 08 Feb 2020 22:42:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: info: remove redundant assignment to variable c
Date:   Sat,  8 Feb 2020 22:42:06 +0000
Message-Id: <20200208224206.38540-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable c is being assigned with the value -1 that is never read,
it is assigned a new value in a following while-loop. The assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index ca87ae4c30ba..8c6bc5241df5 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -604,7 +604,7 @@ int snd_info_card_free(struct snd_card *card)
  */
 int snd_info_get_line(struct snd_info_buffer *buffer, char *line, int len)
 {
-	int c = -1;
+	int c;
 
 	if (snd_BUG_ON(!buffer || !buffer->buffer))
 		return 1;
-- 
2.25.0

