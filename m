Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED28D6BF71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfGQQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 12:07:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33647 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:07:40 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hnmRp-0001kR-Bn
        for linux-kernel@vger.kernel.org; Wed, 17 Jul 2019 16:06:29 +0000
Received: by mail-io1-f71.google.com with SMTP id v3so27614706ios.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObxAaTqUw3sBO2ywY0jCPLtrtzU2IECjcL3XtvnRiSM=;
        b=EcdUfBzm89cTNHkkTOYnGNa/4SXyvemOWnBfDDnVR+xUqAd4STXmFtiYEwUSku1c1D
         m7ui85jPfQnJL4JxcbvSabrotfVlwy9YYVMNuxQDCdN4O6sMU4q3Y0Th2nGCTZNX9q1e
         X7Y7p8Sl0NQiPesGifD1EoyqsI0QYBZnovh0cw7b5v6yvNa7hpbzvdODl/i1damZG0yU
         MnamCj58hsYWCSsjkFqf3TzX5gMzq4eUhlgG/tHxIYEe/9IVzP+VRv3WGRwRb8Ocm2c+
         Ayevi7S+3cUqAM+TU1SULx1rNNqg0ruuax/vndnTo3z+DTqLSgNJ9LzC6Iu9XzbxfVMZ
         VrkQ==
X-Gm-Message-State: APjAAAVPCkPBrxVTb+GTJHELnTli+6gz5wfRvaY+IH0zPgXoQjUlNEp8
        TMI2Xmf5I57fE/wQPknbKbpd1QgdUQOWACzSh3BnZkx+2XKM+j6SHkzYbH0zUxMmnqdd7gziIew
        uJz75iZQQpbr68bUz7y1oLb/Qbz97BTnpunQAo5mBcg==
X-Received: by 2002:a02:528a:: with SMTP id d132mr40218809jab.68.1563379588303;
        Wed, 17 Jul 2019 09:06:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBuJDwsdyIv42Ja0H/JR0OavxWZsQpl28VV7R8Rn30XEDFhWtft8Tow/C3eQQxbsOze1vNEA==
X-Received: by 2002:a02:528a:: with SMTP id d132mr40218777jab.68.1563379588038;
        Wed, 17 Jul 2019 09:06:28 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:31dd:dc66:96d:f1eb])
        by smtp.gmail.com with ESMTPSA id p3sm24812022iom.7.2019.07.17.09.06.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 09:06:27 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: add -fcf-protection=none when using retpoline flags
Date:   Wed, 17 Jul 2019 11:06:26 -0500
Message-Id: <20190717160626.26293-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gcc -fcf-protection=branch option is not compatible with
-mindirect-branch=thunk-extern. The latter is used when
CONFIG_RETPOLINE is selected, and this will fail to build with
a gcc which has -fcf-protection=branch enabled by default. Adding
-fcf-protection=none when building with retpoline enabled
prevents such build failures.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 3e4868a6498b..73a94d1db2b6 100644
--- a/Makefile
+++ b/Makefile
@@ -878,6 +878,12 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 # change __FILE__ to the relative path from the srctree
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
+# ensure -fcf-protection is disabled when using retpoline as it is
+# incompatible with -mindirect-branch=thunk-extern
+ifdef CONFIG_RETPOLINE
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none,)
+endif
+
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS := $(call ar-option,D)
 
-- 
2.20.1

