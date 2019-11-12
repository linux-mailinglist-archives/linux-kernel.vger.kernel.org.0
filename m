Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04322F96E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLRR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:17:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42235 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:17:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so12257689pgt.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xxRHw6/3z9e2nyAGWJzoGw1p/LSUOxTCybLFFSHdxw=;
        b=Xo8QS0SVtI4s+qaYHPpfI6h/nZGf1AlXbz0BoZb5ocvmRZg5XXoB5+wcMAyVAIAT4Z
         6mOUpWbWGIxouNJip901iGjMT/tYzksw+PDPsnhrNCTR4JdUmFaXIM8BlOPBvAcYlydI
         6L0cTwTfHYVxSDbY8oDzkzZ8Md+upvqGK6Gag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xxRHw6/3z9e2nyAGWJzoGw1p/LSUOxTCybLFFSHdxw=;
        b=e6PmeIju0unEnObOf3n9bFuZTAcvq5QPfuXMyDihyfLL4b89FavxwG+jQcj23CUjzS
         9PNtBwHKb73CL/3kk+BFrCvXc4nIV3D/9uiyRTzHLfrMGZ1Yt3Wsr1jKRnmYjVkFRPX8
         o21BrcowfEji2E35nYYwc9fc4FwHLbgczx+lE8BpMebCzPIwwc/6pfgvw4xzRjij87qb
         mVKsg+gZNfV0YwsmslQw7+Ojmij2vGeyZwIq+Nufi8fZ6pKmT+Tb6r6CXKBYXNyYJfWF
         8Czm9jrEKFkS3bztlY6OrmzEu1iruEd4iYPuWTPblTVWAoZvW018M257CvGn29JuVTuX
         1aLQ==
X-Gm-Message-State: APjAAAUNaskL7SSNi9GxWfjAwvp8W6SNEa+e863prreG7SQ/1BlWFhlp
        gZlPWFs7BYp2QJGnv+O6J8A11TFsP14=
X-Google-Smtp-Source: APXvYqzcgPkS4O6FeQTFiG7nNrQjhKqrGzeupyYwb4ad78uCvoMVN7a8JupAU0W1pAEsMoCbCdlhqQ==
X-Received: by 2002:a17:90a:9604:: with SMTP id v4mr7820912pjo.105.1573579047795;
        Tue, 12 Nov 2019 09:17:27 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:521e:3469:803b:9ad6])
        by smtp.gmail.com with ESMTPSA id h195sm3262634pfe.88.2019.11.12.09.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:17:27 -0800 (PST)
From:   paulhsia <paulhsia@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, paulhsia <paulhsia@chromium.org>
Subject: [PATCH 1/2] ALSA: pcm: Fix stream lock usage in snd_pcm_period_elapsed()
Date:   Wed, 13 Nov 2019 01:17:14 +0800
Message-Id: <20191112171715.128727-2-paulhsia@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112171715.128727-1-paulhsia@chromium.org>
References: <20191112171715.128727-1-paulhsia@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the nullity check for `substream->runtime` is outside of the lock
region, it is possible to have a null runtime in the critical section
if snd_pcm_detach_substream is called right before the lock.

Signed-off-by: paulhsia <paulhsia@chromium.org>
---
 sound/core/pcm_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index d80041ea4e01..2236b5e0c1f2 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1782,11 +1782,14 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime;
 	unsigned long flags;
 
-	if (PCM_RUNTIME_CHECK(substream))
+	if (snd_BUG_ON(!substream))
 		return;
-	runtime = substream->runtime;
 
 	snd_pcm_stream_lock_irqsave(substream, flags);
+	if (PCM_RUNTIME_CHECK(substream))
+		goto _unlock;
+	runtime = substream->runtime;
+
 	if (!snd_pcm_running(substream) ||
 	    snd_pcm_update_hw_ptr0(substream, 1) < 0)
 		goto _end;
@@ -1797,6 +1800,7 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 #endif
  _end:
 	kill_fasync(&runtime->fasync, SIGIO, POLL_IN);
+ _unlock:
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
 }
 EXPORT_SYMBOL(snd_pcm_period_elapsed);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

