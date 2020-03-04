Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5201787D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 02:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbgCDBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 20:55:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39238 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbgCDBzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:55:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so370639wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=dydE0fdupSCSgVGrBqAu7BEK7YS/h8wM7+7qNQDN2fplhkdABH767hEJX4e9Z4s7ki
         UGoRSNWWepKiAFpfQ80oZO021g8hSXTocLjcuZzQIzMr2c3DkJYJBBmgeFY/J54ftLGw
         dhWtOYBd6PtPRXMxKl7C8G2pXNOdr7Px4GHLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=MmmrFMXvIq8Bk2JOwfQ2l9G3+9NLR0xhAvE0qzTtVH/0mND+rvLrfChFu3EqYbTShq
         P24NYCQyxi1pQ6TGS08yXV23qtMycdiPcthUJEfSDCryQodje4i+4sN9opErEqc+QYJJ
         y7Ywi/tvgNbng+NVOTMhLwEWDIj2vA8vZM75Jn4xww44fBAGWsvDpEIaGpgs3Fw8A/C4
         OeK4NnxtbObPJc/kOcEFODpc+DkfZ2UVvUWPWCSDMlnAE2gFgdN6ruz4aP2YnfYmWwNJ
         6MfJ7B0vyKmSkcoDXr9DW7GW8kSMc9I1WGbYoK/fTz4U83+iNEj9xStqCiCOMFVSQq9y
         dQ5w==
X-Gm-Message-State: ANhLgQ1M6eemstaX8TT/spZY/lZTeSevk4LqpbiqVEcmUr2rphYIu3f/
        iL0aDQc1eOYb+Onp9QSP0uqotg==
X-Google-Smtp-Source: ADFU+vsFTzDOzPrEEGIEWOFKPIMd52mPzRQ4gov9+uWYUBxtEJVUO56l4lizKPgU29gQYWP0AXCQqQ==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr952253wrv.2.1583286941461;
        Tue, 03 Mar 2020 17:55:41 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a184sm1475444wmf.29.2020.03.03.17.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:55:40 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 02:55:26 +0100
Message-Id: <20200304015528.29661-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304015528.29661-1-kpsingh@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
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

