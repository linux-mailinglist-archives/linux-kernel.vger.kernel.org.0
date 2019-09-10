Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EDEAE78B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405576AbfIJKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:03:30 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49700 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405541AbfIJKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:03:29 -0400
Received: by mail-pg1-f202.google.com with SMTP id a9so10332832pga.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bv5qoXxIm9QGTQUTxQOHCsSBy/Qj7ow+gIETe7B67Bk=;
        b=VS1WLrahvCRQTVPhrnh5NGtHefwOtMvCg1ehhBF6kQbjUks8gmIIHPTZiKlEzV5kxf
         GSILG6mOciwN7+TJw5Co4LVGFi5qK0QFAnE2m94COxwsfWZir8BcWl7qnooghwCvC2KW
         OrHCyqdAdw5Xn2p41aI6DRFF9qEKIfxrrip4grVq+YprBXZRDHq1v+BZhFfNqQZtGSU+
         MkTlOeSBfr1cmhliquwIJ1pSR72yuSao+a+Zeq7PDymvA1puCgUON+MjGbsFRIL7AKOB
         E2iQY+CsmctLt4DRgLWOU7nbzJNZo8Bprv0UoMEbGpfMu7q4jsa5cwb+eRL9UwxhaoQe
         RThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bv5qoXxIm9QGTQUTxQOHCsSBy/Qj7ow+gIETe7B67Bk=;
        b=bn2+FEyCDUGsQp+y+c/y5kxtTr1gXV6JSHzxDepWBeBEARck7aZTLsSJdQKrJxX32j
         Hzh+n54qLwUb2+3yPK/9gvEqZVcnxVtT07Iw27qKcH4Mlp0QFL2Rl6VcGEkSFZ/G3k+W
         VCvr9l8ia1WMU+JIxjqQJcrunGtAPFYy80Q/aGRbyRZpaWIIPkyKdG4FKidZm2whFvOX
         Xx3M7inbx/YLaEGbdXEtNZYWay44TmRFJn8lYdpBO9gYin0eCzUTyizpw00x8R2K7yOZ
         y7hqZ4p67FbeKyYMak9zn4sTdoWgNbkQBgaNMJ69zeMMPNMSe0shtOQc3GkPkyLsGvL5
         bJXA==
X-Gm-Message-State: APjAAAVONQyG12oXjBv3AeVa30RxLpKNijI6qlWKsrgE9b40SLaqQzkS
        orTL+MXIDLUUyK7SMDGNZHB1IchCI8m/zXD1guJqRw==
X-Google-Smtp-Source: APXvYqx8cHOYdn1JFbj+lJuVOsHB+4rC9cO4yzh0N7mo38wEIqxIpOO3PrkduWZWmrxebAtj1X8l6jj829HaWpjFrxVRmg==
X-Received: by 2002:a63:394:: with SMTP id 142mr27066827pgd.43.1568109808362;
 Tue, 10 Sep 2019 03:03:28 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:18 -0700
In-Reply-To: <20190910100318.204420-1-matthewgarrett@google.com>
Message-Id: <20190910100318.204420-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190910100318.204420-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 2/2] kexec: Fix file verification on S390
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I accidentally typoed this #ifdef, so verification would always be
disabled.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Reported-by: Philipp Rudo <prudo@linux.ibm.com>
---
 arch/s390/kernel/kexec_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 9b4f37a4edf1..9da6fa30c447 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -130,7 +130,7 @@ static int s390_elf_probe(const char *buf, unsigned long len)
 const struct kexec_file_ops s390_kexec_elf_ops = {
 	.probe = s390_elf_probe,
 	.load = s390_elf_load,
-#ifdef CONFIG_KEXEC__SIG
+#ifdef CONFIG_KEXEC_SIG
 	.verify_sig = s390_verify_sig,
 #endif /* CONFIG_KEXEC_SIG */
 };
-- 
2.23.0.162.g0b9fbb3734-goog

