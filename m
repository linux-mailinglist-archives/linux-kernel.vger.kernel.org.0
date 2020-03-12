Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC3182F99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCLLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 07:50:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbgCLLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584013801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztweBegpBjV4t/LQbkEVQbgX+4OHEnOz1D5LiPs8ggU=;
        b=S1j4V7j+3rnJNX7gtkH8U+swL2OWa9XrKvzn/jT+2/F5lHjMzSuztS5uhMepvpLy/28RU0
        Ip7kXlWM9wIrdUP2Z47/1iy+5JznlsxjJvxSktwBPfSrmIK6sfJnMbwOYyBU6+IxjlCCCf
        MzZTYuBwAJpZUagqi9LCJhtATbfBT/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-7Hv6t-59PVKcMqZDSLWCgg-1; Thu, 12 Mar 2020 07:49:57 -0400
X-MC-Unique: 7Hv6t-59PVKcMqZDSLWCgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D717800D48;
        Thu, 12 Mar 2020 11:49:56 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE6192D1C;
        Thu, 12 Mar 2020 11:49:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] x86/purgatory: Make sure we fail the build if purgatory.ro has missing symbols
Date:   Thu, 12 Mar 2020 12:49:51 +0100
Message-Id: <20200312114951.56009-2-hdegoede@redhat.com>
In-Reply-To: <20200312114951.56009-1-hdegoede@redhat.com>
References: <20200312114951.56009-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index 4a35b9b94cb5..85221cb71c72 100644
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
 GCOV_PROFILE	:=3D n
 KASAN_SANITIZE	:=3D n
@@ -60,12 +64,15 @@ CFLAGS_string.o			+=3D $(PURGATORY_CFLAGS)
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
2.25.1

