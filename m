Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D59F45E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfH0UlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 16:41:09 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41539 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfH0UlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:41:06 -0400
Received: by mail-pf1-f201.google.com with SMTP id 191so225426pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xayR1eaTOStHF5jKNWv1XVdOT2EVEaLrqieyOudEAew=;
        b=NHIhoqFMbp5MdEk/zZR4BkgYP3OtmmrWat2vDnifQG7VpdLb8ymLES1nAKEPdRb7XW
         qjmB6tUw3vNvc+5O2wFghDgrdxpwGucqBvNtpiL9JE+nwKFgR4GA+rzh/2M8Kl1ofFPO
         16QHFVi6WVK2Nhql5Vq4QbJzbYNNhRvXUWj0zi5jvg8k4ICb52Db9Xt3yvJEt5H3d8Iv
         /OcYJprQ8aPOC9FpjOlmj496KpwfbyjsGSKPvver9hp0nlEOqbFQb5Hpb569Hrps1qjf
         BPPoIbW6pLMIT/PiWXnLALASS1TG5OdI7SwRI/rIX8gb00S4Tr/mNs2rCPO7VvU5r8G5
         VK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xayR1eaTOStHF5jKNWv1XVdOT2EVEaLrqieyOudEAew=;
        b=GbEvixC6GkcfZj6jh+D9busntatKYRIXFVHw3iYfAWZ0nNYp97iJpXBo5r8Uwd3rsn
         cVVKQZ92nPETFibeskQ32HDGxM5qcXp4pQndvFUUV3nnz91wNlsW2Am3tJs6k33z4EP0
         lk1q2C5vi64rJUPfOpBj07Vhpk/lCJrYfGGo51AEFgllTNGavMKC4bSnbpUmefW3LTDX
         QtkWqFYwdTPGN4u9R8kaXZwY6taiWiPAeEcJR6ntE4IcLnk30bJdQTpc2uSE1SuJzssC
         Vgi4Zr4W5BhQiBc1q7YJY5rQrs6LopAvCga9ZxikObBIKiRV0iB6qnbQ1BM0cFBnNYTq
         vX5w==
X-Gm-Message-State: APjAAAXBPa3lqFcFzzur/xXlOcRmIUu/dTWyYdnoTNikggH+Q2Sl2+AN
        quhwKPBYXYZRkcJRQ5V6iR60pt2qMR1vAfwm8fA=
X-Google-Smtp-Source: APXvYqxR5yi6cMoNzQQzhEyhbHsQPhQBwZLZlTu/iCHhZxCON5/LG4WyjU2RbMGUa/kinzEiVorrXF6NEks6Cbwenxk=
X-Received: by 2002:a65:5cca:: with SMTP id b10mr265201pgt.365.1566938465537;
 Tue, 27 Aug 2019 13:41:05 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:40:07 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-15-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 14/14] compiler_attributes.h: add note about __section
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler_attributes.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..f8c008d7f616 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -225,6 +225,16 @@
 #define __pure                          __attribute__((__pure__))
 
 /*
+ *  Note: Since this macro makes use of the "stringification operator" `#`, a
+ *        quoted string literal should not be passed to it. eg.
+ *        prefer:
+ *        __section(.foo)
+ *        to:
+ *        __section(".foo")
+ *        unless the section name is dynamically built up, in which case the
+ *        verbose __attribute__((__section__(".foo" x))) should be preferred.
+ *        See also: https://bugs.llvm.org/show_bug.cgi?id=42950
+ *
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#section-declspec-allocate
-- 
2.23.0.187.g17f5b7556c-goog

