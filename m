Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED417C1DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 16:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFPcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 10:32:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44953 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:32:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id n7so2838100wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w97Pp2fKkn2kGX06OWuM0pYdHRbBbR8ZYFWEc1KVtOc=;
        b=eDnly6+wEeDutBAHN/dpAogQanE64PUyaCrAQFzo+sbg1i1Zp6bT8pxKj3Na/J1/5t
         XSxLDoR7a2Z5Af7faSCuE82OOz2Ud/uFgbw7auGxcmeUMNy7FnhLfwSwgC/w3HRFrmV8
         fg2Jfo7z7bbdfgULDMeAZsrGQ4xJdXkrsLtPpdqQhDBR2LrQccnnyfUktExKwg/SOAhK
         lXyVa5ppyTAU+Sap+/JyA9FEVxsmJnUxI4n4c3+RD6H7Z4zdrRWGVJFRd6q2yKULiikV
         9lDi5qpSdA4Joe1trfiFfsTBr9qWNZ2XbVJ/S/GNtHf2+5IirdI7EPhm1JJI8r6SjXk0
         4iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w97Pp2fKkn2kGX06OWuM0pYdHRbBbR8ZYFWEc1KVtOc=;
        b=FQ2LHs42JVfS+hETzPD/Cui4j3rsN/4qdjNOh35e4kupMUZ4yF7Zx9dLpVGgp/rtw4
         omOzhlw8CNIFVTe02HFi9p/2Ixkp/JfrxHBWCcHgyVm8jTe5XpEug3PTcyZURVjcYrJi
         Yo3sO9Nr68d5qL6sXrECBSlpuvXoAQeNVGF29WpqRISlyr5rv15nH6PGsvb4GF57bAzF
         BkEJxMJXzqV8Op+F3jYwvJUx+8baLBjh4L65eTPXu5ZvsfL32IstCqM3nHkJVx//Bmak
         Ul+JsRv4CKsgaXRd0T9GwERpwKjwrWAKjsyMYI+2u4P42xG7Yc8M6Q7QKNtFNelOH7Jn
         D4lw==
X-Gm-Message-State: ANhLgQ1valyk2KjkFCbSd+9RSMoCogc+O+5OA8rtRxqQ06IexVwyPpR3
        2RO3XUxjxMv4/6twg+CpgMu8vynPOP8=
X-Google-Smtp-Source: ADFU+vubD3BVDpKLzjLUgrQJ4T0Z9+TJjxru4N+98iWBwWsiW7iX3358rrmIOG6W/NTWUWg1/qivpA==
X-Received: by 2002:adf:e911:: with SMTP id f17mr4357585wrm.87.1583508723318;
        Fri, 06 Mar 2020 07:32:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h20sm29006397wrc.47.2020.03.06.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 07:32:02 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH-next] serial/sysrq: Add a help-string for MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Fri,  6 Mar 2020 15:31:56 +0000
Message-Id: <20200306153156.579921-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it more obvious what almost everyone wants to set here.

Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: linux-serial@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 38a8f3c99579..c4a45817918a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -439,6 +439,8 @@ config MAGIC_SYSRQ_SERIAL_SEQUENCE
 	  Specifies a sequence of characters that can follow BREAK to enable
 	  SysRq on a serial console.
 
+	  If unsure, leave an empty string and the option will not be enabled.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.25.0

