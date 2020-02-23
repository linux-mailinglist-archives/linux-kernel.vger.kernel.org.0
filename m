Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29B71699D5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBWThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 14:37:19 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:32841 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWThS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:37:18 -0500
Received: by mail-qv1-f66.google.com with SMTP id ek2so3305197qvb.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 11:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfzkHhlgdItc8s3ky+addnwXQZ/kxyiQG/TmfWXJMrQ=;
        b=HK/HXAr7pvuq68Rl3l47JnYgPtM0MDLr+ICk3pBZVwCpBnZWh7t4+aV4ZlMGfgyypv
         7kSXT09+v2ITUdotUvmJeaPWqhxWWs1r68ioWSKale11PW1HMgKyCVDa9cRbJNWDi+J5
         icKd++qsBHrmc7bZodduWYYPaKw9JBGdN7YGL0pDKzZfAaFTa47Nrl3Drc6MMusJ4M7W
         Pn9QAnm6NLdmCo+ItWGwJHcCk1gVjWOeA1a8aXyYKsepo4ccslb+8/gJWrdcsXKqxQfj
         XWtuaxvrraTT68RXU6ytkaJfwyjKD3tZmcSigFhWQn4nGCiumoK+groAdh9lWqVtSp5f
         +VfQ==
X-Gm-Message-State: APjAAAX7kPlzoz7jvkloKK6bY79GbAhU62GAtrSANShYKQO6HFIESv9C
        nvs2o5b9k/xEoqpmmSAYI6Q=
X-Google-Smtp-Source: APXvYqyAsK9q0wWSFn/4rh/TTZ+fJ5FjOelTDmzNzIxnfOVEPlOupo1qgTjCVNcbE+a9jYh4d3xbMw==
X-Received: by 2002:a05:6214:1933:: with SMTP id es19mr39919830qvb.14.1582486637564;
        Sun, 23 Feb 2020 11:37:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 204sm4780976qkg.74.2020.02.23.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 11:37:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/2] Stop generating .eh_frame sections
Date:   Sun, 23 Feb 2020 14:37:13 -0500
Message-Id: <20200223193715.83729-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200222235709.GA3786197@rani.riverdale.lan>
References: <20200222235709.GA3786197@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In three places in the x86 kernel we are currently generating .eh_frame
sections only to discard them later via linker script. This is in the
boot code (setup.elf), the realmode trampoline (realmode.elf) and the
compressed kernel.

Implement Fangrui and Nick's suggestion [1] to fix KBUILD_CFLAGS by
adding -fno-asynchronous-unwind-tables to avoid generating .eh_frame
sections in the first place, rather than discarding it in the linker
script.

Arvind Sankar (2):
  arch/x86: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
  arch/x86: Drop unneeded linker script discard of .eh_frame

 arch/x86/boot/Makefile                | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/boot/setup.ld                | 1 -
 arch/x86/kernel/vmlinux.lds.S         | 3 ---
 arch/x86/realmode/rm/Makefile         | 1 +
 arch/x86/realmode/rm/realmode.lds.S   | 1 -
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 7 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.24.1

