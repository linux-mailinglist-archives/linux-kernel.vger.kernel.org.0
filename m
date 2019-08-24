Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A432D9BE83
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfHXP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 11:27:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:36287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfHXP14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 11:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566660462;
        bh=tonf7QM2sU7urWgwrHSiSY+bTHsNzTAD7JX6t4M7mhc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hi4TuRTAWbYHlF6viwWlaxYdOb6XUAJ0o+lkWbpZWAdoQVYpN+UxMtZ/rerpAl8AW
         WitaAyd+9YDyuLvLei532ULTwZGPgwggTSi8bRtMBFYucqrFwWWzN9jV+mfI1Ly+T+
         F9ICobkHpPXR2yfi3TZubGXG0ueceWFzB8tntAEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M1HZo-1i4Iq73F7q-002s6C; Sat, 24 Aug 2019 17:27:41 +0200
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     keescook@chromium.org, re.emese@gmail.com
Cc:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Alex Dewar <alex.dewar@gmx.co.uk>
Subject: [PATCH RESEND] scripts/gcc-plugins: Add SPDX header for files without
Date:   Sat, 24 Aug 2019 16:27:09 +0100
Message-Id: <20190824152708.20571-1-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:qdudIqsAQkKPLTAmcrlFDOTqt4gIniL7iDMZjJK3Cdc3wHCh1Ve
 H6+jasce3o2+ZDixw37oJMeaCZBWYOl30DHM/sR0KQ26VRBc0UvIeHlmfA/opnq2LfPpqBY
 m0guZgGHqJYqlraeRv1GHS2qOjPK9LrnggA2Zoa9So7NIEVPMu1U4thvaSrZWYw0kwOnoyI
 SnFwdx8dgpEilvrtzx0Kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fLsPIEgKNZc=:bqVUyG6GRIQ8+8Nm60hHeG
 N4orMASromBUfOyalsY6gro+gshTzgCnTOtgrNtEMYTN7CJ7m6sbbBDTaKhVz/r5lF9rIHXao
 WcNbK94Ww0IENfQbOSAvH4//vD4JoisGeb57e9Dkp5staN11bS4ptDRG5i8J98APfnRyDdJ0p
 lIo5YdyNnsiVHxMcWgqRiAXGxWGhvtB+kpCyio7TV7YpKE47JfYDn3fKmcrUewx6MJCbtL8s4
 tyqwppIl66hzQu2FJu//f5zBtl7N62gWEgbRi2l4qMo/yWllT7Dyg1bweE2LJnNj8POhfJ3qa
 S/BOXezuhgZx/aOPwrtQd2sDm8T0dw/tjpwpmY7xLXVbgO9MNZNCXOyqW8nIXrvtfObAWfYUm
 I+cVgs7GpM/lnzqcd4ZEOu2urEMbrvIdS/QibmrIyV2J23PdGvjIYfvwl3lLS/Dxmm/nxVdUZ
 qzRmEWUnUODKlDltfjY/WM8TcRqWInnsyk7Ch2P5KTyXFpryytnAceWNGS8UGNIYrCH/Aaa19
 v1u9dhK0PJ1wxb6ZFM6ybGCtPB3caAH+l/Pg+E5xorILiQt5RAHGC8D7jwa4aOXzvYG5zzJ/7
 +YFoRkJ2tO9xxMWjxDSDOQTn5Z+/IZ5rHFiMrjg8AyckihzQO03Ol4WbcQeBdFplLvNhtp+TU
 QNq4hiPCz7idF99VdJhd0hzgvgLqrRpN0SdxKJyXfkQrzc9A3myyXSMXd2/bhbiAyNSUO6n9A
 SF+IDeVNc7R25KJrQsfwy0WUn8s3IhUywdNbW5Ie6z6SYAMSYhL32UVrSFKgl98Pzutcm78Ke
 6Tfx52HxGJIiOZYC5gy4YLk0de0dCG+vWAouWg++U86OaJklvw4f6fE7UD+mdoSkneDIyzoBm
 VqGfG23UGd+Tj2gkrW444e1iy/MdwAHXjbrXOPXtjjxN8/wT8ohfn8SrXR3jSZkZqd0RpCEzH
 gMdZdWeCZs1iZVQf5a9KWGWrsWqBLW0iuBbDsfws1QOEm5QinvELMUxZXDg8IlPkEplPfEZLx
 09p525ShLz/b+GfuikHsgzGgBGc5i9bdwBDcOK/NS9P+wfJQWG5s02bZ1MQ7/n7JjeJYVw0kJ
 wZQRND2Oy4bxdHsqlyGrqVh2fQeHptyyK2Qaq9zw+S62ngFr3EcFKvtHftHvpuzfATk0zT8b1
 A35UL8Yo2sDKnFyRFSbGzUaUPE8UmjuN9VH1hdLuTals5kLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace boilerplate with approproate SPDX header. Vim also auto-trimmed
whitespace from one line.

Ignore the previous email -- there was a typo in the patch. Sorry!

Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
---
 scripts/gcc-plugins/cyc_complexity_plugin.c   | 2 +-
 scripts/gcc-plugins/latent_entropy_plugin.c   | 2 +-
 scripts/gcc-plugins/randomize_layout_plugin.c | 4 ++--
 scripts/gcc-plugins/sancov_plugin.c           | 2 +-
 scripts/gcc-plugins/stackleak_plugin.c        | 2 +-
 scripts/gcc-plugins/structleak_plugin.c       | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/gcc-plugins/cyc_complexity_plugin.c b/scripts/gcc-plugins/cyc_complexity_plugin.c
index 1909ec617431..870266f36b5c 100644
--- a/scripts/gcc-plugins/cyc_complexity_plugin.c
+++ b/scripts/gcc-plugins/cyc_complexity_plugin.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2011-2016 by Emese Revfy <re.emese@gmail.com>
- * Licensed under the GPL v2, or (at your option) v3
  *
  * Homepage:
  * https://github.com/ephox-gcc-plugins/cyclomatic_complexity
diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index cbe1d6c4b1a5..c693ac27ddf1 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2012-2016 by the PaX Team <pageexec@freemail.hu>
  * Copyright 2016 by Emese Revfy <re.emese@gmail.com>
- * Licensed under the GPL v2
  *
  * Note: the choice of the license means that the compilation process is
  *       NOT 'eligible' as defined by gcc's library exception to the GPL v3,
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index bd29e4e7a524..f46d049da26c 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2014-2016 by Open Source Security, Inc., Brad Spengler <spender@grsecurity.net>
  *                   and PaX Team <pageexec@freemail.hu>
- * Licensed under the GPL v2
  *
  * Note: the choice of the license means that the compilation process is
  *       NOT 'eligible' as defined by gcc's library exception to the GPL v3,
@@ -909,7 +909,7 @@ static unsigned int find_bad_casts_execute(void)
 			} else {
 				const_tree ssa_name_var = SSA_NAME_VAR(rhs1);
 				/* skip bogus type casts introduced by container_of */
-				if (ssa_name_var != NULL_TREE && DECL_NAME(ssa_name_var) &&
+				if (ssa_name_var != NULL_TREE && DECL_NAME(ssa_name_var) &&
 				    !strcmp((const char *)DECL_NAME_POINTER(ssa_name_var), "__mptr"))
 					continue;
 #ifndef __DEBUG_PLUGIN
diff --git a/scripts/gcc-plugins/sancov_plugin.c b/scripts/gcc-plugins/sancov_plugin.c
index 0f98634c20a0..9845ad67a7d8 100644
--- a/scripts/gcc-plugins/sancov_plugin.c
+++ b/scripts/gcc-plugins/sancov_plugin.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2011-2016 by Emese Revfy <re.emese@gmail.com>
- * Licensed under the GPL v2, or (at your option) v3
  *
  * Homepage:
  * https://github.com/ephox-gcc-plugins/sancov
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index dbd37460c573..3abaea274651 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2011-2017 by the PaX Team <pageexec@freemail.hu>
  * Modified by Alexander Popov <alex.popov@linux.com>
- * Licensed under the GPL v2
  *
  * Note: the choice of the license means that the compilation process is
  * NOT 'eligible' as defined by gcc's library exception to the GPL v3,
diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
index e89be8f5c859..eb8d6b5c83b5 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -1,6 +1,6 @@
+// Licensed under the GPL v2
 /*
  * Copyright 2013-2017 by PaX Team <pageexec@freemail.hu>
- * Licensed under the GPL v2
  *
  * Note: the choice of the license means that the compilation process is
  *       NOT 'eligible' as defined by gcc's library exception to the GPL v3,
--
2.23.0

