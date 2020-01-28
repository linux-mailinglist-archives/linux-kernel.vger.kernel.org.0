Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF61614C036
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgA1Stv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 13:49:51 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45187 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgA1Stt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:49:49 -0500
Received: by mail-pl1-f202.google.com with SMTP id 36so3281997plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nYqHbjkvd1RNJgGQNDuWHkkD/vAdL1upqEsqEeQXJo8=;
        b=nTzlXAOcntXez7Jr3uvwxUmF6fuRm7siV0FVPtZIRsRiYJNBl6ZlwOV/mANhygz8To
         /ghGtzrTrMWvLahlzphY1v1JAapei6wwGYOCMCsqLWm2q8qFXVo61GhXIQfSeL7poUdj
         YYtEuNx1U4DjGRuHl/023HxQce14qTvBIBiqQpzqP15KOMH1kLM8Rv9wZbjZiTB64kSU
         +h0WW/yXKyidH4SedV+F9MUHuIweqEFG+xAYizHw0F6KXAAyVsHvjYJShP+RHUsiQT6G
         iczyaLXreCbKBqnyCymvBhk48aLizT49PYr2naT9eJbsk7orwZhWsfUOL8SKkJbT1nX8
         YpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nYqHbjkvd1RNJgGQNDuWHkkD/vAdL1upqEsqEeQXJo8=;
        b=ta5VGt903KhBg6A6X0VZdpK9binRucwCHLmu2WK79tis4fM/iOOTAxAvhQ9qBtEtp5
         iusNS6sBuJnnbkdNWvNqUbgSQP/+g6o8mK7iISCEOgKed/SaZnD9HcTykdMaIiw2HziN
         vZJqR2YnKbnrvnx0C2csrYGK54YE+ilUA2nG7Q4H1EUdQNqsFUbUV8gImI1KXSbV8Cdi
         x9rbffubkmOq1Fil2bBDf3xqJAF+80ZaPH/s+soivq//uBkunVSygSYhKnzex2ZLT5EF
         IfUWOnVwpOV9FLLL3dvdP4xckPSwwnQ6fqZsZv4E1goBpa30N/cmOf8IXf3DLsFzhOAb
         SNqw==
X-Gm-Message-State: APjAAAXUYe8khOvP4rBrqweAEsOyKKC7UzOuCeAny0H0ENYJCMV8RdRJ
        0bYM3KeYSfXEVSK8yFjnxdoDUi8ngjB/EGgV4+4=
X-Google-Smtp-Source: APXvYqw0QABwd210+mxiAnE7f0mYp0N4i4a4gt86B/Etz7yIed3ZXzeJ4npaWmB9oIyI9gykbj9rUMgDNcXPfOSGbAk=
X-Received: by 2002:a63:5924:: with SMTP id n36mr26520518pgb.43.1580237388946;
 Tue, 28 Jan 2020 10:49:48 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:49:27 -0800
In-Reply-To: <20200128184934.77625-1-samitolvanen@google.com>
Message-Id: <20200128184934.77625-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200128184934.77625-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 04/11] scs: disable when function graph tracing is enabled
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The graph tracer hooks returns by modifying frame records on the
(regular) stack, but with SCS the return address is taken from the
shadow stack, and the value in the frame record has no effect. As we
don't currently have a mechanism to determine the corresponding slot
on the shadow stack (and to pass this through the ftrace
infrastructure), for now let's disable SCS when the graph tracer is
enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1b16aa9a3fe5..0d746373c52e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -530,6 +530,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 
 config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
+	depends on !FUNCTION_GRAPH_TRACER
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
-- 
2.25.0.341.g760bfbb309-goog

