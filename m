Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7202437F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 00:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfETWhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 18:37:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34533 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfETWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 18:37:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so7949043pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JwCBVuGEbgWZTqerMXg97XLBl/8qglZ8XiyYccghHL8=;
        b=ndbmROM0gWoBFRY6ntjBqzGYKgi4c4/inbqPg03WTRrETAZwmCWw4xYKOp7lcdjgo2
         vg3ZNZ1Xd6nOQrg2wsprHLJxnIz2m6e3sQKHd4KGwrCn4FMMeUSgEXVw74nBkWP0vUAI
         5MsC2KKa4JH2enUcbPL3DhMIk0WU+u6YeP1pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JwCBVuGEbgWZTqerMXg97XLBl/8qglZ8XiyYccghHL8=;
        b=QDcksaTV2HSos6aTK0mTMp5tzWAz2J0vvw5/Mnv3GnJ8E80z7azPH8+V9ADeM0GjoS
         39IOV8LkKQ7BZuI+0JAC0YapFfOddOe4UXcRLBXfzig0zSHuu6XqohUBvK6M+tvmvW5L
         OQ/Rkj6EsKzewA6Rz5QRwYZ55yyK/uiUUwZjfjSsUGw9WHhpVMZOrWEJLUnYxzNSP6MC
         BhLX2RNrQIlpR0k49tFu4oqoeQC4tuF63PikIDyYhvQvWdvf5OcuefBEF6TNUgG/ZSCw
         6UTcgPAdbsnK39ijc1cErl8A+ajmNgU8HUsvE6g0MNQPGx13s+hffdnKjNJK4xg+BocX
         A5Gg==
X-Gm-Message-State: APjAAAUJOang+vU5YWLMjxHUJ90TO1CTcA4nPHxTeZdpfkk58iEr2zbt
        axo29dYLxrp56U69VxUI2LX+VQ==
X-Google-Smtp-Source: APXvYqyvQEHfo5lR19KUBwD0DIKvpTDd4rE/uMHHHTYCtQgrA0XcbaDbNo5f5MKaVPYKMf/LIcjTYQ==
X-Received: by 2002:a65:6648:: with SMTP id z8mr28891425pgv.303.1558391872790;
        Mon, 20 May 2019 15:37:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x66sm7707026pfx.139.2019.05.20.15.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 15:37:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5.2-rc2 0/2] selftests: Remove forced unbuffering for test running
Date:   Mon, 20 May 2019 15:37:47 -0700
Message-Id: <20190520223749.13476-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix test regressions seen when running under unbuffered
output. Additionally, fixes are added for the missing flushed output
in the timers test which become obvious without unbuffered output.

-Kees

Kees Cook (2):
  selftests: Remove forced unbuffering for test running
  selftests/timers: Add missing fflush(stdout) calls

 tools/testing/selftests/kselftest/runner.sh     | 12 +-----------
 tools/testing/selftests/timers/adjtick.c        |  1 +
 tools/testing/selftests/timers/leapcrash.c      |  1 +
 tools/testing/selftests/timers/mqueue-lat.c     |  1 +
 tools/testing/selftests/timers/nanosleep.c      |  1 +
 tools/testing/selftests/timers/nsleep-lat.c     |  1 +
 tools/testing/selftests/timers/raw_skew.c       |  1 +
 tools/testing/selftests/timers/set-tai.c        |  1 +
 tools/testing/selftests/timers/set-tz.c         |  2 ++
 tools/testing/selftests/timers/threadtest.c     |  1 +
 tools/testing/selftests/timers/valid-adjtimex.c |  2 ++
 11 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.17.1

