Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6EA1147ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 21:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfLEUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 15:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfLEUEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:04:35 -0500
Received: from localhost.localdomain (unknown [194.230.155.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198DB24670;
        Thu,  5 Dec 2019 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575576274;
        bh=6i7NWqiwckPbF7W78MFVTVfCgJ8Ms5/BpWOxNhnaeMI=;
        h=From:To:Cc:Subject:Date:From;
        b=QCy1zTpUqeOjX5KHc1vWn36JjhU/Ro2t7HZZfk0ZLURg8cjoC7IL6vlBCYN+vYUcR
         BqFkaDlSqBmjDbxZAqsGrW5uPZor+tX8kG0zfeYq5fq3Lc/eBOIDkIByoh/Bn7ig2P
         J/dctXEC3KW7523KdYunbe/jS5AqsfEZ1JNu7nHI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] MAINTAINERS: Include Samsung SoC serial driver in Samsung entry
Date:   Thu,  5 Dec 2019 21:04:22 +0100
Message-Id: <20191205200422.5781-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung SoC (S3C, S5P and Exynos) serial driver does not have dedicated
reviewing person so some patches might be missed be Samsung-related
folks (e.g. not even reaching Samsung SoC mailing list).  Include them
in generic Samsung SoC maintainer entry to provide some level of
reviewing and care.  This will not change handling of patches (via
serial tree).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

I am not the author of the code and I do not feel confident in its
internals so if anyone else would also like to join in taking care
serial driver, feel free to let me know.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15e905b37790..d6e593ee9adc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2272,6 +2272,7 @@ F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
 F:	drivers/memory/samsung/
 F:	drivers/soc/samsung/
+F:	drivers/tty/serial/samsung*
 F:	include/linux/soc/samsung/
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
-- 
2.17.1

