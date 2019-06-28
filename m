Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D5459B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF1Mak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:30:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfF1Mai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SzCI/aoMGZERpe2qGFQLjwJZqvdBeyZI+FLAJ5QtJWo=; b=XsQMbiJCw344J5+iMgGwuJoZUa
        8XPcEOfZZs9+AE+zCKqI5xt9ZFP9X5+75GiPrA9D5hQwUO3a9erx08VVkEZkfSHTKbhR5fDcLNKtK
        1BIFKnuGX7cxt1+dWMQMerjhaA0H4BFFuGf24lNBYVOgYkdvZ0z4uSBm2V14187yCW8GziuYI/cIj
        vEj2mr+4hQApN77PXUe5HgAX7Pv90PgIRTPB2M+ITGCTtnNDRGloPQHqOlgaNbTpPbxPcRUYIkRCn
        5ChE+24fhFEDGvGqwiDEFZiuqujGVs0SiuBN6+s1aVXG02BLmzrfF0YXTB/UDz8VMxAaEn/Kzmy3u
        OJmR+MfQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1T-00054v-WF; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005RE-1n; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH 04/39] docs: nvdimm: add it to the driver-api book
Date:   Fri, 28 Jun 2019 09:29:57 -0300
Message-Id: <bd756f3565213887a1fe82a382f7dfe7f9119f1f.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The descriptions here are from Kernel driver's PoV.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst                 | 1 +
 Documentation/{ => driver-api}/nvdimm/btt.rst      | 0
 Documentation/{ => driver-api}/nvdimm/index.rst    | 2 --
 Documentation/{ => driver-api}/nvdimm/nvdimm.rst   | 0
 Documentation/{ => driver-api}/nvdimm/security.rst | 0
 drivers/nvdimm/Kconfig                             | 2 +-
 6 files changed, 2 insertions(+), 3 deletions(-)
 rename Documentation/{ => driver-api}/nvdimm/btt.rst (100%)
 rename Documentation/{ => driver-api}/nvdimm/index.rst (94%)
 rename Documentation/{ => driver-api}/nvdimm/nvdimm.rst (100%)
 rename Documentation/{ => driver-api}/nvdimm/security.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 93c6c9a98c41..41f5ce7dc34c 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -43,6 +43,7 @@ available subsections can be seen below.
    mtdnand
    miscellaneous
    mei/index
+   nvdimm/index
    w1
    rapidio/index
    s390-drivers
diff --git a/Documentation/nvdimm/btt.rst b/Documentation/driver-api/nvdimm/btt.rst
similarity index 100%
rename from Documentation/nvdimm/btt.rst
rename to Documentation/driver-api/nvdimm/btt.rst
diff --git a/Documentation/nvdimm/index.rst b/Documentation/driver-api/nvdimm/index.rst
similarity index 94%
rename from Documentation/nvdimm/index.rst
rename to Documentation/driver-api/nvdimm/index.rst
index 1a3402d3775e..19dc8ee371dc 100644
--- a/Documentation/nvdimm/index.rst
+++ b/Documentation/driver-api/nvdimm/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===================================
 Non-Volatile Memory Device (NVDIMM)
 ===================================
diff --git a/Documentation/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
similarity index 100%
rename from Documentation/nvdimm/nvdimm.rst
rename to Documentation/driver-api/nvdimm/nvdimm.rst
diff --git a/Documentation/nvdimm/security.rst b/Documentation/driver-api/nvdimm/security.rst
similarity index 100%
rename from Documentation/nvdimm/security.rst
rename to Documentation/driver-api/nvdimm/security.rst
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index e89c1c332407..a5fde15e91d3 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -33,7 +33,7 @@ config BLK_DEV_PMEM
 	  Documentation/admin-guide/kernel-parameters.rst).  This driver converts
 	  these persistent memory ranges into block devices that are
 	  capable of DAX (direct-access) file system mappings.  See
-	  Documentation/nvdimm/nvdimm.rst for more details.
+	  Documentation/driver-api/nvdimm/nvdimm.rst for more details.
 
 	  Say Y if you want to use an NVDIMM
 
-- 
2.21.0

