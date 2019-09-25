Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA85CBE8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 01:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfIYXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 19:05:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32940 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbfIYXFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:05:08 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so1448365ior.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+b6H124ZTnuWVLwpA+w8I3lt6Bfem5vLH0ApPGFNuR4=;
        b=CEKaiLvSUKGkt9kJikJ4frh0/mKqeP2axdt/8who5BPBFIDeQM39dUFtxSf3ibq+XU
         t9DvdyOX/lF/ZfMY7hJi6Eizlu/gZEyxqUoRwvJKNLKrIq+f5BA2o8cIMfXOv/0S5SdM
         16CkWbqDTanlWQQK554kaOOzjZqaqneNE1aRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+b6H124ZTnuWVLwpA+w8I3lt6Bfem5vLH0ApPGFNuR4=;
        b=Ynuqs6bMmEuAuxf36+8rsL9pCgYl33sgZQiaaFJKnwPvT4TwquudaGXHt18IWqzB7d
         aycTeojaAjhbiANgyH4l0KNKqHDPr5GvuyUtR/FzwniX/cWqj2LI1MB35vt5A3lAhXwb
         Gif2cgm4F9HtsEFEYLUaaJNRIbiNLUlrNiZQuXVPUgLCwDYUv/9489P4kKSGxuglhQD1
         94bw3n+lfy32Z8nAa3hlNyJ+VfG6Evz1aefICvc3n8T3LtH5+Mmd5vGgvzbEl5wQbrf+
         Zf35mz9Mo373URTYQkztny0IEYW63swolBXZ2vWMVmZb3l4jYacaAVCepsEe2kSlagSC
         vTrQ==
X-Gm-Message-State: APjAAAW3NTAAXzEmQFvtDxa/q+r9RDGli4XjkjK3U+f3RrtgyuwzFLBK
        2WWd/7QFsel29OBE6SJRhNI2iw==
X-Google-Smtp-Source: APXvYqyjRRInxClK01iFOyoqVb48oB0vJYhbYNGchBjzPtQmKBhsAVGG+7+KJMKiPJZOg6kqgAf0+Q==
X-Received: by 2002:a02:ac82:: with SMTP id x2mr883743jan.18.1569452707372;
        Wed, 25 Sep 2019 16:05:07 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f23sm70767ioc.36.2019.09.25.16.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:05:06 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Makefile: Add kselftest_build target to build tests
Date:   Wed, 25 Sep 2019 17:04:34 -0600
Message-Id: <f13deab77f9e118bd290b6a978734871efac4bf2.1569452305.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1569452305.git.skhan@linuxfoundation.org>
References: <cover.1569452305.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kselftest_build target to build tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

Current kselftest target builds and runs tests on a development
system which is a developer use-case.

This change addresses requests from developers and testers to add
support for building from the main Makefile.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index d456746da347..ac4af6fc4b50 100644
--- a/Makefile
+++ b/Makefile
@@ -1233,6 +1233,10 @@ scripts_unifdef: scripts_basic
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
+PHONY += kselftest_build
+kselftest_build:
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests all
+
 PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
-- 
2.20.1

