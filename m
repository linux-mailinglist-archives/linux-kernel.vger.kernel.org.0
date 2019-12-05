Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1C113872
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfLEAKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 19:10:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41074 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfLEAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so663347pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3o0S53BeNnZfZd99UaFa744uBy1bdSUJelyk4yNxHs=;
        b=GC95mQV5lCJoxcnVgn7296LK/LZBl3LEgiS0w9Qsv+v/6fbsEouw6kOnJdXsFNqaIi
         ffnEamkViwozMeBKfXxdLm0oEVeqCoZhAOCOuTTXnq8ARzgED4nTN2Lg02dSegV3KT2s
         0M9m5OFAtgEpGoe6zM5fLdwUOKXdYd2RGeaW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3o0S53BeNnZfZd99UaFa744uBy1bdSUJelyk4yNxHs=;
        b=WFeuCLVPlx6gd+bell7Q4MYnNwM5gN9J0w1mf72FCPP+XZYpK4zl34h8AJ3UlWXBXE
         Vm9a7w1uUaYV1PoRjYXNzeMl+bTsyyxPIyHDXUTAcBDXVkZfNxRTsgGi/Azzanb1EkDh
         ianqDIfnTNa2laHdD6Z/wTliCTuS56EWcaX9kpfjRoAS/5+maaDwuiVOkdgdtV1Qjojq
         M01uKeuXhw6OTQNsMKFe1r6nu+PMAhsuOvy0WmbBt3B7Y7M/is77WlqLqfu1tnN4HCVl
         sKOEuLjUl4z5XbU048xdJPq/Fi9YFRO07iTO4x/zu8L+5+YZT0Q8GjIOZYmmB60b4JKi
         DfvQ==
X-Gm-Message-State: APjAAAXvUXOhtRjXr+ReR2WwgIYB+J3RGsV8qcttaKxoX2mNo8NvUrSE
        /oF2GLAwKg9yKh/pma2OoCjm9w==
X-Google-Smtp-Source: APXvYqxZa14mrTVNWUdtWyPFCBpCEtH1XqTiMCdfNPGTL0gp3E35ktiDS7ypx6yJ/1yVmjm1S0Bzdw==
X-Received: by 2002:a62:6381:: with SMTP id x123mr6145520pfb.75.1575504612382;
        Wed, 04 Dec 2019 16:10:12 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:12 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v10 02/11] x86: Add macro to get symbol address for PIE support
Date:   Wed,  4 Dec 2019 16:09:39 -0800
Message-Id: <20191205000957.112719-3-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new _ASM_MOVABS macro to fetch a symbol address. Replace
"_ASM_MOV $<symbol>, %dst" code construct that are not compatible with
PIE.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/asm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index cd339b88d5d4..644bdbf149ee 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -32,6 +32,7 @@
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
 
 #define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_MOVABS	__ASM_SEL(movl, movabsq)
 #define _ASM_INC	__ASM_SIZE(inc)
 #define _ASM_DEC	__ASM_SIZE(dec)
 #define _ASM_ADD	__ASM_SIZE(add)
-- 
2.24.0.393.g34dc348eaf-goog

