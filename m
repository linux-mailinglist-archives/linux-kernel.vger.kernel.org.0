Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC03190291
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 01:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCXANr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 20:13:47 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43524 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCXANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:13:47 -0400
Received: by mail-pg1-f202.google.com with SMTP id v11so12175220pgs.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5zop4gGexKIVuUBB/XuZx8+PSEnhloPSs1GUWTBRoug=;
        b=Jf4pz+xxWi1KLV5c9bDhFE8MrJh2Z8f07O3zUs2S+qlfcK2qJtUoYANW2BzQQaoT8L
         IRTh8WIS1U0hVw30sN77abfdN2QIxNYkE46rMnTB6cmzUzo9eYxmipwUvo3NefssikD9
         UZ8rxuOKe6gWEBeIoGWxhJWfPgHUO3d2wq6FIuMfyiZXiRQ/t6nvN6CNCAV1R+kL4mXo
         hjrhcL8mL0+D+GgO5Vp6RLcQ3RsArsOwwBbLbga8FNvMteKjYyH/Im+ruWp0X34xa3+X
         mGD0Nq1uEhXYgvEEumDLNHBlmF6NtGZGTZojYYNjsQIp0CbiPoQ6bYrnXbqrUi76vPH0
         A9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5zop4gGexKIVuUBB/XuZx8+PSEnhloPSs1GUWTBRoug=;
        b=GMKLfQf2LriFBzUvWntLDcc7M+zriotDHuJAdbruK0XSDVe2mdFWVqjLqlhuFb9nY8
         EO4bnS2IUgGMFyMV0PiuZ4qVwxoTeOWYDtQMeH+CAGWfOpxN9ZTzjh7cmCEKajcp81zL
         MqOgbRN14dsoLg1SLWAcoLsG2zYZrYK1eWGsERwuBvTxc0Uv58v0tY9SDDeMD7TuDap6
         2d277t3mFkSXzy0XUuj+gG9zsECZxD9HmBAIArSTnPfFXrPIU/lslX52Czzh+rBp6ENM
         jeGuOmCaHpEPU4PXg9OdAUipJuYV/8YCgmsLsapMe7vjXA7RhUKgnyBqdycpuXn+Fd+L
         InHg==
X-Gm-Message-State: ANhLgQ3HWzcUEGd9DXh/HlM9jyhOlcJXYPg8+WxvQ6R+lAXYXOsRCUMP
        7XXmQReRtP7dXShPvGKRNHDwUCKkj2sSJWVYUdY=
X-Google-Smtp-Source: ADFU+vt3lydh3JoLaoOtiqK4WlY5WttupzLLsNDbgg1w+lBrgP7ionKzEtTS+zugoiiIHVVSt6oD9WuWyJ28ZfLgK1w=
X-Received: by 2002:a63:c44b:: with SMTP id m11mr9425702pgg.313.1585008824657;
 Mon, 23 Mar 2020 17:13:44 -0700 (PDT)
Date:   Mon, 23 Mar 2020 17:13:20 -0700
In-Reply-To: <20200323212538.GN2452@worktop.programming.kicks-ass.net>
Message-Id: <20200324001321.39562-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200323212538.GN2452@worktop.programming.kicks-ass.net>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] objtool: Documentation: document UACCESS warnings
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jpoimboe@redhat.com, peterz@infradead.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with Clang and CONFIG_KASAN=y was exposing a few warnings:
  call to memset() with UACCESS enabled

Document how to fix these for future travelers.

Link: https://github.com/ClangBuiltLinux/linux/issues/876
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 .../Documentation/stack-validation.txt        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index de094670050b..156fee13ba02 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -289,6 +289,26 @@ they mean, and suggestions for how to fix them.
       might be corrupt due to a gcc bug.  For more details, see:
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
+9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
+
+   This means that an unexpected call to a non-whitelisted function exists
+   outside of arch-specific guards.
+   X86: SMAP (stac/clac): __uaccess_begin()/__uaccess_end()
+   ARM: PAN: uaccess_enable()/uaccess_enable()
+
+   These functions should called to denote a minimal critical section around
+   access to __user variables. See also: https://lwn.net/Articles/517475/
+
+   The intention of the warning is to prevent calls to funcB() from eventually
+   calling schedule(), potentially leaking the AC flags state, and not
+   restoring them correctly.
+
+   To fix, either:
+   1) add the correct guards before and after calls to low level functions like
+      __get_user_size()/__put_user_size().
+   2) add funcB to uaccess_safe_builtin whitelist in tools/objtool/check.c, if
+      funcB obviously does not call schedule().
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
-- 
2.25.1.696.g5e7596f4ac-goog

