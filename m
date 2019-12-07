Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AB115BF9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLGLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Dec 2019 06:14:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35785 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfLGLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 06:14:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id c20so8449018wmb.0;
        Sat, 07 Dec 2019 03:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HUdFIVx2th3a0bTzer3FVDj/Iewx06i7IgtcXEeOoiY=;
        b=bZYbzzXNc0ZgUJb7ev3S0jNCENJThXwsNWeZ3cJ3Z5ek1jlJAJzw6lnS+8PuWM4BRy
         kg6r05GuR2GuN189FPLXkZh6Y4klKyux4jzk8XQyZYbRyYKwzi8ub1LFfzH1lM4rkN71
         UxAadc+q/eiOfEjn2g/CCMHi7x6evvnSKGy8+nFyt3imB+a95F/j/PfA5wivYaH826ju
         G+V/AfKZDKi0WK+s3xKINSbWqwZl2Fxw95+ahbYYZGt6sH0k9h/YK98cHQQ/0V49hiJr
         aw9Ax4ILP3E8fmf8JCz0tmztxPRm9hcXuvUunmKfbnI91Wsf2/R8pH6QsKS3rYDNfsVj
         pscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HUdFIVx2th3a0bTzer3FVDj/Iewx06i7IgtcXEeOoiY=;
        b=KcBABSCf9NmyvggCQFM96dSnRr7fjTzmbojrT7WIw/L8EVOJbSCqm0agLnvpoSm0so
         zw8xDQXJa+EN97lGesDhsKo9fPX4VVJK0/iWljshmMfST8AUi+kn008jwuAFWXfPKPBA
         pXERhU808F2hErqpP0HsVqL+s44ZPMOqPw+kgL7gN4GfKljX7T9mkbOb7/aKz8eN44I2
         b3F/SEcU1Kf77GpLJ2wpvZIYVUm8YhVGR9pPOzvZTHX3ONxl2HI74iPvmJzlY+CJohuG
         xxqc24LzYvREdnsodoxp0s5gIKjwIVQ1aG9uTt36HKBGOrRbNBFhXlx4dHctVkDbMhw7
         U/BQ==
X-Gm-Message-State: APjAAAULPm5Ubd899p+F+Dby8+ridZJK4Eb1TH1zGr0/TEzCslrYYrFo
        GDNbnvBoRub0nKvhhQgLZFU=
X-Google-Smtp-Source: APXvYqzk5XwcKSTUFMdpM/DSCrwTnN0PBPDDfRT+RlJDRdJ2zKgB/mlUT2CDg8zLmXxkZz9ZOmSwEg==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr15321560wmk.113.1575717284044;
        Sat, 07 Dec 2019 03:14:44 -0800 (PST)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id a20sm6617475wmd.19.2019.12.07.03.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 03:14:43 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, rostedt@goodmis.org,
        arnaldo.melo@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] libtraceevent: allow custom libdir path
Date:   Sat,  7 Dec 2019 11:14:40 +0000
Message-Id: <20191207111440.6574-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I use prefix=/usr and try to install libtraceevent in my laptop it
tries to install in /usr/lib64. I am not having any folder as /usr/lib64
and also the debian policy doesnot allow installing in /usr/lib64. It
should be in /usr/lib/x86_64-linux-gnu/.

Quote: No package for a 64 bit architecture may install files in
	/usr/lib64/ or in a subdirectory of it.
ref: https://www.debian.org/doc/debian-policy/ch-opersys.html

Make it more flexible by allowing to mention libdir_relative while
installing so that distros can mention the path according to their policy
or use the default one.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

Hi Steve,

And yet another one (hopefully the final one for now). I know I missed
the merge window, but your Ack should be ok.

 tools/lib/traceevent/Makefile         | 5 +++--
 tools/lib/traceevent/plugins/Makefile | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index c5a03356a999..7e2450ddd7e1 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -39,11 +39,12 @@ DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
 
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
-  libdir_relative = lib64
+  libdir_relative_temp = lib64
 else
-  libdir_relative = lib
+  libdir_relative_temp = lib
 endif
 
+libdir_relative ?= $(libdir_relative_temp)
 prefix ?= /usr/local
 libdir = $(prefix)/$(libdir_relative)
 man_dir = $(prefix)/share/man
diff --git a/tools/lib/traceevent/plugins/Makefile b/tools/lib/traceevent/plugins/Makefile
index f440989fa55e..edb046151305 100644
--- a/tools/lib/traceevent/plugins/Makefile
+++ b/tools/lib/traceevent/plugins/Makefile
@@ -32,11 +32,12 @@ DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
 
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
-  libdir_relative = lib64
+  libdir_relative_tmp = lib64
 else
-  libdir_relative = lib
+  libdir_relative_tmp = lib
 endif
 
+libdir_relative ?= $(libdir_relative_tmp)
 prefix ?= /usr/local
 libdir = $(prefix)/$(libdir_relative)
 
-- 
2.11.0

