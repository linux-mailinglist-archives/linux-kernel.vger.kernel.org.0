Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B2BD1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfIXSTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 14:19:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38747 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIXSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:19:14 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so6808194iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dWtz09nJO4hFU7Ulq0JLtoYNZLA+KfaYtQXCXTt8ow=;
        b=aEk5PLemQu3DgvDBiFMMxF0WeEEMuwlfRHEddND4uzLcLivGLNgDaT5IU43kMbT5ph
         N7VsheGN2yCC6LYOt9wqz8b4K/g4XdHbho+7vwCvHNsEKy5tVCcwyAZU22JJAouMQj68
         PGELCCvhTictzhHBYPoL2gmJuHbyFgthyNw54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dWtz09nJO4hFU7Ulq0JLtoYNZLA+KfaYtQXCXTt8ow=;
        b=s+/cZmEVKCcsGVI+3Q/IZPQUQBE4kK20JG2qfleem8dWZR0ilgrylw4fhu+/ezqd1f
         4iC2loglCLtqvoQ68P/JF+0GoGNaAZlhLCnz6qsKgZWdkM2YD1wB84R5YGqhinkHPgrY
         9cH27vdSLD5+K7cCmqFq84fUw+ykykgI7Kfv3dnbZuDzlh8xc2zIlZeHCFXr8NwXzNYX
         kE2VnQ+IaT588Z9GZ/19xXlt2QxLX/0ugly5mDMx0ucEDDjg9nQg60XqQVSbm+PR6b/m
         OwKlS+4THxMOULnGN7civ4qCWry1q2jTUDOYNE3SL8vS+yCBHmjCpCcLWnOJ9uhvXANU
         xDOQ==
X-Gm-Message-State: APjAAAXnjysWEtLgxiyN+eNMjoa7a0wcXFvewMQO3XUj3dJbIg+SA7Ts
        VTTQFG9A6Hmi7cxv6P/h2GhM6CpPqsw=
X-Google-Smtp-Source: APXvYqw5G9w1Hq0izxonTjGpA6+o4/plQtNgcgvfah4SR3PZtF0+mIvnQk9AvTg1fLFlJEW7wBxAtQ==
X-Received: by 2002:a02:5585:: with SMTP id e127mr107945jab.25.1569349153357;
        Tue, 24 Sep 2019 11:19:13 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w7sm3627033iob.17.2019.09.24.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 11:19:12 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org, rfontana@redhat.com,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: execveat: Fix _GNU_SOURCE redefined build warn
Date:   Tue, 24 Sep 2019 12:19:09 -0600
Message-Id: <20190924181910.23588-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following _GNU_SOURCE redefined build warn:

execveat.c:8: warning: "_GNU_SOURCE" redefined

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
No code changes. Sending to right people.

 tools/testing/selftests/exec/execveat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index cbb6efbdb786..045a3794792a 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -5,7 +5,9 @@
  * Selftests for execveat(2).
  */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE  /* to get O_PATH, AT_EMPTY_PATH */
+#endif
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
-- 
2.20.1

