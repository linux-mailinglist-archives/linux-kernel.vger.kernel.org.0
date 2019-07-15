Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D056169B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfGOTKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 15:10:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33448 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfGOTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:10:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so7877554pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+w68P/RflnycNPzaHgCc3KB0ps9CtDDZmOzM+ZuWKXw=;
        b=LUafB6tHMlY5qgFlhZWCnF9qkr7gq1BPTvu5+XkTX7zuet7c9EwLBeiZuGWZNyyaz4
         NbHH3oIvOoGkdZcmFwUF1EQ+iSz+vrlDPsO2oaYM4p2MQoGxp4ne3b8+9xTGVP5MXqnU
         IBrOenpyTjpPpwS5Capq7uJCk/vavwO4V1qBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+w68P/RflnycNPzaHgCc3KB0ps9CtDDZmOzM+ZuWKXw=;
        b=bCh6iI+VpW3yd+9K7smboqT4ZPwsh0ysDNoE9RkQviHlbUuhhLY5GG4rfhTp1sisL3
         pvRWic8iRly7VJME4bAK3GjycJnDI2ZF6cMKbL62c3r/IyY/GqJ1D7h622CJpdry//rs
         pBRsuHxHKXtrUj+MAhlcF0IyrpuPo/nz5QQlacsDmzlb0azYIo4i0PqM7pfceNv8avu8
         o4V0b+v2zYgWSFh/WKylvzX+63aqcFMyeAKYkqRwCFHSjCb1DdbUyOwsZ4xd2ZCd+17s
         7d/k/LqI1JxFYB0uBPfxvh/ggmFOvUvnNJTbSHmZc0Gz2+NG0t+muHNS6fYsVRarb0cZ
         MmWw==
X-Gm-Message-State: APjAAAUeVxAx4GnrKIgxDDVGoXa1NyhqR0ATbfXj4HvAIZP7HqOC6Evk
        veUfKeDdHDnVuroeWhIN2vcs1w==
X-Google-Smtp-Source: APXvYqzWfg6LLQbsHj2G2tia2ocmOfcuud7JEZ1ygUWjKr+Bqe/CimGgh9XM/QoOMv6LVAkRUsTgqQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr28193637pgd.241.1563217823684;
        Mon, 15 Jul 2019 12:10:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j6sm22960102pjd.19.2019.07.15.12.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:10:23 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] iio: cros_ec_accel_legacy: Always release lock when returning from _read()
Date:   Mon, 15 Jul 2019 12:10:17 -0700
Message-Id: <20190715191017.98488-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before doing any actual work cros_ec_accel_legacy_read() acquires
a mutex, which is released at the end of the function. However for
'calibbias' channels the function returns directly, without releasing
the lock. The next attempt to acquire the lock blocks forever. Instead
of an explicit return statement use the common return path, which
releases the lock.

Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 46bb2e421bb9..27ca4a64dddf 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -206,7 +206,8 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		/* Calibration not supported. */
 		*val = 0;
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.22.0.510.g264f2c817a-goog

