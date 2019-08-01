Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D097E030
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfHAQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:30:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57320 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfHAQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:30:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1htDwG-0005ho-R6; Thu, 01 Aug 2019 16:28:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: isa/wavefront: remove redundant assignment to pointer bptr
Date:   Thu,  1 Aug 2019 17:28:24 +0100
Message-Id: <20190801162824.32217-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer bptr is being assigned a value that is never read
and it is being updated in the next statement with a new value.
The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/wavefront/wavefront_synth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index aec1c46e6697..c5b1d5900eed 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -788,7 +788,6 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	dev->patch_status[header->number] |= WF_SLOT_FILLED;
 
-	bptr = buf;
 	bptr = munge_int32 (header->number, buf, 2);
 	munge_buf ((unsigned char *)&header->hdr.p, bptr, WF_PATCH_BYTES);
     
-- 
2.20.1

