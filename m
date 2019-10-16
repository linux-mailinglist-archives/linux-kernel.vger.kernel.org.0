Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5462CD8E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404619AbfJPKpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 06:45:01 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:47263 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404512AbfJPKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:45:01 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKgnY-0004DC-17; Wed, 16 Oct 2019 11:44:56 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKgnX-0007Ms-Ef; Wed, 16 Oct 2019 11:44:55 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] char/random: include <linux/hw_random.h> for add_hwgenerator_randomness
Date:   Wed, 16 Oct 2019 11:44:54 +0100
Message-Id: <20191016104454.28279-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The add_hwgenerator_randomness() is declared in <linux/hw_random.h>
but this is not being included in drivers/char/random.c so fix
the following sparse warning by including it:

drivers/char/random.c:2489:6: warning: symbol 'add_hwgenerator_randomness' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index de434feb873a..da9a58068621 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -336,6 +336,7 @@
 #include <linux/completion.h>
 #include <linux/uuid.h>
 #include <crypto/chacha.h>
+#include <linux/hw_random.h>
 
 #include <asm/processor.h>
 #include <linux/uaccess.h>
-- 
2.23.0

