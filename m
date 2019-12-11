Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517E9119FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 01:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfLKAMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 19:12:55 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34725 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfLKAMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:12:54 -0500
Received: by mail-il1-f194.google.com with SMTP id w13so17845764ilo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 16:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2fl9QR6o36vp9A0Aj5OVE7v+t2aBYbEj7pCkzXK8nE=;
        b=AsZ9BorgoArKzuchiMnPHv8a9XEmFlTe8j9/S+IoZiutTx2yNeoxbCDMKhg/nbYMRN
         N+82KB06UY+qFj9v7MSue/MsPyx2Vk54g5wCvjcGKZENTZobR9n60NFZguf5lHGVXRVJ
         X96ruQW0yk5Oy8cigduvH8H4lq6Nw1LqL7AiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2fl9QR6o36vp9A0Aj5OVE7v+t2aBYbEj7pCkzXK8nE=;
        b=MeZjn0JD9JdBU2IFYckAnfxL28KIqloiLvroOjcIkz6K74YTgtdmPBTjgPPfL8cDXL
         yN56Qp35mTQL+O/BXllk+L+wY/oZ3XuAXnfC57UZYYd6L7jZQm6WXij8JyPLYQJSAAF+
         AmTuNoWiaYSiX5EPjcAgv/QIK0KNdOCeuJ6zxeCqH8rTKnzat7FC89vgZUsNLK/s7K/P
         dN9gM0U93EX0gX/1ekyilURVk39QyYOICuhsYtmqVSuuXOCRrtkQadyYSskMcw82sJMA
         PU08DqbfcBnwdnuqLgCfILcx9SENuW4a/sJtp6RCIC+NzVU8VGDyU38alK5CvE0j5oos
         WHHQ==
X-Gm-Message-State: APjAAAVPCVteDZgMmRTCBrAweGUUoZk/PoNNS6uv5oxqIWyXXcoCzHrO
        YHNoUKlyTARmvZJ9w+wlSAgGZw==
X-Google-Smtp-Source: APXvYqyOdfbfQMpzudpUr1aIIDIe4llBDz7VcMb2Q3S3pU9n1xO3zK4abinDSmnB8UvSEfLdWNt+PA==
X-Received: by 2002:a92:4883:: with SMTP id j3mr394216ilg.272.1576023173702;
        Tue, 10 Dec 2019 16:12:53 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v5sm102092iob.61.2019.12.10.16.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 16:12:52 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, r@hev.cc, rpenyaev@suse.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, christian@brauner.io,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: filesystems/epoll: fix build error
Date:   Tue, 10 Dec 2019 17:12:33 -0700
Message-Id: <20191211001233.15084-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

epoll build fails to find pthread lib. Fix Makefile to use LDLIBS
instead of LDFLAGS. LDLIBS is the right flag to use here with -l
option when invoking ld.

gcc -I../../../../../usr/include/  -lpthread  epoll_wakeup_test.c  -o .../tools/testing/selftests/filesystems/epoll/epoll_wakeup_test
/usr/bin/ld: /tmp/ccaZvJUl.o: in function `kill_timeout':
epoll_wakeup_test.c:(.text+0x4dd): undefined reference to `pthread_kill'
/usr/bin/ld: epoll_wakeup_test.c:(.text+0x4f2): undefined reference to `pthread_kill'
/usr/bin/ld: /tmp/ccaZvJUl.o: in function `epoll9':
epoll_wakeup_test.c:(.text+0x6382): undefined reference to `pthread_create'
/usr/bin/ld: epoll_wakeup_test.c:(.text+0x64d2): undefined reference to `pthread_create'
/usr/bin/ld: epoll_wakeup_test.c:(.text+0x6626): undefined reference to `pthread_join'
/usr/bin/ld: epoll_wakeup_test.c:(.text+0x684c): undefined reference to `pthread_tryjoin_np'
/usr/bin/ld: epoll_wakeup_test.c:(.text+0x6864): undefined reference to `pthread_kill'
/usr/bin/ld: epoll_wakeup_test.c:(.text+0x6878): undefined reference to `pthread_join'

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/filesystems/epoll/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/epoll/Makefile b/tools/testing/selftests/filesystems/epoll/Makefile
index e62f3d4f68da..78ae4aaf7141 100644
--- a/tools/testing/selftests/filesystems/epoll/Makefile
+++ b/tools/testing/selftests/filesystems/epoll/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I../../../../../usr/include/
-LDFLAGS += -lpthread
+LDLIBS += -lpthread
 TEST_GEN_PROGS := epoll_wakeup_test
 
 include ../../lib.mk
-- 
2.20.1

