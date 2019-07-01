Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C918360FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 18:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfFEQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 12:16:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41321 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfFEQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:16:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so9719930plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xLM0D3C8CCsCt6msISf4AYmsTW1+yagPC3E2NizVr1U=;
        b=eaB5VOCIjRJZgBnHDYAAiEnU+dKOASsiuknjI+8nMZt6qESFv5ce4YIaRM0/hHRYGg
         0ms6tPoQtZZ6rTD9Z7eAgNCqXc1lkQUhYryZAPPuN/nTJczsnLpqX0zKdvbDAUpPzPDz
         TjL+4dVtFFckZwUPRCv13wmZ8AimRV+O9DmRI9UT+jVkXZ1/S0/WCEQTnRmocd2Sv2qs
         r+265XEt+GC7ywsBv3zzYQIE95PLnrV2HLavls4tD2Fm5w6Tj3SghLgDfT/ORzIB1vOA
         tyyFgdagSJhHmr/ovWBKL7UXCNofmueRkpdPwMhKFykRbFRklvOgZAPDU9fRTxU748Uf
         Wkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xLM0D3C8CCsCt6msISf4AYmsTW1+yagPC3E2NizVr1U=;
        b=Wcy9G8MB0kPw+05azltIwZXG7YnyuxNJFzRUY/aPg2GeSi9AwPwYQEhugBYn/5mvFe
         Q/5iSeDd6sJHq90K9P1TM+LQX49/gbzJajIrtlOudpEvQGbow9xBqZc9aPnNOphQh15m
         Zh2ii0tDps2OsEaJlCmDbbGichI0d/yUstSztMYzEK4Zkk6xJ6sQ2wXPQLJ8I7PecHjo
         1sM+xNgnOD5GjIRxxlXDIczM3W1ZIFCrj4+12Cbbk1TIwKJmCN/w+SjaUAsTlCZTGMCk
         SXherQYM5voksYyFNhcTsck4l//FVR7wZh+uWSpF3ZKmARZ/2ELVDmVS6KhBEDLmY7A+
         stlw==
X-Gm-Message-State: APjAAAV5pdrXnaiAiWmqjLqyRZ3kkKsgtCI7IqIVRxUfBLqC03cbWAvD
        XgX6IdMT4RSQ+J93QYOAhuV4fA==
X-Google-Smtp-Source: APXvYqxOSvAhSuJnewktzcBpiX3X81UGPPY1Ak2qX6BA7WHwwzKpmaL3neX4DgUhAAubG5li1OrIqA==
X-Received: by 2002:a17:902:16f:: with SMTP id 102mr2827830plb.94.1559751394983;
        Wed, 05 Jun 2019 09:16:34 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a16sm16090809pfc.167.2019.06.05.09.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:16:34 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Properly set the value of 'old' and 'head' in snapshot mode
Date:   Wed,  5 Jun 2019 10:16:33 -0600
Message-Id: <20190605161633.12245-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the necessay intelligence to properly compute the value
of 'old' and 'head' when operating in snapshot mode.  That way we can get
the latest information in the AUX buffer and be compatible with the
generic AUX ring buffer mechanic.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 127 +++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 911426721170..0a278bbcaba6 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -31,6 +31,8 @@ struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
 	struct perf_evlist	*evlist;
+	int			wrapped_cnt;
+	bool			*wrapped;
 	bool			snapshot_mode;
 	size_t			snapshot_size;
 };
@@ -536,16 +538,131 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	return 0;
 }
 
-static int cs_etm_find_snapshot(struct auxtrace_record *itr __maybe_unused,
+static int cs_etm_alloc_wrapped_array(struct cs_etm_recording *ptr, int idx)
+{
+	bool *wrapped;
+	int cnt = ptr->wrapped_cnt;
+
+	/* Make @ptr->wrapped as big as @idx */
+	while (cnt <= idx)
+		cnt++;
+
+	/*
+	 * Free'ed in cs_etm_recording_free().  Using realloc() to avoid
+	 * cross compilation problems where the host's system supports
+	 * reallocarray() but not the target.
+	 */
+	wrapped = realloc(ptr->wrapped, cnt * sizeof(bool));
+	if (!wrapped)
+		return -ENOMEM;
+
+	wrapped[cnt - 1] = false;
+	ptr->wrapped_cnt = cnt;
+	ptr->wrapped = wrapped;
+
+	return 0;
+}
+
+static bool cs_etm_buffer_has_wrapped(unsigned char *buffer,
+				      size_t buffer_size, u64 head)
+{
+	u64 i, watermark;
+	u64 *buf = (u64 *)buffer;
+	size_t buf_size = buffer_size;
+
+	/*
+	 * We want to look the very last 512 byte (chosen arbitrarily) in
+	 * the ring buffer.
+	 */
+	watermark = buf_size - 512;
+
+	/*
+	 * @head is continuously increasing - if its value is equal or greater
+	 * than the size of the ring buffer, it has wrapped around.
+	 */
+	if (head >= buffer_size)
+		return true;
+
+	/*
+	 * The value of @head is somewhere within the size of the ring buffer.
+	 * This can be that there hasn't been enough data to fill the ring
+	 * buffer yet or the trace time was so long that @head has numerically
+	 * wrapped around.  To find we need to check if we have data at the very
+	 * end of the ring buffer.  We can reliably do this because mmap'ed
+	 * pages are zeroed out and there is a fresh mapping with every new
+	 * session.
+	 */
+
+	/* @head is less than 512 byte from the end of the ring buffer */
+	if (head > watermark)
+		watermark = head;
+
+	/*
+	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
+	 */
+	watermark >>= 3;
+	buf_size >>= 3;
+
+	/*
+	 * If we find trace data at the end of the ring buffer, @head has
+	 * been there and has numerically wrapped around at least once.
+	 */
+	for (i = watermark; i < buf_size; i++)
+		if (buf[i])
+			return true;
+
+	return false;
+}
+
+static int cs_etm_find_snapshot(struct auxtrace_record *itr,
 				int idx, struct auxtrace_mmap *mm,
-				unsigned char *data __maybe_unused,
+				unsigned char *data,
 				u64 *head, u64 *old)
 {
+	int err;
+	bool wrapped;
+	struct cs_etm_recording *ptr =
+			container_of(itr, struct cs_etm_recording, itr);
+
+	/*
+	 * Allocate memory to keep track of wrapping if this is the first
+	 * time we deal with this *mm.
+	 */
+	if (idx >= ptr->wrapped_cnt) {
+		err = cs_etm_alloc_wrapped_array(ptr, idx);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Check to see if *head has wrapped around.  If it hasn't only the
+	 * amount of data between *head and *old is snapshot'ed to avoid
+	 * bloating the perf.data file with zeros.  But as soon as *head has
+	 * wrapped around the entire size of the AUX ring buffer it taken.
+	 */
+	wrapped = ptr->wrapped[idx];
+	if (!wrapped && cs_etm_buffer_has_wrapped(data, mm->len, *head)) {
+		wrapped = true;
+		ptr->wrapped[idx] = true;
+	}
+
 	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
 		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
 
-	*old = *head;
-	*head += mm->len;
+	/* No wrap has occurred, we can just use *head and *old. */
+	if (!wrapped)
+		return 0;
+
+	/*
+	 * *head has wrapped around - adjust *head and *old to pickup the
+	 * entire content of the AUX buffer.
+	 */
+	if (*head >= mm->len) {
+		*old = *head - mm->len;
+	} else {
+		*head += mm->len;
+		*old = *head - mm->len;
+	}
 
 	return 0;
 }
@@ -586,6 +703,8 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
+
+	zfree(&ptr->wrapped);
 	free(ptr);
 }
 
-- 
2.17.1

