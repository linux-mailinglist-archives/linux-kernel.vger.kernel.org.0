Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29E103BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfKTNhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:37:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKTNg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:59 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E1922475;
        Wed, 20 Nov 2019 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257018;
        bh=AZ0W4jvxY51C1IAsZYJ9MmE95bZLpEukhm4Wi0wn59w=;
        h=From:To:Cc:Subject:Date:From;
        b=Y1ibQEvoQifCggJUk0lW5UEqiDJj0GzLBW9H4/deRSj4+DrmV/0Kz4LexIn32EZZL
         gKYNtfQAK0UIC7Pr8tOBMKfXiCuG8eQkxmHCw4hE0DJrPNdFHrSlyBoEFz//ultmuV
         252hAP/he6FE5HTFR86+ubpTuczJ15eeJ7JmjBy0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH] um: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:54 +0800
Message-Id: <20191120133654.11838-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/um/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index fec6b4ca2b6e..2a6d04fcb3e9 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -153,7 +153,7 @@ config KERNEL_STACK_ORDER
 	  It is possible to reduce the stack to 1 for 64BIT and 0 for 32BIT on
 	  older (pre-2017) CPUs. It is not recommended on newer CPUs due to the
 	  increase in the size of the state which needs to be saved when handling
-          signals.
+	  signals.
 
 config MMAPPER
 	tristate "iomem emulation driver"
-- 
2.17.1

