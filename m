Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1BB34A16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfFDOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:19:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfFDOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RLKg26AY56vhgjviUN+0RLoRrM3fQBLJXacmkSsY8Z0=; b=YARe5T9HujcsGHMKTj3AIyD3UH
        g36H0LyssqkqAc6BpBI4py58Q3kUCWi6ajB36NPn3qGnH4JDMWTE2n8BXLihYwfdTYCihVPyXvRpi
        tGfxchcCA9EehvY8I9Fw/E0YeZuasuUtefkXN6RXytaj+y3ldT8b6KHH6SedS/ZePEoWjKdH4vzqB
        PoOHdmqmwogBLpsm32VMVbmGd03fpGGrTI//+rPfvK4ptL9On+URMT9CQq8yTwSAso4kWEY0J0pr5
        eHsdfyKhQ2TxaRrJ8dBRHFv2ZNfHGLjJokybiFYe5MnUfOWmBlTeSwO+il/3eZD5fMQnYSvz59or9
        9Nbguk1Q==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rj-Uc; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002kr-JV; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 04/22] docs: mm: numaperf.rst: get rid of a build warning
Date:   Tue,  4 Jun 2019 11:17:38 -0300
Message-Id: <146fb30513b9422859e83185cb3b7db64b4282a2.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
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

