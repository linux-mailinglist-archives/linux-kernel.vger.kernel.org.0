Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C84B799
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 14:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfFSMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 08:03:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34318 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:03:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so9641298pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EEXv6OMy394IyZML1QdABv+r+xrD1aaFYD59SwDtNVA=;
        b=qog6owLf5XB7xLEjwtYgYfnK0o1CMpg2T+qs5OhFpq5HnZKFyIy7dcVThpeTJzErn1
         z5lHoXqWGPmuDJxO/P/rahhxC7Q1Xi0GLBGFviL3LjKhB9YdUYN2/e0/65v6CVzxmcmp
         tyUQqISASiWBdfA4ZFYxbyGoT+iOOcvQI/tUWYsmxFzuEVE7+NU1D3ylQhi/jZAr32oy
         OusXht59EyMw5rxV55pO60NRYlPfHc8ELI8cX+JtyHujEVkxOKKC+knATMktykYf5q+h
         A4lCTm9VEeFHnCA58Tcay866XHpGBpi+vvtP4sS87j0iMlIWrfb/UbARjJNVuIhzkZEh
         Mvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EEXv6OMy394IyZML1QdABv+r+xrD1aaFYD59SwDtNVA=;
        b=J02mG7pZF4NmrZAk8H5W5YgW4n8Tqye9TLXzLLu6V9Xqx5fZkJQqNeusw9kUmz7P8r
         Vk0sk/Ja4WuAvDZmlvUqpLo+G4kzq/wFnaDq5otImVxkYdGOzgKO1ZZAI9RGyDXUc7T8
         jUxHV9xHq2FLvG4pyN0dooF1zO4T+3qj48pYlfgmbckhV/AnHLe+0XefkRcg6mBvbGCu
         ZHfEDcflBnKkzHzRWNEWwTgCDzCcLOSSWWYl2+VKVRaHX2C6xqCsnluTeSDY8UoxGqC5
         mf2Xxi6+h9diwT0qCI7KWPYFpz9/+XlIOTgh3t9It9viWE+/UJDtWWvQ8bioxktLJhEl
         Ow/w==
X-Gm-Message-State: APjAAAXMJy3zOH8ll3ObwhFqd9oEeePDo1w6sl+xCxKiUl/alk/n76Sv
        M7Wk0tPZLY8fYKxd8mDAJvdV9g==
X-Google-Smtp-Source: APXvYqw7WwjF3ykJC6GXoZtSZcFhTgNHbFa6QrbBD8x3/qCxw0+7QrdxcB9f7MaJ53e0OX9BZUnNWw==
X-Received: by 2002:a65:500d:: with SMTP id f13mr7343091pgo.151.1560945826174;
        Wed, 19 Jun 2019 05:03:46 -0700 (PDT)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id d19sm1531664pjs.22.2019.06.19.05.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 05:03:45 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH] objtool: Be lenient about -Wundef
Date:   Wed, 19 Jun 2019 05:03:37 -0700
Message-Id: <20190619120337.78624-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some libelf versions use undefined macros, which combined with newer GCC
makes for errors from system headers. This isn't overly useful to fail
compiling objtool for.

Error as seen:

cc1: all warnings being treated as errors
In file included from arch/x86/../../elf.h:10,
                 from arch/x86/decode.c:14:
/usr/include/libelf/gelf.h:25:5: error: "__LIBELF_INTERNAL__" is not defined, evaluates to 0 [-Werror=undef]
 #if __LIBELF_INTERNAL__
     ^~~~~~~~~~~~~~~~~~~

For this reason, skip -Wundef on objtool.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 tools/objtool/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 88158239622bc..0c49206c5216b 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,6 +35,8 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
+# Some system libelf versions uses undefined "#if <var>", so skip the warning/error
+WARNINGS += -Wno-undef
 CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
-- 
2.11.0

