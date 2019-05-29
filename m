Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E7F2DF98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfE2OX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 10:23:26 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:51324 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfE2OX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:23:26 -0400
Received: by mail-yb1-f202.google.com with SMTP id e139so664407ybf.18
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PLHql6HuZD0bzmA8PfaTdvUizoR7LXyZ6UL9cOmZOnQ=;
        b=Guy5Xjr5Wholvk2wwpj43VueywLu/AoMNYGYxpgCWt0djZBOVn5FgcePWoupL6XXsj
         7IPSG1wBXeae7XBJIn7bzmUq8mJ9wuBxmhbor+E5UQqqV2K7PEeEDgWhrtOEFMi8cHUG
         VUrxUug7tZaBxJoM+N3GXVlsx6vGe+QFZ/l76oKzcR1wyxSC7jXJxYr8+RaJHSEDq8uX
         DP98R4+p+DEeSThMxTKmQwKbeqViUNQty3XNKqErwgKL0Q0E5ScNtJuO322XY0yhLcuM
         Ze8YkXH+MMzFzPo/7YnKbKetJ4TLvtyCIlNAKD+IKXQmcSIL+tRecQXIiCW9eYpJfTZr
         Tq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PLHql6HuZD0bzmA8PfaTdvUizoR7LXyZ6UL9cOmZOnQ=;
        b=jnkfME3mLZFDrSnZZaOk/750FxJ6OXKXzkPDzd9oEiI5draW0sy0Ok0wZPhB055WdC
         2q0dP0rvvSXz4TRo0KX+kwUDvHyOacylT4Kf+RJppUZQD0/Vol6HIjGmB2rTtN72eg+M
         MALk/mKLcvwxqYV0HpWZPjepVY6NNKbkirl2BgcwrVmzSLFivhEdtX6U3whYo66Giybi
         8A1OI+vcX97wpBjVM9Xv5giN2u4aGMibR1RV0NrF7tvyRxGhJfXiK9Y3mXEGG9Fc8xvJ
         CeQfNo/obrj5iHj4zi7nwWzRc6znmyBI0XwDFes2Itlok4M5AX+wFaUggxwfcWShiTwk
         XeVw==
X-Gm-Message-State: APjAAAUGkXhluTYdtfTmxT0JzT4vyuB59S7+z55zIEHCGRjF9MGFDJdN
        xZR+4mEgLeKXr78ASu1EosPdWq/76Q==
X-Google-Smtp-Source: APXvYqxLC6zyJv0xSSACzvKIA6nLKuJm7cRRhTv9ht3NB5WR/ekCb4ojh+2GmRIqJexYFBRx2sWzsjgesw==
X-Received: by 2002:a25:c0c6:: with SMTP id c189mr43131422ybf.339.1559139805383;
 Wed, 29 May 2019 07:23:25 -0700 (PDT)
Date:   Wed, 29 May 2019 16:14:58 +0200
Message-Id: <20190529141500.193390-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v2 0/3] Bitops instrumentation for KASAN
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of this patch series and discussion can be found
here:  https://lkml.org/lkml/2019/5/28/769

The most significant change is the change of the instrumented access
size to cover the entire word of a bit.

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Move CPU feature test out of uaccess region
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   9 +-
 arch/x86/include/asm/bitops.h             | 210 ++++----------
 include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
 lib/test_kasan.c                          |  75 ++++-
 5 files changed, 450 insertions(+), 163 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc1.257.g3120a18244-goog

