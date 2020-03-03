Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342EB17753C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 12:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgCCLYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 06:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgCCLYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:24:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3C820836;
        Tue,  3 Mar 2020 11:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583234674;
        bh=rv9OqmSphTP2/Bi7sPUwcbWh5FMkNeF2by0BEe7Sn6I=;
        h=From:To:Cc:Subject:Date:From;
        b=Dbun/+OzK23dwpHsIUxgDaAJRJUj5UO9FayvErqiPSef/P3JjiLBcHvE8/sAP2rMo
         /O+Wq1G7CD+KM7gndunf+WR+f5k/2Ae5jzGsV7FfZEIYpVjrVsDOiYidFnl6Sbsjjz
         dxVrVXXJKI0m+V4hwGyYkeoncU2VaxqTBtKA6cn4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] tools/bootconfig: Add O= option and enhance error message
Date:   Tue,  3 Mar 2020 20:24:30 +0900
Message-Id: <158323467008.10560.4307464503748340855.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are patches to update tools/bootconfig to add O= option
support and enhance error message so that user can easily
locate the error position.

Thank you,

---

Masami Hiramatsu (2):
      bootconfig: Support O=<builddir> option
      tools/bootconfig: Show line and column in parse error


 include/linux/bootconfig.h          |    3 ++-
 init/main.c                         |   14 ++++++++++----
 lib/bootconfig.c                    |   35 ++++++++++++++++++++++++++---------
 tools/bootconfig/Makefile           |   27 +++++++++++++++++----------
 tools/bootconfig/main.c             |   35 +++++++++++++++++++++++++++++++----
 tools/bootconfig/test-bootconfig.sh |   14 ++++++++++----
 6 files changed, 96 insertions(+), 32 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
