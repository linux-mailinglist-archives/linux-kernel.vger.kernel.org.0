Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDE394D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbfFGSyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:54:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730935AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RLKg26AY56vhgjviUN+0RLoRrM3fQBLJXacmkSsY8Z0=; b=aFvCSWHC6QO8+iuQo+XKMDOrjg
        mvxnI9C1r3xDguz8kRAW0TeiP5CPMRkbyaA2V6Qx6F5hyLulH5gaGUBH5E5tvB/Eke5rM41uY++Bo
        ysNd98ljVFSvoYjmEi6v9s53aNRBqUYzWXF/lJZQlDaXh7lG+ct1FTPlfpyQ9IBWTZ7lYL8H+XjXR
        38jPFAoDQmaCKvkjm9IYFl0KFiaM0khndspET1h6k14mAxdMhk0D/4j1qwyJh7NFQQHYo1JnQ0Bqu
        fjw9n/TKc3BJGn9S4DWOnT0Ub6rAYUDKn2NiEaH3sK05FHFdrkymFkpVMhXArwLLIy4eqNUQOSSpb
        3DKWq+xw==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sX-Kf; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Ee-9d; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 04/20] docs: mm: numaperf.rst: get rid of a build warning
Date:   Fri,  7 Jun 2019 15:54:20 -0300
Message-Id: <d919a4086be55e0d93fea5164916e393c35efb3b.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building it, it gets this warning:

	Documentation/admin-guide/mm/numaperf.rst:168: WARNING: Footnote [1] is not referenced.

The problem is that this is not really a reference, as it is not
mentioned within the documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/mm/numaperf.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index c067ed145158..a80c3c37226e 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -165,5 +165,6 @@ write-through caching.
 ========
 See Also
 ========
-.. [1] https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
-       Section 5.2.27
+
+[1] https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
+- Section 5.2.27
-- 
2.21.0

