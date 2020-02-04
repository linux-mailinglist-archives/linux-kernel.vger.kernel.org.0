Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB53D152020
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 18:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBDR7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 12:59:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32944 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBDR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:59:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so7583321plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Yq7DlP+MKcqgZ3wsjfCTguAnbXfIOKWROJvqxl0zoQ=;
        b=f2D9vquNX5DsXU5g1xuVZpuFt9sTH4kFwsIAWNMIjnxU4QKnljJhk9oBZx4jGkTBER
         L2lJn5kkTuXGKXMRxq1F7++Ge53ax+ujxh1P/CQHoT6Aa+x4zGIEGrGLIPiu3zV1MqqD
         IjnegYIZYOF9cHDeb5aYhnyZve7ybwBeT/ofK1QB2aM6Myt/7mATzhWcfhbwZm3rIOki
         By3TJYdZqvQBqPIxasrGkhNYd1py0kxsUijkqJ7xpQxmX8ygFycQ6L4uKslE7Jdc9pFV
         YQbTzpCfLKBG+UqTQqsBPCWELHqafw+dikqc9/SOsCJ9KcCXPR8uD9mRUrZxG41OinTK
         PT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Yq7DlP+MKcqgZ3wsjfCTguAnbXfIOKWROJvqxl0zoQ=;
        b=gnYLqTIhQwWKxMa6eXJ31N0ROMaXH0GgD7vyLY3DWuR3fBj3fGgnAPI2IFJ3lpRiHp
         r3Gg+0KljoqQdiFux9A1dYWS0REh6PF2p25cwIA6fEzowcUm1XoyWlGtw40+w7bbROrC
         y1fHeo/M86tn2/UiEwi+QKJ1hMbImJk6fjoqJF2hITFfzLHdl/CYfv/siJU/Z4wYioGE
         Juygv4Zad9V0bYIayTDCl/urm4wrfKNPMWkI4/COUwN+cfXtwVe09HTyTnBUtE1n/Yy0
         UHAYwkcevgmCgVnzeNxDQKD206vCctTtFErs5fjZxZKOZGLz/RcoASGExVs2tOeLa5iS
         MEpw==
X-Gm-Message-State: APjAAAVRszgUAFw4+SHzGPwhqL7fTdRxA6hPQYkhuWeIJ44oNYjnuU4W
        2yjGdbbl5OhYULY7xb/mBwc=
X-Google-Smtp-Source: APXvYqzZ3hxUy2pgjYnm+E5KKwzAk92s+OrDRAm4xSLtLf0eFvS2+/aSnkqwr9PMcUcTGFMIy3Fd9A==
X-Received: by 2002:a17:90a:1697:: with SMTP id o23mr363140pja.62.1580839165382;
        Tue, 04 Feb 2020 09:59:25 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id d73sm25414465pfd.109.2020.02.04.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 09:59:24 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 2/5] arm64/vdso: Zap vvar pages when switching to a time namespace
Date:   Tue,  4 Feb 2020 09:59:10 -0800
Message-Id: <20200204175913.74901-3-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200204175913.74901-1-avagin@gmail.com>
References: <20200204175913.74901-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VVAR page layout depends on whether a task belongs to the root or
non-root time namespace. Whenever a task changes its namespace, the VVAR
page tables are cleared and then they will be re-faulted with a
corresponding layout.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index c4b4758eaf0b..5ef808ddf08c 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -131,6 +131,38 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 	return 0;
 }
 
+#ifdef CONFIG_TIME_NS
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, vdso_lookup[ARM64_VDSO].dm))
+			zap_page_range(vma, vma->vm_start, size);
+#ifdef CONFIG_COMPAT_VDSO
+		if (vma_is_special_mapping(vma, vdso_lookup[ARM64_VDSO32].dm))
+			zap_page_range(vma, vma->vm_start, size);
+#endif
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-- 
2.24.1

