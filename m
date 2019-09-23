Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1C4BB0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393323AbfIWJEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 05:04:42 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38245 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438740AbfIWJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:03:12 -0400
Received: by mail-pg1-f201.google.com with SMTP id m1so6862090pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XOGsKwy33nriWO2piNArgCsTjyMNHJTJvDyvFgo5s6U=;
        b=mXwU3V+FKUnh7EtzAXbRnlZt2+BzJmB577hg6dqpFKOKINBCJBmvRik9rFAxq7U+qO
         TO0IOP0HXoyq8DF7tcv4Sw+6NqcncbBlNZVLRB8IOXvGFZ0CWPFt4kXJJChXfj9wBeNA
         0TpQP7PWhwIPyTm2Gvducq6BRZOoHrZRa7PqdUHdEfIXSk96rGhb3YAwcsbnk5YIb2Ti
         bX6SvK1My90wFNd8GD19pxUe8PZqqKKMf81AvYg2RnSLQ8ZsSFI/pi79xHLq30VOWit5
         QBQZfbVkBRE5rAq+LH+AiH06ldWe0Thzohs2GTDYLqrvN+Dn8kr/3CaAjx6BiYzLYdRE
         ec8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XOGsKwy33nriWO2piNArgCsTjyMNHJTJvDyvFgo5s6U=;
        b=QNavkzXgzps/NFogE/nmioxKBQ0Atb925QlWXXxK4l5cpsEc3/L9Zlwhr+HjhHdoiw
         ZzAH+Y6TrAzLurVNYVwUzBrFAyWJ6Vm33WRdzxhTne5rt33Kh3mLxu7sExTRoarcDQ90
         khYJkcrZhDAA2pGdnQqR9h6SQocQBRM0MNNXzhU7YqEYVFf7BNRfqAkkQD5b0jfFqM1z
         q9MEY0p7TSYDHJo+xkvY9NIb9tjSmgVehWjRq3mDocOBKHNKDKZePu5Fnfm7ueoHhU/z
         H2dSysxMSf5E+tyRx6ylAN0cvyvfZuw0Imi+ctnqX/HkFFyNPCMAXj7tF5hI5Vfhwt8V
         T9xQ==
X-Gm-Message-State: APjAAAUSyB/LeYvP7qN+TBAe/5h0pefmLXW1QX4tOh4InDYfzIfSxg5x
        d73qPMKNz/ujJK81tKGwru6zZvdgtbZh3qXq/a354A==
X-Google-Smtp-Source: APXvYqzPRotA6TcjcX/eTkfjXx25mpD2OMLyTf6QgkxdyJUJa9UIamvT/GMsn5DUGJ9PJn3SfTrUnBsJoEKeNcvlLPCGJQ==
X-Received: by 2002:a63:487:: with SMTP id 129mr20038096pge.14.1569229391177;
 Mon, 23 Sep 2019 02:03:11 -0700 (PDT)
Date:   Mon, 23 Sep 2019 02:02:36 -0700
In-Reply-To: <20190923090249.127984-1-brendanhiggins@google.com>
Message-Id: <20190923090249.127984-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v18 06/19] lib: enable building KUnit in lib/
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the lib Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug | 2 ++
 lib/Makefile      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..1c69640e712f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1681,6 +1681,8 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
+source "lib/kunit/Kconfig"
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..67e79d3724ed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -96,6 +96,8 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
+obj-$(CONFIG_KUNIT) += kunit/
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
-- 
2.23.0.351.gc4317032e6-goog

