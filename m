Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA41730EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfEaNO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 09:14:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41519 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:14:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so6509569wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 06:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZdrK1AzftQ2lFRmAnMgg2BRFsJvPnpb8+n7rwb8ENo=;
        b=YDHpMCjNFsK39pQX2QF2hS9Ifn03rQQtyOMm++VW//lWYJCEVHGRHQtvpoAJhkO+bW
         1R587Aydf7/0vFR6Asmh1PtHvuJQLJgs5/4S3l0Iz3Z08mmqODyxaIEdz3YQ5w3wYPsO
         8LYoRRdIhNj02qY+MnArD5d3H1ZoucUEhh4S7WJcZTPcxfvrz4mV7nqpgKLs4B7KmRfv
         e7qfWUOA7JKGdcpflagLA4ElMUtbUV/xbFrFxodRTQIgeO5JT9BnnUgMfqUk6GeS/tG7
         PHtBtCY91ttDfXSe+BJSIsjn9qGnvngynjRIMURJXOcn3yRNGlzF9+Z+XNQeplBrfnaF
         rX7w==
X-Gm-Message-State: APjAAAXny877sUl5+SNbhuxfXUElI7rc5U1l6g1nlSau7CzbxnuZDRFr
        vIRU65TduGcc2mP7wWxmQoLQdZS7CxE=
X-Google-Smtp-Source: APXvYqyFjYG0fQWPpPD5BAusWpiHgGe0puqjsPgdt232gwqZi8oQO+bHjp+UzE1ZVpiSfFkebBCFMA==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr6463250wrg.175.1559308464600;
        Fri, 31 May 2019 06:14:24 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id x22sm6930181wmi.4.2019.05.31.06.14.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 06:14:23 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] checkpatch.pl: Warn on duplicate sysctl local variable
Date:   Fri, 31 May 2019 15:14:22 +0200
Message-Id: <20190531131422.14970-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d91bff3011cf ("proc/sysctl: add shared variables for range check")
adds some shared const variables to be used instead of a local copy in
each source file.
Warn when a chunk duplicates one of these values in a ctl_table struct:

    $ scripts/checkpatch.pl 0001-test-commit.patch
    WARNING: duplicated sysctl range checking value 'zero', consider using the shared one in include/linux/sysctl.h
    #27: FILE: arch/arm/kernel/isa.c:48:
    +               .extra1         = &zero,

    WARNING: duplicated sysctl range checking value 'int_max', consider using the shared one in include/linux/sysctl.h
    #28: FILE: arch/arm/kernel/isa.c:49:
    +               .extra2         = &int_max,

    total: 0 errors, 2 warnings, 14 lines checked

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bb28b178d929..91a4b0043b64 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6639,6 +6639,12 @@ sub process {
 				     "unknown module license " . $extracted_string . "\n" . $herecurr);
 			}
 		}
+
+# check for sysctl duplicate constants
+		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max)\b/) {
+			WARN("DUPLICATED_SYSCTL_CONST",
+				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.21.0

