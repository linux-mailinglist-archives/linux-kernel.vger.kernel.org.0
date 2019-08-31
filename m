Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90CFA45D8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 21:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfHaTHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 15:07:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:28245 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbfHaTHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 15:07:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2019 12:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.64,451,1559545200"; 
   d="scan'208";a="206430450"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2019 12:07:05 -0700
Subject: [PATCH v3] libnvdimm: Enable unit test infrastructure compile checks
From:   Dan Williams <dan.j.williams@intel.com>
To:     jgg@ziepe.ca
Cc:     =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 31 Aug 2019 11:52:47 -0700
Message-ID: <156727753022.2310789.16427613406082399871.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infrastructure to mock core libnvdimm routines for unit testing
purposes is prone to bitrot relative to refactoring of that core.
Arrange for the unit test core to be built when CONFIG_COMPILE_TEST=y.
This does not result in a functional unit test environment, it is only a
helper for 0day to catch unit test build regressions.

Note that there are a few x86isms in the implementation, so this does
not bother compile testing this architectures other than 64-bit x86.

Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com
---
Changes since v2:
- Fixed a 0day report when the unit test infrastructure is built-in.
  Arrange for it to only compile as a module. This has received a build
  success notifcation from the robot over 142 configs.

Hi Jason,

As we discussed previously please take this through the hmm tree to give
compile coverage for devm_memremap_pages() updates.

 drivers/nvdimm/Kconfig  |   12 ++++++++++++
 drivers/nvdimm/Makefile |    4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index a5fde15e91d3..36af7af6b7cf 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -118,4 +118,16 @@ config NVDIMM_KEYS
 	depends on ENCRYPTED_KEYS
 	depends on (LIBNVDIMM=ENCRYPTED_KEYS) || LIBNVDIMM=m
 
+config NVDIMM_TEST_BUILD
+	tristate "Build the unit test core"
+	depends on m
+	depends on COMPILE_TEST && X86_64
+	default m if COMPILE_TEST
+	help
+	  Build the core of the unit test infrastructure. The result of
+	  this build is non-functional for unit test execution, but it
+	  otherwise helps catch build errors induced by changes to the
+	  core devm_memremap_pages() implementation and other
+	  infrastructure.
+
 endif
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index cefe233e0b52..6557e126892f 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -29,3 +29,7 @@ libnvdimm-$(CONFIG_BTT) += btt_devs.o
 libnvdimm-$(CONFIG_NVDIMM_PFN) += pfn_devs.o
 libnvdimm-$(CONFIG_NVDIMM_DAX) += dax_devs.o
 libnvdimm-$(CONFIG_NVDIMM_KEYS) += security.o
+
+TOOLS := ../../tools
+TEST_SRC := $(TOOLS)/testing/nvdimm/test
+obj-$(CONFIG_NVDIMM_TEST_BUILD) := $(TEST_SRC)/iomap.o

