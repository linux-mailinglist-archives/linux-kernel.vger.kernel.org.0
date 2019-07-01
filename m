Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03662E92C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfE2XYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:24:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfE2XYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RLKg26AY56vhgjviUN+0RLoRrM3fQBLJXacmkSsY8Z0=; b=rZ83Rxai/Vc/NoHL4JyaS5WfYT
        m7l2fM4Bp6SX11WYXWgT8GyRcG9qVRPRSGSuLKFwbPFwGikhftFzHrC8rcESgBAWewfqRlEYLAe3C
        Iq2OGxyKU1PdtCQNG8bEc1Fa250ckWruJB1YQbLjcB2oK5waSy3PTar8eyMrst6zbAUIe4rMe/Alk
        xZEdwH+a1wvS+ZgQ4IiGzKm7Z6B7TNcDdQjbYCkFs1HGX/qjyA9JYYu4be4qDA/+jp5+1zPBoX/kJ
        iaP15p4mhKiMzdyB7JfGeDOsZnT6rxJdlYEH/djdZGDUUkLdtn8OUq8e0v4PyYhYJxD6Lz2i4pk1n
        NIP26BTQ==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rh-3v; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xA-Lq; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 07/22] docs: mm: numaperf.rst: get rid of a build warning
Date:   Wed, 29 May 2019 20:23:38 -0300
Message-Id: <4c511096bf40d7433cf215236e7de7d44a96b520.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
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

