Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464C515D1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 07:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgBNGKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 01:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgBNGKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:10:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A620624650;
        Fri, 14 Feb 2020 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581660635;
        bh=ccWxPqghqqwusF6IA8zulp1Gnt4scD6yp6+04wbics0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lR6AwgcjCO7+wJbsnAEFnaKZlPV90BOQTlMxKI1ERhqD8qZox/VacBYmMrN/HBcIT
         E9kew8MNgv/YJpWFyFuI9MAax2zxlRoqdHzw+prgBTcKf90GmgV5Bn1XIye8Kzi6Ku
         mEj94052Pck9O121ozzIahbftmL69eitJefDtoyM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/3] random: rng-seed source is utf-8
Date:   Fri, 14 Feb 2020 15:10:27 +0900
Message-Id: <158166062748.9887.15284887096084339722.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158166060044.9887.549561499483343724.stgit@devnote2>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Salyzyn <salyzyn@android.com>

commit 428826f5358c922dc378830a1717b682c0823160
("fdt: add support for rng-seed") makes the assumption that the data
in rng-seed is binary, when it is typically constructed of utf-8
characters which has a bitness of roughly 6 to give appropriate
credit due for the entropy.

Fixes: 428826f5358c ("fdt: add support for rng-seed")
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Kees Cook <keescook@chromium.org>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..ee21a6a584b1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2306,7 +2306,7 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 void add_bootloader_randomness(const void *buf, unsigned int size)
 {
 	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
-		add_hwgenerator_randomness(buf, size, size * 8);
+		add_hwgenerator_randomness(buf, size, size * 6);
 	else
 		add_device_randomness(buf, size);
 }

