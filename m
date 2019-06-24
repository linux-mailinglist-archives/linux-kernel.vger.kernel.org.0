Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3151A27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbfFXR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 13:59:06 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:33157 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXR7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:59:06 -0400
Received: by mail-vs1-f74.google.com with SMTP id x140so4148444vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6TEQbk/zbfOFf1CWrQQmcJadlQEFi4113uyVs78HH9w=;
        b=De9s5wBKaGKkuPG0lVsLPimGxgSJl59lxtDRzxPVUTeAawreGLYCxd/zmaM/gOuXva
         P/HrZpBqMiuzokHtcC7CWJjceyfstrfIeqRjWphgd4dg1KLZ8EBaXYj80VpMcEQ2VncW
         un6dkSZjt8nn++btFG4v8XlWrDSu64LTyToOghteAYoaglbbu8z8wpWhGXJp4/wTJ32M
         /l6KA0w2wrWU6dLuLnkN9+THJwP4XVb/tmgZqwVBzn+2wcB3rHlz7XSoQMpYBsD7l8Ou
         nS3WT38wwAbOTzjzKLyHo7KJ6Cxg0LcY0UgCTRmgpBP8opgNkoy/Vq1S+NI/jS+AQZfD
         YwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6TEQbk/zbfOFf1CWrQQmcJadlQEFi4113uyVs78HH9w=;
        b=syk0C/TC645JIX1l2oJNg/I7wzRh+D80lqTwIzYpT87xzsIyuL8hxYreGke05LyP/9
         SnsPJkqclVg0KqWIkR4uMJaegT/lB32ctNC2EnWnH2niHj7ZWkcnTipWpHsqibYRT0b8
         3ORYcLRU4RRv9ApjnaczaTW2ht2v8CUizsQwyaAhSnNfNKYOqP6dsVdt611CewkWavyf
         A9FrfSpG+CHWXqgNxNvo+7hlETTpm2CBc6+Ee7XQ7PCZlMIbCb4Q4tI7LZv/5f6DjJLj
         cESWQIpt9DUaTJ07OEvv3PLHshSSGrUdce04ZzyEzk8aoJwhC4sfAAG0yuikSZXzFP6z
         21gw==
X-Gm-Message-State: APjAAAXlUdk0sN350+UaColQnkAl/f0SyWC97hNxbmSmFaJy4OI1/Lbc
        f2M/jgR3auOqggMw28leyJ0RKRzrKvr4z3amOZg=
X-Google-Smtp-Source: APXvYqzPuShkjXxm1lHGIASw1NIy8e6Pd0IgLI4ln7gdvtToyhE8g5KwzRq7SIZLHGOWLRqfzrBOuYE9mClcYyLPEeY=
X-Received: by 2002:a1f:728b:: with SMTP id n133mr18841620vkc.84.1561399144841;
 Mon, 24 Jun 2019 10:59:04 -0700 (PDT)
Date:   Mon, 24 Jun 2019 10:58:50 -0700
In-Reply-To: <20190624095749.wasjfrgcda7ygdr5@willie-the-truck>
Message-Id: <20190624175852.46560-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190624095749.wasjfrgcda7ygdr5@willie-the-truck>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] arm64: defconfig: enable CONFIG_RANDOMIZE_BASE
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     ard.biesheuvel@linaro.org, broonie@kernel.org,
        mark.rutland@arm.com, keescook@google.com, samitolvanen@google.com,
        jeffv@google.com, shawnguo@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing coverage and improved defense in depth, enable KASLR by
default.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* drop other hunks as per Olof and Will
* Collect Acks/Reviewed-by
* Add Arnd and Olof's suggested by
* rewrite commit message

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..a7cbf7cd84b4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -68,6 +68,7 @@ CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_XEN=y
 CONFIG_COMPAT=y
+CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ARM_CPUIDLE=y
-- 
2.22.0.410.gd8fdbe21b5-goog

