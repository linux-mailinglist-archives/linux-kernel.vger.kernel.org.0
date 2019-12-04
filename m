Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372D8112F52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfLDQBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 11:01:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35977 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfLDP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id v19so375689qkv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qBcLX2nsb5/KJrXmAdZJZWt+pM1z+3tYC2JPC3UMBs8=;
        b=o8I+WyKVJqvU6pwBBmPvlwEgfrNAEk4GlYMzitCRr179qPaMpPv/Dsf4RkzNVOlWbj
         SJtTzHuGepA5AFsEpqT2l8HQvW8RyrkGvHmGT4cczfTeeoOGcOTCg3hmg4mGwvsyk2fO
         hVVTKnnabhrr6kUqDnPj9LO3g64XfrwcmnpbRIYHSWIPsQZ+VTvCmCGhjS4uWz8KW+jE
         r2tBKt+5dh4dAw1tfkanz5dGvcgPMAwaczJWITsGCOabbajiT+q35hete04JyPLxcINt
         Rknlv8ifyhk2/6/N5SvtCMHoFTVUc/64uBMV9TEhm+L9zO4lcNPZgOHo6T81EbgmcPaT
         oV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBcLX2nsb5/KJrXmAdZJZWt+pM1z+3tYC2JPC3UMBs8=;
        b=QHyRI2nQyXHcwxylkVJarGrNrg36WrOj76/0KJnN53MT9mNb816cUgCRC3dPLuTYVX
         LT8kq1s3iIn01xF0QKesFbEwUiEyijhDv+o1i3kAgImOLBzH6kHC6Kfy8KzwHG7Ymkjw
         dEk+PbvaRahPkX7ppzXdIlAzG/JJX8oB9amQxlXP9idm3WsM6mtR3qywHyGgVv0B/yvi
         1v1VCDTF3xu2+VbNRLSXki4HAfse/dmEbu1f5pSjdMAPj+gLq7wRpf7VlwiKuhZ32rQf
         Mxa8yn4ZEeDTTxQolQi5FQOC8jTMiWdXtOGoVfYS+ZCurI2KFwdsAkqBn4C48JkpHlx7
         sP7Q==
X-Gm-Message-State: APjAAAW87n/2/uNyp2lLRHOI4PFfurQ9fhZ6IDqLPFgKvwbgY9/eYIHc
        a7RZFP113/nQ25w7SFkFpUCfkQ==
X-Google-Smtp-Source: APXvYqx+YMl+m84asmEHoO0Kw7pl99uqkPfePC/y7TScpNcsYrQoGCWoBXTxiv8VGxyurKQil3dt6Q==
X-Received: by 2002:a37:a40d:: with SMTP id n13mr3808120qke.167.1575475182344;
        Wed, 04 Dec 2019 07:59:42 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:41 -0800 (PST)
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
Subject: [PATCH v8 01/25] kexec: quiet down kexec reboot
Date:   Wed,  4 Dec 2019 10:59:14 -0500
Message-Id: <20191204155938.2279686-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a regular kexec command sequence and output:
=====
$ kexec --reuse-cmdline -i --load Image
$ kexec -e
[  161.342002] kexec_core: Starting new kernel

Welcome to Buildroot
buildroot login:
=====

Even when "quiet" kernel parameter is specified, "kexec_core: Starting
new kernel" is printed.

This message has  KERN_EMERG level, but there is no emergency, it is a
normal kexec operation, so quiet it down to appropriate KERN_NOTICE.

Machines that have slow console baud rate benefit from less output.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Simon Horman <horms@verge.net.au>
Acked-by: Dave Young <dyoung@redhat.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 15d70a90b50d..f7ae04b8de6f 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1171,7 +1171,7 @@ int kernel_kexec(void)
 		 * CPU hotplug again; so re-enable it here.
 		 */
 		cpu_hotplug_enable();
-		pr_emerg("Starting new kernel\n");
+		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
 
-- 
2.24.0

