Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F06BC5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 12:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409506AbfIXKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 06:36:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409464AbfIXKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ch6ORGkVqxEoLiMBJqGn8qo1Z9XLDxLeSPoTDpA7CU=; b=ZDGjgQSeHgureY4fbUlyZBZGJ
        GYQeNq+8O70TqkqDpCOvmyjmTHY/ORoiSWQfS6IcSSjk2hIgE6+QJTu7gbMEzXcABsKOaUMgdMGEN
        k85Ihv11mPgC0v8aftpcYNcfCvp/H2tUkQ9B3H9exchS/4Naxf2hpabY5zW6wEEDpDgf0+ojdy5C7
        K4cM80srnZC7ROhdB79jLLN7I1Q3X2IX39/OGAt3EOIGAtjkKgBQVGH8T+Z3KJ51/1hKfQuJWzQX9
        tprN6GUOCXqK4sR8PVaD1X17l3n25SQwS7+ZAukfYqFUwVmW3OGX1XRwp77UAoezEkoh/mYDL9lxB
        hVJ4fbPkw==;
Received: from 177.96.206.173.dynamic.adsl.gvt.net.br ([177.96.206.173] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCiAu-0004Dg-Fo; Tue, 24 Sep 2019 10:36:04 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iCiAq-0008Gv-Md; Tue, 24 Sep 2019 07:36:00 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] media: v4l2-fwnode: fix location of acpi/dsd documentation
Date:   Tue, 24 Sep 2019 07:36:00 -0300
Message-Id: <c7e1b210db1c656bbf1a9488aca26c936ab7577a.1569321356.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This got moved to the firmware-guide.

Fixes: f2dde1ed0f28 ("Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and convert to reST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 3bd1888787eb..0e361565f2f9 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -819,7 +819,7 @@ static int v4l2_fwnode_reference_parse(struct device *dev,
  *
  * THIS EXAMPLE EXISTS MERELY TO DOCUMENT THIS FUNCTION. DO NOT USE IT AS A
  * REFERENCE IN HOW ACPI TABLES SHOULD BE WRITTEN!! See documentation under
- * Documentation/acpi/dsd instead and especially graph.txt,
+ * Documentation/firmware-guide/acpi/dsd instead and especially graph.txt,
  * data-node-references.txt and leds.txt .
  *
  *	Scope (\_SB.PCI0.I2C2)
-- 
2.21.0

