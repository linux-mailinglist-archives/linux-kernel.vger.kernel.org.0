Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C592103C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfKTNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfKTNjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:49 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832FA2251E;
        Wed, 20 Nov 2019 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257188;
        bh=8IpINrqwcyYVNNgaoPjhzTg9UX2ShnQpxVLaIAYVeu0=;
        h=From:To:Cc:Subject:Date:From;
        b=MUJnfRYQU4kAfT3G+xU9z80qQaS5q2BAxEvg+ArG0dYEjPZhZluv0l7kBAyjF6+pI
         ntaChlNi63Hb1cvgJ7F9tn+5ipSD6M+XrduzxfoJAwC5thllDITjA5z+Kw8XkZryAy
         /szVZ5Y+pzRckObTahRRmy0pFokQNjuA6CiFBq00=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH] rpmsg: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:44 +0800
Message-Id: <20191120133945.13938-1-krzk@kernel.org>
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
 drivers/rpmsg/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b41eca5..709276540ef1 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -21,7 +21,7 @@ config RPMSG_QCOM_GLINK_NATIVE
 
 config RPMSG_QCOM_GLINK_RPM
 	tristate "Qualcomm RPM Glink driver"
-        select RPMSG_QCOM_GLINK_NATIVE
+	select RPMSG_QCOM_GLINK_NATIVE
 	depends on HAS_IOMEM
 	depends on MAILBOX
 	help
-- 
2.17.1

