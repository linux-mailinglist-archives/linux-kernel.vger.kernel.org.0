Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A41115EB4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 22:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfLGUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Dec 2019 15:54:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfLGUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 15:54:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so5099914pgk.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTwW2V/iqGwRUs5QGA+lcInh8k6UZJSdkBrxMBn7N5c=;
        b=azJLXR5QMjtkLh9J/JHZ/1uQ1SIal5gfSQonVDzDZBSLg5WNyQ2UpA9uGxkIVe/TB3
         F138SjDI+ucmcVym9VJn3Dbs0Nu2YXgYzsOCSiC4r3YzLbdz7HMGxyAu6BdRy+Z7vZvd
         2y9s01UYjs0SJ86hyfYYZSwAFqzl75a+InlhpgTEvTm4Zsl1PGEpIdL4nAK8z5tjaaZQ
         nDaOoJSJaxePw6GuQi8aebULpOYCrnU68gxjsirg3/8XAQYc3iCSf1+6TCwJXmr35E4o
         DqaNWCOMwOak2PaNXqjm7i4wnIKNcMoEJJ6udrZ0vAK6GeTCsBIsy1KLJauml+m9Mg/h
         3ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTwW2V/iqGwRUs5QGA+lcInh8k6UZJSdkBrxMBn7N5c=;
        b=Xj/4znH8hIHP6hEIT0yBMBO3G/vHBQ4pMGkjeBkkfidbxLhFad3aEvMdW1Pw4JvV7R
         10na2F6coCBcI35BPpV4+irCh0E/1UryauEpor86rkfYdsBqIG99UqsHnmO4fV1lTege
         6HPOKYTOOxbXLkJWHQAJJ3okedL5yN3A9FQumextEIReoW+3On5y7R00Gfam8KidHE4B
         TiE7teRUa5nQf4I74FTKuXlcwetWAt9dIres9ZHOHnYTu2h/FQykW0Ful8BNBM1p/A3b
         sgX4YGzJ63AGozb97s0DmZONn3ewi8YLciRlnYnDWNLemi5kRvx9tBhWrdW/OeJAh9fe
         IrPQ==
X-Gm-Message-State: APjAAAV8utbuQ+GbRcM/qiU4ojCPZfbvorHdm6K9PW5Y0SOr60sKK07A
        j2NGtEBiBOc/bLcItt37TfkzpJMp6LIAvViS
X-Google-Smtp-Source: APXvYqwj7KYX2mBIpiMNQj4ppQLXOMG9A94HF1IBDqXib7kadqQ74So9+6Tt7oj658Tte2fCiMUxHQ==
X-Received: by 2002:a62:5bc4:: with SMTP id p187mr2075817pfb.255.1575752090960;
        Sat, 07 Dec 2019 12:54:50 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id q3sm19929032pgl.15.2019.12.07.12.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 12:54:49 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] objtool: silence build output from sync-check.sh
Date:   Sat,  7 Dec 2019 12:54:20 -0800
Message-Id: <20191207205419.9344-1-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync-check.sh script prints out the path due to a "cd -" at the end
of the script, even on silent builds. This isn't needed, since the
script is never sourced (so it won't change the working directory of
the surrounding build anyway).

Just remove the cd to make the build silent.

Fixes: 2ffd84ae973b ("objtool: Update sync-check.sh from perf's check-headers.sh")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 tools/objtool/sync-check.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 9bd04bbed01e..2a1261bfbb62 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -48,5 +48,3 @@ check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
 check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
-
-cd -
-- 
2.22.GIT

