Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D369A1249EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLROnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 09:43:42 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:43580 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLROnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:43:42 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id xBIEhFfM023662;
        Wed, 18 Dec 2019 23:43:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com xBIEhFfM023662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576680196;
        bh=tUmVeYvMx8QakjR2/czhCZu5i/UP6xrlWBeyhJE2fFc=;
        h=From:To:Cc:Subject:Date:From;
        b=fD5yEZMsKLZIXrWal+2upTacvoV2jbxZpXLrlY1kHU/JtGOe7CASd0oMxasMqMZVt
         gdDydsDyKEOUbXVGDw1E2Jg20GeY22h2A/7ZytrijmkFDVjSUP2MGX430Fd9nBR6XK
         4a8xBlv3iFg/WrBAIAR7V7J3fC4eKcnFyUVEynZfcaTN1wMAaE11BK2suV1mIgKRZF
         uloUt0UJGuhlPMiiUMYWU87578YmiLiTOFfOk9u7RiqJ79EKYohjDFky5koE7b00j3
         EFd9IQA1Q4t3N2hv70KT+PRpz0b857Y3/tYH8CGAviYtmntDId+87m5phel9TLa68E
         AHWIjwe/Xz/sw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/component: remove modular code
Date:   Wed, 18 Dec 2019 23:43:07 +0900
Message-Id: <20191218144307.19243-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/Makefile always adds component.o to obj-y, like this:

  obj-y                   := component.o core.o bus.o dd.o syscore.o \

Hence it is never compiled as a module. Remove useless modular code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/base/component.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 532a3a5d8f63..3a09036e772a 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -11,7 +11,6 @@
 #include <linux/device.h>
 #include <linux/kref.h>
 #include <linux/list.h>
-#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
@@ -775,5 +774,3 @@ void component_del(struct device *dev, const struct component_ops *ops)
 	kfree(component);
 }
 EXPORT_SYMBOL_GPL(component_del);
-
-MODULE_LICENSE("GPL v2");
-- 
2.17.1

