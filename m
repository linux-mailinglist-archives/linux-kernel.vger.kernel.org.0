Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145205D9D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGCAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 20:54:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53186 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGCAyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562115282; x=1593651282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eC3388U7gS1n3ruZjbzbm4lmFXg2heaDobqQD9WiAWA=;
  b=PBp3+i+nOQYtFrJ5wwxd+9FskBdEyZkzwoKCL2BGpVNvNUD+T0eiyTtA
   IxxepJptm23B6N06VKPsakKQ9Nm8fDnKSRobQ+g9bMg8NR3L69kEH3cBH
   zJY7ZOiosTKGpvRILG6+pIgtO5I6l0AUU4U8ohIHXld+68iJxdUqCAFfC
   VRxcWu4SDnxOFtjs1jKsx4Ui2ujBI4iwnVnyBRYsFVG7tJiCkHlp9nWkV
   ogGd+mEbvHPph2LeMJEaJCyTnDR0oBoKucIddUGUoZsb7jNJpQLnjL5Gp
   z5EOJwkyyWKeN9yVY95ywMquphzvkz3Xv03yTPyE8AX2llsB/Iqm/kE3R
   Q==;
IronPort-SDR: wI8hrtd72CYlFTTqZP6FpjOBcoT2kfc6XtnKEoSfJmYM6J4SdvjpStSd3QxukOUxRcKubNM45H
 FPtKpZ/fY3ycVPFGlXi7LYXUq4C0dt78JVFrJl+CgRhk6yEPQ7nvR4DjcOsAgXrEr3pP+w/fEM
 JBu11xKqJ38zxnGiNFuJFNEwpHfR5mtASM+IYmYtJsYKoLlDfHgTypKEvFGU7fZMR9KG1w0UxL
 wYjwlTwYEMUxpDzd2p9SKTFe4QRoCl56RI4omXduYWBx71quS6cvySMrkRAf+n0wyK4wKKr0ff
 yfI=
X-IronPort-AV: E=Sophos;i="5.63,445,1557158400"; 
   d="scan'208";a="113716744"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 08:54:41 +0800
IronPort-SDR: 3Q4fSQ1tMzhHW5ow1Oa5sir8jb0nll0c5HphBwo/0eAXjkuK8UC7yG2rIjh+BJJrc/IoUSUl8E
 wFniW5mD9O9pjPu8Rji74hva7bcachap2LBgxR0FvvXi5WWQhaROdO6L7zU1Q6q300ZI0UXqyo
 +fJ7/RcRX1uyuv1la/2Q1SUiU8KUp7Hi/sZZiNfFQaIbvAXQNWbOYE24D0zrh71mxI7e24Wg4P
 1Pxz+N/4EWPQmm1JvqXeI8BI3Fn0yQWEzibEPH9e5sQsvYUh5dBOe0zfnfg7kh8d3qGmvh/MKn
 WIoXg9uMCuNWotrtXGBmUMP0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Jul 2019 17:53:41 -0700
IronPort-SDR: Dz0M+IAo+4wEj1xOA9OuK1TY7/bzSPMnj56ySQqqLHxHvhJqyk+qM7mAVnJVSzpTgtWXeJGXeT
 VR7FIVmdIBGVqnmB3xCVDmmWT+OjqX3n1v3Hd9XToK4l5EmqTrcu7eRpU7PQkGXRpqGEg0eCBV
 NwsGHI9DjzM+VRiXDScIaGRIIPUIqG5/OYkSby1iHa9my/PtofrTcTDnMAHzWfBXA2HLzqtPWT
 ReqvW0u8MFrhAYRboKlwLjqEB0pcnS80OdRU0TCPHKmKJktCldw8RVSryG1VikQdZBmsEH7sLg
 vxg=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.140])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2019 17:54:41 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-riscv@lists.infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH RESEND 1/2] uapi/asm-generic: Allow defining a custom __SIGINFO struct
Date:   Tue,  2 Jul 2019 17:52:01 -0700
Message-Id: <20190703005202.7578-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190703005202.7578-1-alistair.francis@wdc.com>
References: <20190703005202.7578-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow defining a custom __SIGINFO struct. This allows architectures to
apply their own padding and allignment requirements to the struct. This
is similar to the __ARCH_SI_ATTRIBUTES #define that already exists, but
applies to the __SIGINFO struct instead of the siginfo_t struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/asm-generic/siginfo.h | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..09b0a1abac14 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -108,23 +108,25 @@ union __sifields {
 	} _sigsys;
 };
 
-#ifndef __ARCH_HAS_SWAPPED_SIGINFO
-#define __SIGINFO 			\
-struct {				\
-	int si_signo;			\
-	int si_errno;			\
-	int si_code;			\
-	union __sifields _sifields;	\
+#ifndef __SIGINFO
+# ifndef __ARCH_HAS_SWAPPED_SIGINFO
+# define __SIGINFO 						\
+struct {							\
+	int si_signo;						\
+	int si_errno;						\
+	int si_code;						\
+	union __sifields _sifields __ARCH_SI_ATTRIBUTES;	\
 }
-#else
-#define __SIGINFO 			\
-struct {				\
-	int si_signo;			\
-	int si_code;			\
-	int si_errno;			\
-	union __sifields _sifields;	\
+# else
+# define __SIGINFO 						\
+struct {							\
+	int si_signo;						\
+	int si_code;						\
+	int si_errno;						\
+	union __sifields _sifields __ARCH_SI_ATTRIBUTES;	\
 }
-#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
+# endif /* __ARCH_HAS_SWAPPED_SIGINFO */
+#endif /* __SIGINFO */
 
 typedef struct siginfo {
 	union {
-- 
2.22.0

