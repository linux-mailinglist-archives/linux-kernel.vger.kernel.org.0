Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1467F167C65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 12:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBULoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 06:44:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgBULoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:44:21 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F8124670;
        Fri, 21 Feb 2020 11:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285460;
        bh=dl1o7B3h6sZDgG4E/cGCuPVa3J6ZrDeJyBg6plK5/Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nj9FRQjuX09YKQ5NNMDxhsWmRXmikfLxfYHh88//rqOFt4Amj/dQtNkBCqdZwuMc7
         xcKY1xN0TcazpjslxWJZ32gimTWi6Gkvms5eOU/ynNZ/pdECS+xiEYgrTRC5BWTUYD
         Nx/MC/gSXqJI/uf1mRK1+YIjipwLgTe8FXKFtaN8=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, akpm@linux-foundation.org,
        Will Deacon <will@kernel.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] kallsyms: Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()
Date:   Fri, 21 Feb 2020 11:44:04 +0000
Message-Id: <20200221114404.14641-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221114404.14641-1-will@kernel.org>
References: <20200221114404.14641-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kallsyms_lookup_name() and kallsyms_on_each_symbol() are exported to
modules despite having no in-tree users and being wide open to abuse by
out-of-tree modules that can use them as a method to invoke arbitrary
non-exported kernel functions.

Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol().

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/kallsyms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9b3f660dee7..16c8c605f4b0 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -175,7 +175,6 @@ unsigned long kallsyms_lookup_name(const char *name)
 	}
 	return module_kallsyms_lookup_name(name);
 }
-EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 
 int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 				      unsigned long),
@@ -194,7 +193,6 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 	}
 	return module_kallsyms_on_each_symbol(fn, data);
 }
-EXPORT_SYMBOL_GPL(kallsyms_on_each_symbol);
 
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
-- 
2.25.0.265.gbab2e86ba0-goog

