Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2612E350
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgABHbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 02:31:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40701 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgABHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:31:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so21674520pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrxKb8FH1108rNWv898Y1pvRsrvWMXaQTRG0cZ6cWN4=;
        b=WHXpgfq2T0ZaknbGsRb2KQdZd1WxCpVQd+FJ6nQIw6s4/G2u41mULJ6jjRHM9zAEO/
         txg8Q5xR9B1uiIwB/94Eqyh9j7UT2YzgR81U/PUZzMRhtV176r837FtyvVUEnJgMv2lP
         FCFhY/0awP9nDLUTZtp5kxk3TJJLpQWsirwpFuRQubLij0iAmqwom6app9EkurGTvbpn
         EoDYGjtfRLyh4ucGzsEE24HYsyz3sitQVj+AmD7Av+NMF/1RiYVGlwl9XjUIsnGTXnJz
         6Kk5cJXHr/4BJE1/9Qoxnh5Twx3cwpx41TChflSOb8hrJh7KJYicHVxYlBEzydB2l9iW
         lEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CrxKb8FH1108rNWv898Y1pvRsrvWMXaQTRG0cZ6cWN4=;
        b=jo3IPsLG9bpCfv5NffT0eDFQD4e8B2aWuqij4Sh4jafwfc14RgZhyyOg2kQuYjpZC1
         HxiIdVHkrrvBjHgP6eBl8Cv+X1aVJhlkpZJZ8+JVbTBpc/KpbRlvhDMeMXucoIi+kYLa
         KXC9ml9xYEtBiVAF+RBUIqa+G8RpzUJJNxhS98B7SpE9FGzvyd4GMkqrYiWmCLIHl23A
         kUQHbJKj46XsyLY/WVZv++7qx0WPbJlK2/rxzdg5iMQJhLPEjwsFvQJU/+Xngr7Ofcwu
         NKrkXntZQKpAcwTLisBVh+kCHtjRRUGgI8JLqMxOuANjZdZHhv7tV/qjG37ikRB7mU2k
         EOfg==
X-Gm-Message-State: APjAAAV5lGqE8puZOZZpf1UFPjPEi28TlwCzR3ujTGH7fiLMJguPwBP9
        G9E/q69/Ig6Dvsgv7j5nRaRsXOAP
X-Google-Smtp-Source: APXvYqyrDpxgFXmjtB40vtTxDLLYeDgvQ0sydavF7TFWk/mgmYUuBcnikuBxkPTxdp6npuH+7nQ+GQ==
X-Received: by 2002:a63:465b:: with SMTP id v27mr90065720pgk.257.1577950266940;
        Wed, 01 Jan 2020 23:31:06 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id z16sm62852972pff.125.2020.01.01.23.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 23:31:06 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/config: Enable secuity features in skiroot
Date:   Thu,  2 Jan 2020 18:30:58 +1100
Message-Id: <20200102073058.163746-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This turns on HARDENED_USERCOPY with HARDENED_USERCOPY_PAGESPAN, and
FORTIFY_SOURCE.

It also enables SECURITY_LOCKDOWN_LSM with _EARLY and
LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY options enabled.

MODULE_SIG is selected by lockdown, so it is still enabled.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/configs/skiroot_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 069f67f12731..0a441c414a57 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -33,7 +33,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_STRICT_KERNEL_RWX=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SIG_FORCE=y
 CONFIG_MODULE_SIG_SHA512=y
 CONFIG_PARTITION_ADVANCED=y
@@ -297,5 +296,15 @@ CONFIG_WQ_WATCHDOG=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_ENCRYPTED_KEYS=y
+CONFIG_SECURITY=y
+CONFIG_HARDENED_USERCOPY=y
+# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
+CONFIG_HARDENED_USERCOPY_PAGESPAN=y
+CONFIG_FORTIFY_SOURCE=y
+CONFIG_SECURITY_LOCKDOWN_LSM=y
+CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
+CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY=y
+# CONFIG_INTEGRITY is not set
+CONFIG_LSM="yama,loadpin,safesetid,integrity"
 # CONFIG_CRYPTO_ECHAINIV is not set
 # CONFIG_CRYPTO_HW is not set
-- 
2.24.1

