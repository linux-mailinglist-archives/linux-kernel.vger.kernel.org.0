Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B1217AE4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 19:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCESjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 13:39:47 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49483 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgCESjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:39:47 -0500
Received: by mail-pg1-f201.google.com with SMTP id b10so3715751pgi.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bSM9inO0XUL/aHKZ8mCFI+boS4Y8DDilOWOqau7zZY8=;
        b=ZinfgwHbZuJEjlZdJ5XfivpxaMQunf4Z2GS/REK7ruL5Ow6SQc1WS12g1Oq5tjGbxy
         ghayY9XcSjRpnw/KdgHy+mGTaS8fBm/wQrrF7036yv+jHAuw4ondSOGHaWQ9Lb3MXoOZ
         WHssGk0Qqo4NrvpcwNflQsMcs2sKv4DgWWhTyTKsuDTOGl4/2JwxngqnlAsWzZtIq4Ti
         sFi4J7wH+8fAGcfs5mSH4rKl/UFXXK17tDmvc79NKlqfp1fGbMkJ6KX3gyXFYKqmjkwV
         cNWYyjOyPNI44f+7X8zfUgCGruQQG6qu1AnoCFu/BPM2llVJyntNLdf84JoeS5GvLc7m
         N+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bSM9inO0XUL/aHKZ8mCFI+boS4Y8DDilOWOqau7zZY8=;
        b=l1GI4TdSY+UrkP5vRJzZeEexDW+nJj5hRl25kRY5F52DPUjNXHxpYLTykskbV72lCK
         tcXCVNG/Waw/i65a+jEOeNlmZ4b/OV3vBCYDhKO6fiHbdHxQH78bZDcsoYagwJ+roHT7
         tOpl0Xa1qNVcZx2ZSY7lpR4yvO8nFa4JhTYEo4UxmfufYI4fpzOYQ4DCMGfVAXvmsvYk
         559nq1JkNmC3F1MjQCTQCypYDyV43C7uBcWXuToNMemooKPUTDfGkJO+0C66pktZNOqj
         0YV0rq+fvUZ5jC6736+7GvoFbYipRZAzP5XdpzbRNBnQQV4HiO98LxDlP3gx9Ocq4+HK
         4QHw==
X-Gm-Message-State: ANhLgQ02IVbiLivCeqRSPuGK1+u/AONTtW5Wj9UuEOfmXxgPNZGDuHON
        6bB3wOWBCz9hhx5fG/ebpf/rO1hJBQMQXA==
X-Google-Smtp-Source: ADFU+vsH7E1MakHjDstA3ac6tbwpzfPrFpw4zUvLo5VvbNd2KgofyisUnI6Yo+XyCsEwJCdKcrKamuE6XghvTQ==
X-Received: by 2002:a17:90a:33c2:: with SMTP id n60mr9530807pjb.177.1583433586226;
 Thu, 05 Mar 2020 10:39:46 -0800 (PST)
Date:   Thu,  5 Mar 2020 10:39:39 -0800
Message-Id: <20200305183939.256241-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] um: Fix overlapping ELF segments when statically linked
From:   David Gow <davidgow@google.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     brendanhiggins@google.com, trishalfonso@google.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When statically linked, the .text section in UML kernels is not page
aligned, causing it to share a page with the executable headers. As
.text and the executable headers have different permissions, this causes
the kernel to wish to map the same page twice (once as headers with r--
permissions, once as .text with r-x permissions), causing a segfault,
and a nasty message printed to the host kernel's dmesg:

"Uhuuh, elf segment at 0000000060000000 requested but the memory is
mapped already"

By aligning the .text to a page boundary (as in the dynamically linked
version in dyn.lds.S), there is no such overlap, and the kernel runs
correctly.

Signed-off-by: David Gow <davidgow@google.com>
---
I'm not 100% sure what triggered this -- possibly a change to the host
kernel on my machine -- as I'm able to reproduce the issue as far back
as in 4.4, but it seems to be reproducible easily on my machine with
defconfig + CONFIG_STATIC_LINK=y.


 arch/um/kernel/uml.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 9f21443be2c9..3b6dab3d4501 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -19,10 +19,10 @@ SECTIONS
   __binary_start = START;
 
   . = START + SIZEOF_HEADERS;
+  . = ALIGN(PAGE_SIZE);
 
   _text = .;
   INIT_TEXT_SECTION(0)
-  . = ALIGN(PAGE_SIZE);
 
   .text      :
   {
-- 
2.25.0.265.gbab2e86ba0-goog

