Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAFC11BCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 20:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfLKT20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 14:28:26 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47032 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfLKT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:24 -0500
Received: by mail-pf1-f202.google.com with SMTP id w127so2697462pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z9cyJ6q/dRKwszgWPK/I6HD4udk/HngreENNBBFw7AE=;
        b=R4J+hp7ameLmcKBvWd1R3GHgVQMiqDLeCk+xK86P/IRMuh6UmJa9Faa5uqjS4kWyFg
         lL/VL+0yiQSVCjjou1PYLwUk5n8YWw+5HFdP2a92aB7l5OvSR7njVCuEuEU7ILdNksTE
         2IpI6glhHVDy6eNg96ttbF925uLPxi+VoHZCb7VWblcUGDkMrvhzGjACHIWT/UqDBsaz
         ONTjf5w9eu8EeVbm9tB0FOcag12BKE6rhip+RYd5P8VyZ62mxl0MZ8QED5kQRVYL1c0H
         UQ1HaAdchOoT2M+AZajZrwAWD8PvQ9W1PwBcEmzwoAJM3GxLhGO1mshgQ2QK1+Gs3kcV
         wa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z9cyJ6q/dRKwszgWPK/I6HD4udk/HngreENNBBFw7AE=;
        b=ng0R+N+VtQ3XKeWjTkS1psCnjRB5pHWads9ma21vBi3vYqMpzx+shJLEw2RttLPpOj
         sqNSEPVptl9KbUL4AtJlj8Qzh30d73qsLvCz8G9KZ/vy5w04x4Wxhw5pncPQnqm6ccUk
         v0Z0UwO0bFSsTDmgyiQbK5yngflVeLxxRfqLAeK9kFJJ8Tl3YHVe63uLrht061WLF5vy
         XDZOglo/xcajadG15T9hGC7dGxYkeNbIZoVNRiGg3e76iUeQDYqjHQwrNN1EWZDSo/E+
         mArwD1RqclnEVvBaLvPbQPRLBszuUWxFa3u6zy+6m3p9XSfQRIrlqa+G5PnZtnI92kLj
         26gw==
X-Gm-Message-State: APjAAAWq4o7eTT48QNZXxQmHjbaBEuRNtoNryIcDOjvALBRJe/m1S09x
        SnytRKtLmMuM2dK47Vw8se0d1cxbW2A9gKppNSjhWw==
X-Google-Smtp-Source: APXvYqyYij4yV+DXbejSHZeng6BXYHuLudblK+kNmIhwXq4dmlZ+ZGkXmoMKknhbAuxQ+DE/c95Qal0IVJbWFYYgdCBmMg==
X-Received: by 2002:a63:28a:: with SMTP id 132mr5883273pgc.165.1576092502945;
 Wed, 11 Dec 2019 11:28:22 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:27:42 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>,
        linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/fsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 92ce6d85802cc..4cc0e630ab79b 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -55,6 +55,7 @@ config FSI_MASTER_AST_CF
 
 config FSI_MASTER_ASPEED
 	tristate "FSI ASPEED master"
+	depends on HAS_IOMEM
 	help
 	 This option enables a FSI master that is present behind an OPB bridge
 	 in the AST2600.
-- 
2.24.0.525.g8f36a354ae-goog

