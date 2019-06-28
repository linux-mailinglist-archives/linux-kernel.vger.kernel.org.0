Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7159AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfF1Mam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:30:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfF1Mai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uAxc64m0YT9J0kbGiEkc+YaJw8vJxgW+inXWfdPD3Qw=; b=LY3wMBFBIqG8+KElqz7riZgz86
        pV5wBJUFxDt6hvK/wynT8kI8cmkKIBiYw6tqGOUuaw4pQg+sGR+LbFgodNRijDZA1U7exZU1DVyL/
        3LxuMVGvYRGwjQcsNLczibXMoZuBMNXgtxV8925kezoqtIQndXqKSBPaQ/DIeNta+1bqpVN+7dzwi
        XP3LAgPLkTutL9dUXqhuaKcALvgU0kh5M+JykR0L8VNu2hNe7l0LpPstnbaTgWoygnmjz65N1RyT7
        +0id112akVCASW71orwA+weM1V6mYQ+XpwyNHwjHUaUZ20nclGTwQ2aCAtAVtj/mplbphW2x1Vgck
        t5Lbecvg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055t-O1; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Td-Qy; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 34/39] docs: add a memory-devices subdir to driver-api
Date:   Fri, 28 Jun 2019 09:30:27 -0300
Message-Id: <93469c726df18907ce08fe60642690f67e367b57.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two docs describing memory device drivers.

Add both to this new chapter of the driver-api.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst               |  1 +
 .../driver-api/memory-devices/index.rst          | 16 ++++++++++++++++
 .../{ => driver-api}/memory-devices/ti-emif.rst  |  2 +-
 .../memory-devices}/ti-gpmc.rst                  |  2 +-
 4 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/driver-api/memory-devices/index.rst
 rename Documentation/{ => driver-api}/memory-devices/ti-emif.rst (98%)
 rename Documentation/{bus-devices => driver-api/memory-devices}/ti-gpmc.rst (99%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 12d68c3ab792..e33849b948c7 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -79,6 +79,7 @@ available subsections can be seen below.
    isapnp
    generic-counter
    lightnvm-pblk
+   memory-devices/index
    men-chameleon-bus
    ntb
    nvmem
diff --git a/Documentation/driver-api/memory-devices/index.rst b/Documentation/driver-api/memory-devices/index.rst
new file mode 100644
index 000000000000..87549828f6ab
--- /dev/null
+++ b/Documentation/driver-api/memory-devices/index.rst
@@ -0,0 +1,16 @@
+=========================
+Memory Controller drivers
+=========================
+
+.. toctree::
+    :maxdepth: 1
+
+    ti-emif
+    ti-gpmc
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/memory-devices/ti-emif.rst b/Documentation/driver-api/memory-devices/ti-emif.rst
similarity index 98%
rename from Documentation/memory-devices/ti-emif.rst
rename to Documentation/driver-api/memory-devices/ti-emif.rst
index c9242294e63c..dea2ad9bcd7e 100644
--- a/Documentation/memory-devices/ti-emif.rst
+++ b/Documentation/driver-api/memory-devices/ti-emif.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ===============================
 TI EMIF SDRAM Controller Driver
diff --git a/Documentation/bus-devices/ti-gpmc.rst b/Documentation/driver-api/memory-devices/ti-gpmc.rst
similarity index 99%
rename from Documentation/bus-devices/ti-gpmc.rst
rename to Documentation/driver-api/memory-devices/ti-gpmc.rst
index 87c366e418be..33efcb81f080 100644
--- a/Documentation/bus-devices/ti-gpmc.rst
+++ b/Documentation/driver-api/memory-devices/ti-gpmc.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ========================================
 GPMC (General Purpose Memory Controller)
-- 
2.21.0

