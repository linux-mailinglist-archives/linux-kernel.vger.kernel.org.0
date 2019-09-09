Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3873ADB05
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 16:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfIIOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 10:18:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45153 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731355AbfIIOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:18:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so7900112pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qv666E59dTrURX4bKRzC5KjavofhrzL5P4tc/irNvlY=;
        b=A8Wua1cb5Dd+5+yNpo7O/rOG4CYpwnZU/cqP8i8w9PLmTyGxbWNLp/uiuj9qFEbO0F
         PpQP4AvWVQouoUX2aFQzNy3i8Y4jjzhnPv+dqzsPTV8qsxH/7OuGgF5h4ABd0VR/2SY6
         VY614hxmPr2OXJcBb/wYXUnZqeIQXo1MJCGsi5POdgZfZPdXWl2G6p8uWDzzI4n/yzP4
         kow44nzgyruKBhO39CaiBZiEvVtiZ/TMaoetfQyB2uF5XOYYqHvpAqFwslJKGrIMBV/A
         fRpiCyQ9Xu+qJuuB9QLbg93O3kQB12bDcSbaMdkcGIWJ9YGmTwdqzEygjHZ/AZYkxp0L
         nyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qv666E59dTrURX4bKRzC5KjavofhrzL5P4tc/irNvlY=;
        b=XN2j8ppIRWDS3EhSFvmateW1Vw86KIkJEJUqU3P0nZ4QtXgSS5EYCxT1phrHwibzBc
         T3kRQ3JzF/Y74edAbOUCrobgIgl9Z/Vw7yobgMwOgfuKmdl5Kw5gt8ZELICt/WAKfSjh
         pN5/pinlrG3laP+c+DTw9Jx1BH31Uy6tgEsEtyk5kNCQpljyfApl1KS/1lAgjMdgjSwz
         BlQeM9fPJsLkU/Vd27nyjvGtDOQU3QorH2WjLWGcUoPUaFah++cGPXYNRiPqjXgV6eU5
         URCwQXRraqNG1Pg3tkhsHulCJpa6DoRUJRp/WxDmbyK+pNcmG+JEsb+Us/yvZ6qjB8ru
         4uzQ==
X-Gm-Message-State: APjAAAVWVAdXrpUbluHnSJVRuNAPDIzuquz3tn5k66U4CCSr43nnQXjG
        8j+l4SppPSXg/EQVNULlOLE=
X-Google-Smtp-Source: APXvYqxHBtagbDHaSqvx4876QJFPhpvkvnpOSc1tPCpqTOqVjSxvJ2BREswQoz/Mm/4u9MNgRZw2Hw==
X-Received: by 2002:aa7:800c:: with SMTP id j12mr28387606pfi.255.1568038731423;
        Mon, 09 Sep 2019 07:18:51 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:18:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 2/9] kconfig/hacking: Create submenu for arch special debugging options
Date:   Mon,  9 Sep 2019 22:18:16 +0800
Message-Id: <20190909141823.8638-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch special options are a little long, so create a submenu for them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bd3938483514..cc4d8e71ae81 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2164,6 +2164,10 @@ config DEBUG_AID_FOR_SYZBOT
        help
          This option is intended for testing by syzbot.
 
+menu "$(SRCARCH) Debugging"
+
 source "arch/$(SRCARCH)/Kconfig.debug"
 
+endmenu
+
 endmenu # Kernel hacking
-- 
2.20.1

