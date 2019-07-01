Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8226659A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfF1MUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:20:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfF1MUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kz7NpCoqFlQivUcHWgI6dJqevP9W6MEo67gi223n7jc=; b=Ih8r+LTZmA+cAU8X/EC+KpPvZs
        MD+AN7Hujj7nIqr3cGqiwnAlSN3/GRD8AJrEbrZbDcz4dM9a6gMKw0vbSL/4nPDFOXVSPZuJVPYUg
        l9rJ/t0ceuu4mTavQlqtdSIW2J0B1NSNTRRT8rdXeXc1lhA2ooT0ZTrfMfDc066qncZxUYPnJ22Ia
        JEuLCveOrkJOHUQAb94Dv7lAuzJjl7eQ4OlReJr7tyiQno7q0DxrG4+aHjlJHBpt/+xl8lcXu2Grt
        6ROcBVmWFmVIjghN1WZCc7XGACsGDVKLaOMChQ/q7r5bhn3VaGxy0+emhFXbLeunFaNe8PGAfox2M
        6B3X3XdQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-0000A5-EL; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00058F-H6; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 18/43] docs: nvmem: convert docs to ReST and rename to *.rst
Date:   Fri, 28 Jun 2019 09:20:14 -0300
Message-Id: <601be92c030ca1a73fb84dc2c9e004fcb33dd6b8.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to add it into a doc book, we need first
convert it to ReST.

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - mark literal blocks;
  - adjust title markups.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/nvmem/{nvmem.txt => nvmem.rst} | 112 ++++++++++---------
 1 file changed, 59 insertions(+), 53 deletions(-)
 rename Documentation/nvmem/{nvmem.txt => nvmem.rst} (62%)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.rst
similarity index 62%
rename from Documentation/nvmem/nvmem.txt
rename to Documentation/nvmem/nvmem.rst
index fc2fe4b18655..3866b6e066d5 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.rst
@@ -1,5 +1,10 @@
-			    NVMEM SUBSYSTEM
-	  Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+:orphan:
+
+===============
+NVMEM Subsystem
+===============
+
+ Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 This document explains the NVMEM Framework along with the APIs provided,
 and how to use it.
@@ -40,54 +45,54 @@ nvmem_device pointer.
 
 nvmem_unregister(nvmem) is used to unregister a previously registered provider.
 
-For example, a simple qfprom case:
+For example, a simple qfprom case::
 
-static struct nvmem_config econfig = {
+  static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.owner = THIS_MODULE,
-};
+  };
 
-static int qfprom_probe(struct platform_device *pdev)
-{
+  static int qfprom_probe(struct platform_device *pdev)
+  {
 	...
 	econfig.dev = &pdev->dev;
 	nvmem = nvmem_register(&econfig);
 	...
-}
+  }
 
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
 Users of board files can define and register nvmem cells using the
-nvmem_cell_table struct:
+nvmem_cell_table struct::
 
-static struct nvmem_cell_info foo_nvmem_cells[] = {
+  static struct nvmem_cell_info foo_nvmem_cells[] = {
 	{
 		.name		= "macaddr",
 		.offset		= 0x7f00,
 		.bytes		= ETH_ALEN,
 	}
-};
+  };
 
-static struct nvmem_cell_table foo_nvmem_cell_table = {
+  static struct nvmem_cell_table foo_nvmem_cell_table = {
 	.nvmem_name		= "i2c-eeprom",
 	.cells			= foo_nvmem_cells,
 	.ncells			= ARRAY_SIZE(foo_nvmem_cells),
-};
+  };
 
-nvmem_add_cell_table(&foo_nvmem_cell_table);
+  nvmem_add_cell_table(&foo_nvmem_cell_table);
 
 Additionally it is possible to create nvmem cell lookup entries and register
-them with the nvmem framework from machine code as shown in the example below:
+them with the nvmem framework from machine code as shown in the example below::
 
-static struct nvmem_cell_lookup foo_nvmem_lookup = {
+  static struct nvmem_cell_lookup foo_nvmem_lookup = {
 	.nvmem_name		= "i2c-eeprom",
 	.cell_name		= "macaddr",
 	.dev_id			= "foo_mac.0",
 	.con_id			= "mac-address",
-};
+  };
 
-nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
+  nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
 
 NVMEM Consumers
 +++++++++++++++
@@ -99,43 +104,43 @@ read from and to NVMEM.
 =================================
 
 NVMEM cells are the data entries/fields in the NVMEM.
-The NVMEM framework provides 3 APIs to read/write NVMEM cells.
+The NVMEM framework provides 3 APIs to read/write NVMEM cells::
 
-struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *name);
-struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *name);
+  struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *name);
+  struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *name);
 
-void nvmem_cell_put(struct nvmem_cell *cell);
-void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
+  void nvmem_cell_put(struct nvmem_cell *cell);
+  void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 
-void *nvmem_cell_read(struct nvmem_cell *cell, ssize_t *len);
-int nvmem_cell_write(struct nvmem_cell *cell, void *buf, ssize_t len);
+  void *nvmem_cell_read(struct nvmem_cell *cell, ssize_t *len);
+  int nvmem_cell_write(struct nvmem_cell *cell, void *buf, ssize_t len);
 
-*nvmem_cell_get() apis will get a reference to nvmem cell for a given id,
+`*nvmem_cell_get()` apis will get a reference to nvmem cell for a given id,
 and nvmem_cell_read/write() can then read or write to the cell.
-Once the usage of the cell is finished the consumer should call *nvmem_cell_put()
-to free all the allocation memory for the cell.
+Once the usage of the cell is finished the consumer should call
+`*nvmem_cell_put()` to free all the allocation memory for the cell.
 
 4. Direct NVMEM device based consumer APIs
 ==========================================
 
 In some instances it is necessary to directly read/write the NVMEM.
-To facilitate such consumers NVMEM framework provides below apis.
+To facilitate such consumers NVMEM framework provides below apis::
 
-struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
-struct nvmem_device *devm_nvmem_device_get(struct device *dev,
+  struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
+  struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 					   const char *name);
-void nvmem_device_put(struct nvmem_device *nvmem);
-int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
+  void nvmem_device_put(struct nvmem_device *nvmem);
+  int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
 		      size_t bytes, void *buf);
-int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
+  int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
-int nvmem_device_cell_read(struct nvmem_device *nvmem,
+  int nvmem_device_cell_read(struct nvmem_device *nvmem,
 			   struct nvmem_cell_info *info, void *buf);
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
+  int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
 Before the consumers can read/write NVMEM directly, it should get hold
-of nvmem_controller from one of the *nvmem_device_get() api.
+of nvmem_controller from one of the `*nvmem_device_get()` api.
 
 The difference between these apis and cell based apis is that these apis always
 take nvmem_device as parameter.
@@ -145,12 +150,12 @@ take nvmem_device as parameter.
 
 When a consumer no longer needs the NVMEM, it has to release the reference
 to the NVMEM it has obtained using the APIs mentioned in the above section.
-The NVMEM framework provides 2 APIs to release a reference to the NVMEM.
+The NVMEM framework provides 2 APIs to release a reference to the NVMEM::
 
-void nvmem_cell_put(struct nvmem_cell *cell);
-void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
-void nvmem_device_put(struct nvmem_device *nvmem);
-void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
+  void nvmem_cell_put(struct nvmem_cell *cell);
+  void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
+  void nvmem_device_put(struct nvmem_device *nvmem);
+  void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
 
 Both these APIs are used to release a reference to the NVMEM and
 devm_nvmem_cell_put and devm_nvmem_device_put destroys the devres associated
@@ -162,20 +167,21 @@ Userspace
 6. Userspace binary interface
 ==============================
 
-Userspace can read/write the raw NVMEM file located at
-/sys/bus/nvmem/devices/*/nvmem
+Userspace can read/write the raw NVMEM file located at::
 
-ex:
+	/sys/bus/nvmem/devices/*/nvmem
 
-hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
+ex::
 
-0000000 0000 0000 0000 0000 0000 0000 0000 0000
-*
-00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
-0000000 0000 0000 0000 0000 0000 0000 0000 0000
-...
-*
-0001000
+  hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
+
+  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
+  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+  ...
+  *
+  0001000
 
 7. DeviceTree Binding
 =====================
-- 
2.21.0

