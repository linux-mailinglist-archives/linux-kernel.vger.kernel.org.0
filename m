Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93218E144A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbfJWIdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 04:33:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41253 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJWIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:33:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id c17so28104586qtn.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LxB/dOj9/Q2vnX34WoFXyS54SDk7wN/DgbHVBIh7I00=;
        b=T7wbuXEej6jROwY6K2YlAhyGg/OEKADXr1WD7HW4UVVe3W8qM7BJYvmqvHeXoC0qVL
         EwtzUtjbUHNFb67XNlNoD0NOcZkNWIJaW9WlL8V91qJfaCZlIY4gx79TayxjuE8PqJqZ
         pFGAVF29tcTZYtvLOrnyDk9WQWxJxB9ue38U9cluoQzGMDvRpM7BTjQNgtUKlaz6RKkS
         CNCbF8deIyyvFnK10Vlppj0fIkQ1ZWkUIb/kYzmPevRhtmzZm2QlwibweKCPg31LU495
         u9AdW7baM/1dYlzkxATPlJX34Hzff3Ri6c9gV7Q1i1YXsTQ5xOGi1bHdXPTGccGH1bbp
         V0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LxB/dOj9/Q2vnX34WoFXyS54SDk7wN/DgbHVBIh7I00=;
        b=ElJ/js/2pLTDcslr9IJz6k0HZKUt0HMwFSFAWM1ZxyOnGg+Gw2+kgxbhcWNHF2RiS0
         sIXC/DlO7Zma/DEfXv92u4GKXFLOMVSaG4/qZoWjUfyE5BB8cSXhU45niY1qmnkPMSFT
         OiCRnuwTo7fQQNxM/5OupgrT46n34v/fsA40Z+mMnpidOcxiyIBpXYRc1vn1m266Qot5
         B2gKfvTZWgneUOHx2BUCJ9bUTOP9pmvw3gYYxtN0xdYJbHwNe34QNP7I/5g+Poet654E
         +I9x9E/Z+Tlc5AfRLmYq8MFz8Tcp8Yx8223OaMWsOVUJZBdEcdnn6J+b0yiXvfrNE6ho
         bSDw==
X-Gm-Message-State: APjAAAW5IAN/gsNbgxUhBCyt6b8wiyPm3R4KgzTtR2diXpRsgk3XgMSy
        EqjVa6K+iBpMXp97+lzHexiHhA==
X-Google-Smtp-Source: APXvYqw13hOhkBzIJWvIhe0sehM0Iu1B6Tw7b+2977Icq+LSxF4t67M/3HEKg6pV2cc7fa1PW7ASog==
X-Received: by 2002:ac8:7289:: with SMTP id v9mr89344qto.139.1571819628071;
        Wed, 23 Oct 2019 01:33:48 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id h20sm8908288qtp.93.2019.10.23.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 01:33:46 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf tests: Fix a typo
Date:   Wed, 23 Oct 2019 16:33:24 +0800
Message-Id: <20191023083324.12093-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typo in comment: s/suck/stuck.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/bp_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 166f411568a5..415903b48578 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -295,7 +295,7 @@ bool test__bp_signal_is_supported(void)
 	 * breakpointed instruction.
 	 *
 	 * Since arm64 has the same issue with arm for the single-step
-	 * handling, this case also gets suck on the breakpointed
+	 * handling, this case also gets stuck on the breakpointed
 	 * instruction.
 	 *
 	 * Just disable the test for these architectures until these
-- 
2.17.1

