Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79D4BD314
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 21:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632990AbfIXTwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 15:52:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42525 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfIXTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:52:40 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so7466552iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOnpOcgSk5NX5LvkWHWvLf5kiHdtooLHIMsu7TMjUxI=;
        b=RFzpzm9U/FsxED0LFp9Fp+Mj4jRg7GqvNmOO+9whCApw4/WFURWolT+VRG9v+OWbPc
         l7N3w67EPii/OkFXjP4gTcNruVsJjMcPfxmI6GOsKOSHp1Q4jkLP8yQ4KH6LzWsBIuAM
         XGty4konqFPtGgc8WZCm0YXM2ySxl/Y2U3+UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOnpOcgSk5NX5LvkWHWvLf5kiHdtooLHIMsu7TMjUxI=;
        b=gP4Kgzw7KirvCHLDTumaAJlenZw0AGJ6HqH6XxYtIxj8Y+/adYf+sCjhFsAkW76rOw
         oU82r7cr3KC3guZlP+hs1JMHaAS4HaMbrICCnX2muYEchRPXxgpyr6I/mhbdyqhEM9Ks
         5IOmXhnSTp9gXjuWT2HAAHl2uB6Lc5Y/l2TkPOztLFgSEMubv0/ZvPG0p7YVbVdLDlgz
         w4bqiekzDGfO0uEl7pmXZpZ2igGT0hMFST60qNu4MydkyB4epa7rxzkLMFcgNkGfwsYh
         wH+Z/2jLzfV9aVZkFHwILwiNyZHUWN0dclYP0KwarVlo4i2m5UpFCLhpCVUhE7L87v9U
         Dqpw==
X-Gm-Message-State: APjAAAUGk013kkXnT+gnhHcZ9fHy2AhyA4kF9/n1UZ0Ft0Agzpnuu7Ls
        9fUXoXhsKEVx9NbqCuMmvrComA==
X-Google-Smtp-Source: APXvYqyjabRdDMqnPKETR4eIRTr/iHS+Ld3WozdWwgpQwZPNqMT0cSOe8xrIAyxGOeds8ZPHUKrP8Q==
X-Received: by 2002:a05:6638:1f5:: with SMTP id t21mr571908jaq.119.1569354759536;
        Tue, 24 Sep 2019 12:52:39 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g8sm1949257ioc.0.2019.09.24.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:52:39 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     christian@brauner.io, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: pidfd: Fix undefined reference to pthread_create()
Date:   Tue, 24 Sep 2019 13:52:37 -0600
Message-Id: <20190924195237.30519-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build failure:

undefined reference to `pthread_create'
collect2: error: ld returned 1 exit status

Fix CFLAGS to include pthread correctly.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/pidfd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 464c9b76148f..7550f08822a3 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g -I../../../../usr/include/ -lpthread
+CFLAGS += -g -I../../../../usr/include/ -pthread
 
 TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test pidfd_wait
 
-- 
2.20.1

