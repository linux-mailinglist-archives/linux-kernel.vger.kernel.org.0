Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 191295B300
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 05:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfGADDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 23:03:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39360 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfGADDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:03:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so5268802pgc.6;
        Sun, 30 Jun 2019 20:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X70VFLfWIhqBoUXWsH6RXmb+76ghGZZQltBE94Cn00k=;
        b=RUQnKNr5tkW/tmbhj2GyHk7SqQ3L+BpO/wxhjgZRlkNR6Co8j6pbEbSuFk+ZZ+SR2+
         kfcYCQJ84IDDWBdj5mt+jkJmC/IlTJzjL0X9Xy6EIB9KvOh/dZxXGviDVsCoZdGVTQOX
         f65PTD/dqibdHw4RHkrWmxjj7Z5XLeljxXH9eFjTppcFYLX7Cltb/Y7qofUVx8hSzuQF
         fucGgJybqUWq3i46UZcsqLtA0lFq6YufZc0GqPHqvjYy3407FHBP44CPK/cdQh60V+kj
         HvmsjamYaxWQzhmTwxXrDwnvIG9vUhx2sr1DMzTOKbmCMjYyd+QxguCnxSW4gUq/8SBZ
         NL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X70VFLfWIhqBoUXWsH6RXmb+76ghGZZQltBE94Cn00k=;
        b=mtcidk3yoMJ0NoPGTqC3hvwxZe1HZ3mSecGq0eleQYfLsjx7UN1cX6cqvj+1ZH/Ug8
         s4BXavSsZi8OPTffOC9K+SZUJJIsx80AqGHnOzTcV9l5VkptAHMwaySS3uhOId0VZ9tE
         Dn9PxpO7Yw7vm9FTnKac5Djfa2789ATkQfwF2WJ8a9Qkbq6vsrHK5SVYx4XPkE219bAj
         NevmTzWbAmaDJDNoU/XjBSt0Snfi3K1KcAkUSCFicL62DXwiopMTjb4SogcChiRggbLe
         0MrB/RXI7BlX0UmvMErLERRlGBqMwr11DQLqQh7HF2HNGELgkuHzf3uku2QoLYKXYMxV
         o9sA==
X-Gm-Message-State: APjAAAU7/dvGmhiJC6pq1Ktu8yOMoUmXJkl0UBCORtAqm1PWy8uYL2wa
        ABHCqaWgPC8zl2FLWgVF8b4=
X-Google-Smtp-Source: APXvYqxnReXQASm+dckD/j+P3INcLw9259b9GEc58UmCwJsaFlBj2HX0qcl25lPDvr+Y6s1EinFUVQ==
X-Received: by 2002:a63:d755:: with SMTP id w21mr22411206pgi.311.1561950214346;
        Sun, 30 Jun 2019 20:03:34 -0700 (PDT)
Received: from localhost.localdomain ([110.70.47.183])
        by smtp.gmail.com with ESMTPSA id y16sm9756704pff.89.2019.06.30.20.03.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 20:03:33 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] cifs: fix build by selecting CONFIG_KEYS
Date:   Mon,  1 Jul 2019 12:03:25 +0900
Message-Id: <20190701030325.18188-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CIFS_ACL had a dependency "depends on KEYS" which was
dropped with the removal of CONFIG_CIFS_ACL. This breaks the
build on systems which don't have CONFIG_KEYS in .config:

cifsacl.c:37:15: error: variable ‘cifs_idmap_key_acl’ has
                 initializer but incomplete type
   37 | static struct key_acl cifs_idmap_key_acl = {
      |               ^~~~~~~
cifsacl.c:38:3: error: ‘struct key_acl’ has no member
                named ‘usage’
   38 |  .usage = REFCOUNT_INIT(1),
      |   ^~~~~
[..]

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 fs/cifs/Kconfig   | 1 +
 fs/cifs/cifsacl.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index 3eee73449bdd..5912751e6f09 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -17,6 +17,7 @@ config CIFS
 	select CRYPTO_ECB
 	select CRYPTO_AES
 	select CRYPTO_DES
+	select KEYS
 	help
 	  This is the client VFS module for the SMB3 family of NAS protocols,
 	  (including support for the most recent, most secure dialect SMB3.1.1)
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 78eed72f3af0..8ca479caf902 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/key.h>
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
-- 
2.22.0

