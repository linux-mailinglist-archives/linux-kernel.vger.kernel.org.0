Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3B112F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 16:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfLDP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 10:59:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35987 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbfLDP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id v19so375877qkv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O1/Snxb5riMEM2rJi1KMG7s6/Tztu9n9IW8tHLsuHwY=;
        b=VtXAM4U7F7l2niWs2bjUA1/FCfevZyxkmFcPuFpFGUqREEmkRI3IPJjFp/9sWZ4P9u
         34P5r/HciRoHPUgQ2zh1WhfBQ9dc+I9oLLrYVFxPfMSm5eSXfqAPsS25DRtrkU4qMfCV
         JVFGC9KseajBUqOruNg/NZ83Q44tZwVme4EI3Pja3lk4UB6zPf1enKsubGZs2zAZkd0w
         zFjnBvC4MnF7DMg65bT++dNi7nJy1b0S2Szx2B3XbhBdFh69wkxvEaNLmYfxSD0WYG+x
         BKX5FJ2uiYbnPo22WYYeynb4LanTaDONnrGZItg/BIAaFidFw2MowkE73FNI6Xz0B2eO
         Sgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1/Snxb5riMEM2rJi1KMG7s6/Tztu9n9IW8tHLsuHwY=;
        b=kDXL84sZv3H+xlnaiVq0A+kTaaI4eFX1i0ALCc6b5gtiG+FgW2am2U9FDg+qOIrBkx
         tjMlwVQpRbzUYR4n7YuoKU9FGYI7Dz9RVV4Ei0keYDWjbJVc+wBmmX8JENjtfUbww/4p
         jDK0q2f7NXqSrCRgSRZUR0znmXT6gDLCp8kmPbxF8g9jhy0k9J11/GsKD9MSSj2l759S
         l+kzLb4JTDCBZ9ZMJUtQPlE0VC7LRrDKtlcxaQqXMQuNXPDxnZXxef1pS4q2qSdMYTip
         yL3NWmdPwkFX52Loe6orzcFgd3MrooaBrjX7SyxjV6ooyDeI2jBoVoZBeB6bDem1Hb/M
         ttRg==
X-Gm-Message-State: APjAAAVUhp3Dwa6dVHQhWrNQ06rfWGKT2A2V3eJOM/g4cB2h9z99NzFL
        amfzsjjOHFoBDD32MQIb4NvQTg==
X-Google-Smtp-Source: APXvYqwnoYhlsay18cGYdgO8tha/3l6PdDeLuAJb0cJ+NbXd/YkMJZLdic0YIGKGxuueYGo1dLyIrg==
X-Received: by 2002:a05:620a:844:: with SMTP id u4mr3825309qku.368.1575475185340;
        Wed, 04 Dec 2019 07:59:45 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:44 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v8 03/25] arm64: kexec: remove unnecessary debug prints
Date:   Wed,  4 Dec 2019 10:59:16 -0500
Message-Id: <20191204155938.2279686-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kexec_image_info() outputs all the necessary information about the
upcoming kexec. The extra debug printfs in machine_kexec() are not
needed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0df8493624e0..8e9c924423b4 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -160,18 +160,6 @@ void machine_kexec(struct kimage *kimage)
 
 	kexec_image_info(kimage);
 
-	pr_debug("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
-		kimage->control_code_page);
-	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
-		&reboot_code_buffer_phys);
-	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
-		reboot_code_buffer);
-	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
-		arm64_relocate_new_kernel);
-	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
-		__func__, __LINE__, arm64_relocate_new_kernel_size,
-		arm64_relocate_new_kernel_size);
-
 	/*
 	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
 	 * after the kernel is shut down.
-- 
2.24.0

