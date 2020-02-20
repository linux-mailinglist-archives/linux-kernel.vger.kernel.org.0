Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF56165856
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 08:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgBTH03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 02:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgBTH02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:26:28 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB9B24654;
        Thu, 20 Feb 2020 07:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582183588;
        bh=uNIHbqumAC6ZtH7f4LkLWi1UDVSaJ9V3rGs4himqles=;
        h=From:To:Cc:Subject:Date:From;
        b=Rorymk0XBA5lSQm+c8ih3Z6C9l/5rGEVeVKkDxpKSBxZG6NT7BaHLvMAZCfrmSIf8
         pdvzEvbOnThgJoTWeHR/IlJfyvA651Ot7n/KA5eHgyYSet3nAXw+OpHWChKUZpHWqb
         3x+o9/v1XtTgHvgwD+tfQegV/XtZi5OM5+31S5JE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/8] bootconfig: Update for the recent reports
Date:   Thu, 20 Feb 2020 16:26:23 +0900
Message-Id: <158218358363.6940.18380270211351882136.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are some patches to update bootconfig. There are
several implementation changes and syntax fix/updates.

As we discussed in the previous thread, modifies bootconfig.

 - [1/8] Make CONFIG_BOOT_CONFIG=n by default
 - [2/8] Add magic word for bootconfig
 - [8/8] Print array as multiple commands for
         legacy command line

With the magic word, we can identify bootconfig without
checksum, also if we find a wrong bootconfig, there is no
reason to suppress the error message anymore.

 - [3/8] Remove unneeded error message silencer
 - [4/8] Remove unneeded checksum

In addition, I found some issues on bootconfig syntax, so
fix it. (these also include testcase update)

 - [5/8] Reject if subkey and value has same parent
 - [6/8] Overwrite value on same key by default
 - [7/8] Add append value operator ("+=")

To update synchronously, each patch includes code, test
and documentation. If it is better to split (especially
documentation). please let me know.

TODO: support kernel builtin bootconfig. Should we reuse
firmware builtin loader? But it seems we just need a Makefile.

Thank you,

---

Masami Hiramatsu (8):
      bootconfig: Set CONFIG_BOOT_CONFIG=n by default
      bootconfig: Add bootconfig magic word for indicating bootconfig explicitly
      tools/bootconfig: Remove unneeded error message silencer
      bootconfig: Remove unneeded checksum
      bootconfig: Reject subkey and value on same parent key
      bootconfig: Overwrite value on same key by default
      bootconfig: Add append value operator support
      bootconfig: Print array as multiple commands for legacy command line


 Documentation/admin-guide/bootconfig.rst     |   37 +++++++++++-
 include/linux/bootconfig.h                   |    3 +
 init/Kconfig                                 |    2 -
 init/main.c                                  |   54 +++++++-----------
 kernel/trace/Kconfig                         |    3 +
 lib/bootconfig.c                             |   44 +++++++++++----
 tools/bootconfig/include/linux/printk.h      |    5 --
 tools/bootconfig/main.c                      |   77 +++++++++++---------------
 tools/bootconfig/samples/bad-mixed-kv1.bconf |    3 +
 tools/bootconfig/samples/bad-mixed-kv2.bconf |    3 +
 tools/bootconfig/test-bootconfig.sh          |   31 +++++++++-
 11 files changed, 164 insertions(+), 98 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
