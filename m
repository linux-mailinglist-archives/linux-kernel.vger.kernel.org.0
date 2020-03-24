Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A934191AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgCXU1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 16:27:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35026 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgCXU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:27:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id u68so9907027pfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Qj04WM6WV1292DERlnygQnUZFPOVeWCGyavY3CnVo0=;
        b=fXYNnIEJFXbsceM0cn/xg1RpPl8jXKwcjoLAfK0PWctuEX6zp2mL7GpQ0VFTmDdC+p
         oc6f7ZCKl/Gyhykq8+WeC7b80Lk4Fdl2h2Fz1EGZw5XUeSeuFjID6OWBqDXYtWLDUuPR
         s5cJykmdeB4VT3Heg521Cvd/i4LJ8J5ftkJek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Qj04WM6WV1292DERlnygQnUZFPOVeWCGyavY3CnVo0=;
        b=fCpryQsNypi9mUPw6d2eQfY1spvQEjn3VWqzMNl0Zqnpct08zuIutkTdA9dOuCC912
         DesnTkEXc5/tgqO2wgOE5vINJd8Kz3jNU4k1U+9JQslhiAN96KnxKQ7F3/9Lxl7EW/VD
         XNvkfjgHSxC6iLZmHGkfUX/1FGmrtd7MXPDA9Ayj8jI7JQ6m6jytuhag1rdwWT8KogiN
         iWYEzVvoFTy5FfzVnolmrUVhjuqHcxObjXg7m4JRaUc5X3e+HQeGsOdfIkGd0cFb8p6t
         3H/liTEhrPB1uxLMRD0QadzMZBFLu8FWGEGje9WqpHn2X3kMckpMQv3SKNNL35WG66Qr
         /dMA==
X-Gm-Message-State: ANhLgQ0CAv7ZCxn1AN5nzen+DM5cBupksj9a74WPd5j2rChqWm+lZvVB
        /lamcRWqwxjUycuSTdF9X5W2P9rucYM=
X-Google-Smtp-Source: ADFU+vvV6/M+B723trEGCiueLFYow5J7/7xqL4+vICG4fHYjhKVj5bqOHjB+yrQ/U37Fav1oYYRxLQ==
X-Received: by 2002:aa7:96c8:: with SMTP id h8mr25009032pfq.49.1585081668670;
        Tue, 24 Mar 2020 13:27:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id i23sm16760643pfq.157.2020.03.24.13.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:27:48 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 02/11] platform: chrome: sensorhub: Add code to spread timestmap
Date:   Tue, 24 Mar 2020 13:27:27 -0700
Message-Id: <20200324202736.243314-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200324202736.243314-1-gwendal@chromium.org>
References: <20200324202736.243314-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC FIFO can send sensor events in batch. Spread them based on
previous (TSa) and currnet timestamp (TSb)

  EC FIFO                             iio events
+-----------+
| TSa       |
+-----------+             +---------------------------------------+
| event 1   |             | event 1 | TSb - (TSb - TSa)/n * (n-1) |
+-----------+             +---------------------------------------+
| event 2   |             | event 2 | TSb - (TSb - TSa)/n * (n-2) |
+-----------+             +---------------------------------------+
|  ...      |  ------>    |  ....   |                             |
+-----------+             +---------------------------------------+
| event n-1 |             | event 2 | TSb - (TSb - TSa)/n         |
+-----------+             +---------------------------------------+
| event n   |             | event 2 | TSb                         |
+-----------+             +---------------------------------------+
| TSb       |
+-----------+

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v6:
  Comment fixes
Changes in v5:
  Added ack.
Changes in v4:
- Check patch with --strict option
    Alignement
No changes in v3.
Changes in v2:
- Use CROS_EC_SENSOR_LAST_TS instead of LAST_TS to avoid name colisions.

 .../platform/chrome/cros_ec_sensorhub_ring.c  | 112 ++++++++++++++++--
 1 file changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 436f306899252..efe726171bf00 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -189,6 +189,101 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 	return true;
 }
 
+/*
+ * cros_ec_sensor_ring_spread_add: Calculate proper timestamps then add to
+ * ringbuffer.
+ *
+ * If there is a sample with a proper timestamp
+ *
+ *                        timestamp | count
+ *                        -----------------
+ * older_unprocess_out --> TS1      | 1
+ *                         TS1      | 2
+ *                out -->  TS1      | 3
+ *           next_out -->  TS2      |
+ *
+ * We spread time for the samples [older_unprocess_out .. out]
+ * between TS1 and TS2: [TS1+1/4, TS1+2/4, TS1+3/4, TS2].
+ *
+ * If we reach the end of the samples, we compare with the
+ * current timestamp:
+ *
+ * older_unprocess_out --> TS1      | 1
+ *                         TS1      | 2
+ *                 out --> TS1      | 3
+ *
+ * We know have [TS1+1/3, TS1+2/3, current timestamp]
+ */
+static void cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
+					   unsigned long sensor_mask,
+					   s64 current_timestamp,
+					   struct cros_ec_sensors_ring_sample
+					   *last_out)
+{
+	struct cros_ec_sensors_ring_sample *out;
+	int i;
+
+	for_each_set_bit(i, &sensor_mask, BITS_PER_LONG) {
+		s64 older_timestamp;
+		s64 timestamp;
+		struct cros_ec_sensors_ring_sample *older_unprocess_out =
+			sensorhub->ring;
+		struct cros_ec_sensors_ring_sample *next_out;
+		int count = 1;
+
+		for (out = sensorhub->ring; out < last_out; out = next_out) {
+			s64 time_period;
+
+			next_out = out + 1;
+			if (out->sensor_id != i)
+				continue;
+
+			/* Timestamp to start with */
+			older_timestamp = out->timestamp;
+
+			/* Find next sample. */
+			while (next_out < last_out && next_out->sensor_id != i)
+				next_out++;
+
+			if (next_out >= last_out) {
+				timestamp = current_timestamp;
+			} else {
+				timestamp = next_out->timestamp;
+				if (timestamp == older_timestamp) {
+					count++;
+					continue;
+				}
+			}
+
+			/*
+			 * The next sample has a new timestamp, spread the
+			 * unprocessed samples.
+			 */
+			if (next_out < last_out)
+				count++;
+			time_period = div_s64(timestamp - older_timestamp,
+					      count);
+
+			for (; older_unprocess_out <= out;
+					older_unprocess_out++) {
+				if (older_unprocess_out->sensor_id != i)
+					continue;
+				older_timestamp += time_period;
+				older_unprocess_out->timestamp =
+					older_timestamp;
+			}
+			count = 1;
+			/* The next_out sample has a valid timestamp, skip. */
+			next_out++;
+			older_unprocess_out = next_out;
+		}
+	}
+
+	/* Push the event into the kfifo */
+	for (out = sensorhub->ring; out < last_out; out++)
+		cros_sensorhub_send_sample(sensorhub, out);
+}
+
 /**
  * cros_ec_sensorhub_ring_handler() - The trigger handler function
  *
@@ -300,10 +395,10 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 		goto ring_handler_end;
 
 	/*
-	 * Check if current_timestamp is ahead of the last sample.
-	 * Normally, the EC appends a timestamp after the last sample, but if
-	 * the AP is slow to respond to the IRQ, the EC may have added new
-	 * samples. Use the FIFO info timestamp as last timestamp then.
+	 * Check if current_timestamp is ahead of the last sample. Normally,
+	 * the EC appends a timestamp after the last sample, but if the AP
+	 * is slow to respond to the IRQ, the EC may have added new samples.
+	 * Use the FIFO info timestamp as last timestamp then.
 	 */
 	if ((last_out - 1)->timestamp == current_timestamp)
 		current_timestamp = fifo_timestamp;
@@ -323,9 +418,12 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 		}
 	}
 
-	/* Push the event into the FIFO. */
-	for (out = sensorhub->ring; out < last_out; out++)
-		cros_sensorhub_send_sample(sensorhub, out);
+	/*
+	 * Spread samples in case of batching, then add them to the
+	 * ringbuffer.
+	 */
+	cros_ec_sensor_ring_spread_add(sensorhub, sensor_mask,
+				       current_timestamp, last_out);
 
 ring_handler_end:
 	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
-- 
2.25.1.696.g5e7596f4ac-goog

