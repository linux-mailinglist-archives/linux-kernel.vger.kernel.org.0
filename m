Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3491793EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgCDPsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:48:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388063AbgCDPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:48:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id g134so2642750wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=Ie8ZqTulx72jXcIilsU1d/WAVSGRYBCLfmfJux0wONI0NlvrKQ9Enw2cSDDGVsHmSU
         lVYjEsE+LZfyyPRfmG6NsHrFnMRoLf45pDyr8xuxkLLuVPPWwBFDc/7quKSaQnxJb1tH
         pPdtLx8zLfLFzNwYXT8e6srppXRhLdtZmK/Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=ewbbewxK4iqYf02OT5s8MP+3iA73FUfs3seoyrRfym6KTB89BIlkzqwzqJ1H9Gdpa7
         UE2sGsi/3vERYxNpv0MITcvOv6GvI2QTjsXgobYze4xZ11/0l4tU1RUmWk9aIkhDlIZD
         M3fLb+S59IGx6lt/kFQ9L3WjuzxxTzdkVacUyB8kI59Exnc7U+N2hkleTSomj/UAV6NZ
         stEveC8lbqvGvA+5sTcrsgpDuRCtr/VYlYuGbcQh9pr8tR6MJgCDZq+Uea+EbECeZC4E
         YVOCYyj0R6Ub8hNhBg18z6GUmAWc01uUrdCN+pMgVJ+/T4HSow+Gxehe7cAAHMG0QVEx
         YwHw==
X-Gm-Message-State: ANhLgQ0zAH27RSBcsgGbr9MLS2JUMbmSU6hiH9bJE9t5cE716BYhOi/J
        Zt0eLbdkAHdXI4wJd/eoCBYpdA==
X-Google-Smtp-Source: ADFU+vtGAQk6b9qNhtaeyie9qoPkeL44V/Y93fExB9w/SWb+vlwG17d+/ILecdmYCU41C5LszJwThw==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr4094248wme.173.1583336879927;
        Wed, 04 Mar 2020 07:47:59 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id u25sm4816091wml.17.2020.03.04.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:47:59 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 16:47:45 +0100
Message-Id: <20200304154747.23506-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304154747.23506-1-kpsingh@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f8c4042e5855..223be01dc466 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6288,6 +6288,10 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_FENTRY,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("fmod_ret/", TRACING,
+		.expected_attach_type = BPF_MODIFY_RETURN,
+		.is_attach_btf = true,
+		.attach_fn = attach_trace),
 	SEC_DEF("fexit/", TRACING,
 		.expected_attach_type = BPF_TRACE_FEXIT,
 		.is_attach_btf = true,
-- 
2.20.1

