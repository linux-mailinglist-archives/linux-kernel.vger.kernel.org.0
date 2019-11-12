Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4AF96E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKLRRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:17:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42976 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:17:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id s5so13802650pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VfkhaVR0FXWRYv7TUO3M4lLEIpTtvESy4tfTTW+/D0=;
        b=Eck9OkBWHfxSZjjibIiuQWO1WWXBY4jQiiMwqUVvTCjRd0kel/+JdOYcUC8CgQY/QM
         nVizBuNEQYMGHGXv4hMH5aVGNcAUQTx22lQqLRAj9r2rxyGLXUpzuI52FNm4y323K3wc
         Jn/KseHvjTJPLalBLwPWq2vgEngd54d0J6Cyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VfkhaVR0FXWRYv7TUO3M4lLEIpTtvESy4tfTTW+/D0=;
        b=k39WvhVKTmIv6X3Y/7yPoh7eU41enKG1igDAF5CTDmM5uG7LVOMsH0pUyzcP/5Jzg7
         97f0cZYzgrKWM2oYeXltoAHl9c1aLWEwpgTwcJdjPeiAuOL1oqD3t6+ci+0uAjRWc6DS
         4TCSB8+1JPkEpU8tbTfIse5L4IjwytqJ0sovQRP3OWQBG+NZV+vPipU4f7ohuQ4aPCee
         l8h3Fz+LCol34E02HNfAXNZAsQnUu472eYtTPNRPkATDUtJIuoE+9+uO8r1318V7l++h
         RHEyX7L5/rtTxPX/2R2BtJbM2a7kYgJaOaYhDnGUGqafMhIjWAM3EVVRkfWOs17GzwEN
         PWFg==
X-Gm-Message-State: APjAAAXraPsmyYxDTjfNT0kTg/e9jp2zNTvj0AIssPEZRlj7JSofET54
        q+RwNXA0Okmn0JvUm7qbxGn9ewyI+zQ=
X-Google-Smtp-Source: APXvYqxMdjhhO6SVolj4I3rxcxYKkIWLUqdmeXeWHxK0vphaxqGvLdDOrNkQo72JPu2mYsAK35CHtw==
X-Received: by 2002:a63:d10c:: with SMTP id k12mr37971418pgg.344.1573579052775;
        Tue, 12 Nov 2019 09:17:32 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:521e:3469:803b:9ad6])
        by smtp.gmail.com with ESMTPSA id a66sm19987305pfb.166.2019.11.12.09.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:17:32 -0800 (PST)
From:   paulhsia <paulhsia@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, paulhsia <paulhsia@chromium.org>
Subject: [PATCH 2/2] ALSA: pcm: Use stream lock in snd_pcm_detach_substream()
Date:   Wed, 13 Nov 2019 01:17:15 +0800
Message-Id: <20191112171715.128727-3-paulhsia@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112171715.128727-1-paulhsia@chromium.org>
References: <20191112171715.128727-1-paulhsia@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snd_pcm_detach_substream modifies the input substream, the
function should use stream lock to protect the modification section.

Signed-off-by: paulhsia <paulhsia@chromium.org>
---
 sound/core/pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 9a72d641743d..06da9cb8984a 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -980,8 +980,12 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
 
-	if (PCM_RUNTIME_CHECK(substream))
+	if (snd_BUG_ON(!substream))
 		return;
+
+	snd_pcm_stream_lock_irq(substream);
+	if (PCM_RUNTIME_CHECK(substream))
+		goto unlock;
 	runtime = substream->runtime;
 	if (runtime->private_free != NULL)
 		runtime->private_free(runtime);
@@ -1000,6 +1004,8 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	put_pid(substream->pid);
 	substream->pid = NULL;
 	substream->pstr->substream_opened--;
+ unlock:
+	snd_pcm_stream_unlock_irq(substream);
 }
 
 static ssize_t show_pcm_class(struct device *dev,
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

