Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F3172CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 01:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgB1ABR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 19:01:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34321 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgB1ABQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so715345pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9NQOt5/Iwvu5cqFSUEIZpoioa79suNFyUPWf7TcFVs=;
        b=JB82RZGVMkxb7ufWndNbPMc9DLJBVuoLI8gqPesLGOqASB0Yq2fjodsUYxz9QdgrWT
         zM1/pGv08yc4l0mSk65GWRzDC7WMudixLLIWroLROrroJVCpBzp47d8Sil2XIYZfnkfS
         /bWmEwI9PFbsdfvUzibFyKLw6T0o6x8B66oMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9NQOt5/Iwvu5cqFSUEIZpoioa79suNFyUPWf7TcFVs=;
        b=mhfw5DNaC7oC1yC/jjBCYAAVSFndqWnkhW5w1ci+cKBnuPP0Uwjrcyih2SAr9YtoL8
         jHPhE0rBqjoCxC5dXG9RbKTjKEgYMlMYwp1yxD4DHYaWTFhcYfAOX3j8uIjWrXcILen4
         CWui2s5rjTvQsIgnbMArXBO02VLUKqYc9iH/O9DNh2OvfdjNRYkO1iGgSqew3vi00Slz
         5FgEFi9NaebXj/95K06hqhzJSFczhmKQYLPaUO+z6ofjAiiMt2n8vw83SVe2CnXcHmJX
         n5ZhcuWDr8DnbvhOU5TNPSUumiuOQpZzRmzwztQMf5XLMVGmxQHjQRGtiDLjRodtuUWM
         l3Rw==
X-Gm-Message-State: APjAAAVZLwTBD3CCadZRKz1EHK8epI4LtEN9OFaPjNLdzQnuHYH7bEux
        JlRLCeaK/EaW1v547DsUj47ZuZcUUQU=
X-Google-Smtp-Source: APXvYqzNoR8mlRXvViWtEmB8PnTtW0UYVCLnvzxcFZTeurjSH9rB3lHogTj2OBxirQo1QrneXJkX9w==
X-Received: by 2002:a63:cf06:: with SMTP id j6mr1730502pgg.379.1582848075655;
        Thu, 27 Feb 2020 16:01:15 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:15 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 03/11] x86: relocate_kernel - Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:48 -0800
Message-Id: <20200228000105.165012-4-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only absolute references of symbols for the
kernel to be PIE compatible.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ef3ba99068d3..c294339df5ef 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -206,7 +206,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movabsq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
 SYM_CODE_END(identity_mapped)
-- 
2.25.1.481.gfbce0eb801-goog

