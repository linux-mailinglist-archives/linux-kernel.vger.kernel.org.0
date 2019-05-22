Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D81F2682B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfEVQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 12:25:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39749 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfEVQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:25:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so2858578wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AztR0YxQPjo+dl6FLzdHONEyjeweZt0zVC2E221XWlQ=;
        b=FQFZQ5pLhc3+G+tTnarBWj9uCgHvf6MQVBOxmiQB84MjmbRYL3d9lr0xad3tVwk8Us
         KBrk17D7HVu1WMERpxk6odDZFQxiXDopaksQeKlUNuYq7ZyHbsKfDGBajoJYU8L1O9Lp
         iCjUt7y3UsBPgcPyZ9PlKEefGwcj5aKUxuSOclGe3gowAl3nU5/Ney9Q3IodZ7ZbGWTS
         24uMV/lfJ01p2zjjMsk54w8H7v7gA6bNoMNIR//+Z/SHeppmnhUqCuZsW1ZS0QZEpBSw
         CEwgWTUze6dsp6PxquA3kWgBIxrU8SuBShC89UFH77qqyEnAoFfQTaSw9H7snGzQACyQ
         gV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AztR0YxQPjo+dl6FLzdHONEyjeweZt0zVC2E221XWlQ=;
        b=G/JTZhsdtqKYrJrp6DIdk9YgQBfQhNFjseFUUOx9vIiteKFtxP63jdWkS6b7uUxQI8
         MGqTU7e2nrAqk5TRF0T7HGmfZsQHAXRnMgTEvHQpd5Oc76UQHhhe1P1KbmYBcPRVhnrt
         0KVaPu5VYz58g+haaWSoWjbYp+3xTMLR6S1OiYslYZDolpNjGgbrHbiy9vqBu9jmEWlp
         987MYdpZpGJg4noNsDy8wxu83IqeI7zzXFwXc+yK9HXBDEx2QKIpOqE/QLBjFYQdqkUo
         vYT/0XFMJQ5Chi4ID9N+yipvc1zqyyK2aNy53NU+lY5+x3kbt7ibm0OfMU6HaK0LoPH+
         L+KQ==
X-Gm-Message-State: APjAAAUCkv8XcQG/Itc7HhAHkZ49KiDK1Up2HRY6kDGJffvFOgTQT77E
        EZbru13upd0NlNDjJzJn+Nx9JQ==
X-Google-Smtp-Source: APXvYqwIODKI5c57KNCc8y6bUOIDanKrY+1pmIzGXwTstBFshTpXKRLQcFKf9Vf1xDgV4/+VGDHmmg==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr7976175wmg.117.1558542335118;
        Wed, 22 May 2019 09:25:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q15sm8462720wrr.19.2019.05.22.09.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:25:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: stream: fix bad unlock balance
Date:   Wed, 22 May 2019 17:25:28 +0100
Message-Id: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning due to unlocking without locking.

 =====================================
 WARNING: bad unlock balance detected!
 5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
 -------------------------------------
 aplay/2954 is trying to release lock (&bus->msg_lock) at:
 do_bank_switch+0x21c/0x480
 but there are no more locks to release!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 544925ff0b40..d16268f30e4f 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -814,7 +814,8 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			goto error;
 		}
 
-		mutex_unlock(&bus->msg_lock);
+		if (mutex_is_locked(&bus->msg_lock))
+			utex_unlock(&bus->msg_lock);
 	}
 
 	return ret;
-- 
2.21.0

