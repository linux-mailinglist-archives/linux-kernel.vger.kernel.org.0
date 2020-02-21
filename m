Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7C16844B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBUQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 11:59:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgBUQ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582304393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jVP+GaOAhxIYChDGXltTUu+msDFFHu1e+G/CR9YhvOw=;
        b=Mr8qL71mbhsYVJBL88UJAQaKfFpOLpzUo7PMT4os5TbS6P7Fcyw933RrmElkfndKIqHDuA
        OnL39nbaO1dHUNv08BSKoi0X1Os8G7RJlHCy2I6J4MMZ4BY67LT600Q0s4Nt1N3pGVzzxH
        YNzcYkfr3FKOzwl/f9g5+9iKOfyiOC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39--qK4B4NONbSQOdTxiS95Yg-1; Fri, 21 Feb 2020 11:59:47 -0500
X-MC-Unique: -qK4B4NONbSQOdTxiS95Yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 346381005510;
        Fri, 21 Feb 2020 16:59:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-191.ams2.redhat.com [10.36.116.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3002660C99;
        Fri, 21 Feb 2020 16:59:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend] x86/purgatory: Make sure we fail the build if purgatory.ro has missing symbols
Date:   Fri, 21 Feb 2020 17:59:41 +0100
Message-Id: <20200221165941.508653-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we link purgatory.ro with -r aka we enable "incremental linking"
no checks for unresolved symbols is done while linking purgatory.ro.

Changes to the sha256 code has caused the purgatory in 5.4-rc1 to have
a missing symbol on memzero_explicit, yet things still happily build.

This commit adds an extra check for unresolved symbols by calling ld
without -r before running bin2c to generate kexec-purgatory.c.

This causes a build of 5.4-rc1 with this patch added to fail as it should=
:

  CHK     arch/x86/purgatory/purgatory.ro
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
make[2]: *** [arch/x86/purgatory/Makefile:72:
    arch/x86/purgatory/kexec-purgatory.c] Error 1
make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
make: *** [Makefile:1650: arch/x86] Error 2

This will help us catch missing symbols in the purgatory sooner.

Note this commit also removes --no-undefined from LDFLAGS_purgatory.ro
as that has no effect.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Add a .gitignore file with purgatory.chk listed in it

Changes in v2:
- Using 2 if_changed lines under a single rule does not work, then
  1 of the 2 will always execute each build.
  Instead add a new (unused) purgatory.chk intermediate which gets
  linked from purgatory.ro without -r to do the missing symbols check
- This also fixes the check generating an a.out file (oops)
---
 arch/x86/purgatory/.gitignore |  1 +
 arch/x86/purgatory/Makefile   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/purgatory/.gitignore

diff --git a/arch/x86/purgatory/.gitignore b/arch/x86/purgatory/.gitignor=
e
new file mode 100644
index 000000000000..d2be1500671d
--- /dev/null
+++ b/arch/x86/purgatory/.gitignore
@@ -0,0 +1 @@
+purgatory.chk
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee5444379..5bb58247699d 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,8 +14,12 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
=20
 CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
=20
-LDFLAGS_purgatory.ro :=3D -e purgatory_start -r --no-undefined -nostdlib=
 -z nodefaultlib
-targets +=3D purgatory.ro
+# Since we link purgatory.ro with -r unresolved symbols are not checked,=
 so we
+# also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
+PURGATORY_LDFLAGS :=3D -e purgatory_start -nostdlib -z nodefaultlib
+LDFLAGS_purgatory.ro :=3D -r $(PURGATORY_LDFLAGS)
+LDFLAGS_purgatory.chk :=3D $(PURGATORY_LDFLAGS)
+targets +=3D purgatory.ro purgatory.chk
=20
 KASAN_SANITIZE	:=3D n
 KCOV_INSTRUMENT :=3D n
@@ -58,12 +62,15 @@ CFLAGS_string.o			+=3D $(PURGATORY_CFLAGS)
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
=20
+$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
+		$(call if_changed,ld)
+
 targets +=3D kexec-purgatory.c
=20
 quiet_cmd_bin2c =3D BIN2C   $@
       cmd_bin2c =3D $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
=20
-$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
=20
 obj-$(CONFIG_KEXEC_FILE)	+=3D kexec-purgatory.o
--=20
2.25.0

