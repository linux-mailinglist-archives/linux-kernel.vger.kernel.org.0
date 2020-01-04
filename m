Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F413313032B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgADPXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 10:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgADPW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:59 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F9E24653;
        Sat,  4 Jan 2020 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151379;
        bh=JcKdUDqAnsO5QdZc7CTmxgabj62q2qR0lsbmqufRSD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTDqxS7bmyCQQAdS6rpmtSI1AZybB1/4rpK60Ez4g5Kyv08fvyvvMxkBUls8+xpbb
         hndwRfFPb1rp9aja1yJTPSvtMvF5e5ifeYNXIXBTLACM2OqxISXWfZqYWFZgGS1H3y
         GqHSzZzwQe7WUYjz8l6Io2KN1RbWOeFr2kMBWLhU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 18/20] mfd: samsung: Rename Samsung to lowercase
Date:   Sat,  4 Jan 2020 16:21:05 +0100
Message-Id: <20200104152107.11407-19-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
name.

"SAMSUNG" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 420900852166..1ce6eced7983 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1065,7 +1065,7 @@ config MFD_RN5T618
 	  functionality of the device.
 
 config MFD_SEC_CORE
-	tristate "SAMSUNG Electronics PMIC Series Support"
+	tristate "Samsung Electronics PMIC Series Support"
 	depends on I2C=y
 	select MFD_CORE
 	select REGMAP_I2C
-- 
2.17.1

