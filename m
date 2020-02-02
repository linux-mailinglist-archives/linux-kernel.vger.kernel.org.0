Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4414FB30
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 02:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBBBqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 20:46:32 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33633 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBBBqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 20:46:32 -0500
Received: by mail-pf1-f202.google.com with SMTP id c72so6731935pfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 17:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cWMg+lMkC5CwgYJ9EZeOZlpHEi0qWTvf3rAR3TItwx8=;
        b=EqLkIhXgRZk2d6ttlAE/IrZ07I3+F1wAeV3BpJTqmC62cUYA3mD9hPRRTbkA03hsgN
         IZj7P8/Hh7HdsYRONo4wDDiP3nDUp21b5agZa+7wz47v6Z4J3aIbKJ01Ijhb0VFhD5al
         phf/pX8/lAzg+hoBDNPuoBddw2c/szLCfaZl6fVoPDP6PjfJpCbm+m3QP5C/K8OeVgme
         TUSgsYlXF75y8aLvZZUQKnZvFgNS2KarOs27Hb4TU+Qdpv0mgD9aNcTyvy3YVJ+ccsaL
         h2wNhFKg3rKRc/pYB/tbNlyfIMbCC76UPFflz9iT8TgR2iZvosTXvwuVovoQvH61R6Hy
         eVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cWMg+lMkC5CwgYJ9EZeOZlpHEi0qWTvf3rAR3TItwx8=;
        b=UU2jcWYW35MARfXZPJxg7Dh7ucfl2i7Dz3J2euX+WM9QYFwo68kZbHma5NRRuiuhyr
         Os7wypQLm4vDxu+rdKhEVRIP7NXPxxrb8wXRF6DhwKR+c7wbABwrsuHy1XI1VDn3ZeJ8
         Xqs2Ik8FGOcovcmetMJi+fqN59amkJNIKzT4hrndxYZOLm9lMK2/75ITuUnUpXwJLJ1K
         I9+L3Fbin8CKLysUTl1cdzBAuz2Z4LLmzTyVwn5dXuOkEGpUyHhri7NEi4BhcPF3lDXs
         8TdL6xxeg+HI7yCNwAxLxyldGrNz6JpEANoNqKrQacg1hNe6P2nwTp/Np+h9SSA6XQYv
         Il1w==
X-Gm-Message-State: APjAAAU8M0NEPcBFfClNs0+tkS/akHnYEA5u3RGjc0Q0r2ikWp2ReN2G
        1qkcNTdCZju0sQRy4/rycIGjYEkvTkk=
X-Google-Smtp-Source: APXvYqytCAuvL8qC7xByebS+X1UOErAOhxRRMWluFWrxoVVILntVsMJsPYSA5+Z1ZQQj6bpOOlDIGN2jGQ4=
X-Received: by 2002:a63:66c6:: with SMTP id a189mr16560150pgc.401.1580607991518;
 Sat, 01 Feb 2020 17:46:31 -0800 (PST)
Date:   Sat,  1 Feb 2020 17:46:23 -0800
Message-Id: <20200202014624.75356-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] selinux: Fix typo in filesystem name
From:   Hridya Valsaraju <hridya@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Hridya Valsaraju <hridya@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the filesystem name to "binder" to enable
genfscon per-file labelling for binderfs.

Fixes: 7a4b5194747 ("selinux: allow per-file labelling for binderfs")
Signed-off-by: Hridya Valsaraju <hridya@google.com>
---

Hello,

I seem to have made the typo/mistake during a rebase. Sorry about that
:(

Thanks,
Hridya

 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 89fe3a805129..d67a80b0d8a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -699,7 +699,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	if (!strcmp(sb->s_type->name, "debugfs") ||
 	    !strcmp(sb->s_type->name, "tracefs") ||
-	    !strcmp(sb->s_type->name, "binderfs") ||
+	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "pstore"))
 		sbsec->flags |= SE_SBGENFS;
 
-- 
2.25.0.341.g760bfbb309-goog

