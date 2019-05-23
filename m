Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A885028BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfEWUvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 16:51:09 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.104]:18369 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387894AbfEWUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:51:08 -0400
X-Greylist: delayed 1309 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2019 16:51:08 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 324496CE03
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 15:29:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TuL1hXirYdnCeTuL1hDcUO; Thu, 23 May 2019 15:29:19 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=34524 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTuL0-000Lzk-50; Thu, 23 May 2019 15:29:18 -0500
Date:   Thu, 23 May 2019 15:29:17 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: Use struct_size() helper
Message-ID: <20190523202917.GA12595@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTuL0-000Lzk-50
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:34524
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(struct rate_priv) + src_format->channels * sizeof(struct rate_channel)

with:

struct_size(data, channels, src_format->channels)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/oss/rate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/oss/rate.c b/sound/core/oss/rate.c
index 2fa9299a440d..7cd09cef6961 100644
--- a/sound/core/oss/rate.c
+++ b/sound/core/oss/rate.c
@@ -323,8 +323,8 @@ int snd_pcm_plugin_build_rate(struct snd_pcm_substream *plug,
 
 	err = snd_pcm_plugin_build(plug, "rate conversion",
 				   src_format, dst_format,
-				   sizeof(struct rate_priv) +
-				   src_format->channels * sizeof(struct rate_channel),
+				   struct_size(data, channels,
+					       src_format->channels),
 				   &plugin);
 	if (err < 0)
 		return err;
-- 
2.21.0

