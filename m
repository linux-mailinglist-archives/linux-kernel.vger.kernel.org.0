Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3C43A44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfFMPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:19:55 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42186 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbfFMNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:00:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id t11so17429106qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=50HPP5ae9Rk5gHtTtValAbuIThOVqS9Fd5PO1+T5JvA=;
        b=WxypDLVbBAfE13MFgePdX+CWOGBL59QQhxucPOnfUn9bEFOjXnolus3qQ8ZmWtCw6s
         SCrpFyB3fT9ag/8PqR13C9ZauaEIPUCXzuHQ/AcvW3HxtFZ2Fd4wz6yArHaJr4le5KOR
         iQuXgd2bXp4vOS8Pj+qPboTPmSxSIMAJzVcCnHAxlXFRZHjn9rrCge/EoM5iRfM45K83
         4cben+VtMPlxkjL1u67eNT/nJTF3/yxpqlfpt5IXwlNEbgEoATAvEQwDksYF+oO5Y9G9
         UCJSUmeZ7t010NxVYRKCf9OFL23jYvoEFVGasvZ+HHAp3DdQG+U5WvX8FCL0UigmvNC5
         gLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=50HPP5ae9Rk5gHtTtValAbuIThOVqS9Fd5PO1+T5JvA=;
        b=s1nB6BQkQH1NDaCSzrkvlxl2Rz81yrtQBPZxUNxFrYdbItxcam1lH9DIqDEZnnaY2U
         5uxf+2zGCt5mpRrMsT/WMbCMx6YErHTzy+e6GyCKpK7HD8Gc24bcUS/X/AetlPKX98T1
         iba4bEiMVD6jnxZWyXOz6x3DFhsViYqLU/RTfb0QV2B7zQmCvVPkVCVKdDrZ/AWGVBe8
         wbHISsiWfdQLrT9OdgnDwSqRqvqh0ShEySfFwMOpIu+4F3Z97zkWhdd0Sar0CVJ/3hSS
         kGkV9bu7iO8CdMeuKGdbnJQK+ukflGAMMK6Wt5FnkMYrmZXbv+3WgZLy9wlNGIgtEg7Y
         V9bQ==
X-Gm-Message-State: APjAAAUSjTPsyHqcHm+ibsuauL2i8uWJye0s3mJTaClkfjXT0wGp5dCk
        eRnLsZa+oghZ6atz2l+fGBAzU1xqwQ==
X-Google-Smtp-Source: APXvYqzMkxBs2cDN549gJpNFEb8lpj4AX3cyY+ueGUnHE4yMbW8XALFC1E3Hn6oiEp+TEpASzS75KmyzTg==
X-Received: by 2002:a05:620a:624:: with SMTP id 4mr71498850qkv.15.1560430805871;
 Thu, 13 Jun 2019 06:00:05 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:59:47 +0200
Message-Id: <20190613125950.197667-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v5 0/3] Bitops instrumentation for KASAN
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous version:
http://lkml.kernel.org/r/20190613123028.179447-1-elver@google.com

* Only changed lib/test_kasan in this version.

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Use static_cpu_has in uaccess region to avoid instrumentation
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   2 +-
 arch/x86/include/asm/bitops.h             | 189 ++++------------
 arch/x86/kernel/signal.c                  |   2 +-
 include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
 lib/test_kasan.c                          |  81 ++++++-
 6 files changed, 382 insertions(+), 157 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

