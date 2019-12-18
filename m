Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB76C12539F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfLRUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 15:40:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34261 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfLRUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:24 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so3119029qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waxKuIHxOhP/uUMeh5H5HFDUl/+Vy4TJ7vfzF1KKkIs=;
        b=tv/JkNU1dpYLgfzT0+LNoJWQFT4wppvaIv4+jNRnmENAm1JHeegrKhJSrxouwqIQgo
         UZ7OR30GRfeq72nEEFdyscp4kLXjkV0DXq/S6XZO8enm2RkbfgNBFlNm+rBNWoWni/Uh
         W7Wtx6PrDReEAOwq47vTmZlMjtRDlvAF/H+5FArBuA/t8TK7DiTWVqIMvQlJgpCi17pg
         IiDoWQxs3ur0gQ0uiCaJ+nBKDUWYeEqCg0YIP6Xc0SlbJ+gKiQaWpgkdj81kW7PwlXpM
         GRoh6Ej9MA9O70XPk9clxa04rKgzpbx1ZPJ4rzUjpmAtW9ghAckAlSHWPBXCcxdnbdZP
         I0Xw==
X-Gm-Message-State: APjAAAW9tgJaCy9qWust2wwCKUr7ApcHZ/15J80sUc2sCNeLx4tW114g
        3hDoaAWOMoe5iCuORZ1O7uP4dzhA
X-Google-Smtp-Source: APXvYqw6JOpOe4ezHe7dNwaJgwsqlC+RCFq8VnZ8N/HFSaRoEdxZKbSojhsMe4VaC+ABhcyJHxnc/Q==
X-Received: by 2002:a37:9a58:: with SMTP id c85mr4678182qke.478.1576701623337;
        Wed, 18 Dec 2019 12:40:23 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:22 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 24/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:40:02 -0500
Message-Id: <20191218204002.30512-25-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/xtensa/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 0f93b67c7a5a..adead45debe8 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -405,8 +405,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 # if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-# elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 # endif
 #endif
 }
-- 
2.24.1

