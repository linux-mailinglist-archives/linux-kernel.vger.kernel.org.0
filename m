Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F773F265D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 05:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbfKGELf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 23:11:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:55340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733107AbfKGELf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:11:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:35 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="201295457"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:34 -0800
Subject: [PATCH 08/16] libnvdimm: Move nvdimm_bus_attribute_group to
 device_type
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 06 Nov 2019 19:57:18 -0800
Message-ID: <157309903815.1582359.6418211876315050283.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 'struct device_type' instance can carry default attributes for the
device. Use this facility to remove the export of
nvdimm_bus_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c |    6 ------
 drivers/acpi/nfit/core.c                  |    1 -
 drivers/nvdimm/bus.c                      |    9 +++++++--
 drivers/nvdimm/core.c                     |    8 ++++++--
 drivers/nvdimm/e820.c                     |    6 ------
 drivers/nvdimm/nd.h                       |    1 +
 drivers/nvdimm/of_pmem.c                  |    6 ------
 include/linux/libnvdimm.h                 |    2 --
 8 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 8354737ac340..33aa59e666e5 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -284,11 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	return 0;
 }
 
-static const struct attribute_group *bus_attr_groups[] = {
-	&nvdimm_bus_attribute_group,
-	NULL,
-};
-
 static inline int papr_scm_node(int node)
 {
 	int min_dist = INT_MAX, dist;
@@ -319,7 +314,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	p->bus_desc.ndctl = papr_scm_ndctl;
 	p->bus_desc.module = THIS_MODULE;
 	p->bus_desc.of_node = p->pdev->dev.of_node;
-	p->bus_desc.attr_groups = bus_attr_groups;
 	p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
 
 	if (!p->bus_desc.provider_name)
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 84fc1f865802..a3320f93616d 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1404,7 +1404,6 @@ static const struct attribute_group acpi_nfit_attribute_group = {
 };
 
 static const struct attribute_group *acpi_nfit_attribute_groups[] = {
-	&nvdimm_bus_attribute_group,
 	&acpi_nfit_attribute_group,
 	NULL,
 };
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 28e1b265aa63..1d330d46d036 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -300,9 +300,14 @@ static void nvdimm_bus_release(struct device *dev)
 	kfree(nvdimm_bus);
 }
 
+static const struct device_type nvdimm_bus_dev_type = {
+	.release = nvdimm_bus_release,
+	.groups = nvdimm_bus_attribute_groups,
+};
+
 bool is_nvdimm_bus(struct device *dev)
 {
-	return dev->release == nvdimm_bus_release;
+	return dev->type == &nvdimm_bus_dev_type;
 }
 
 struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev)
@@ -355,7 +360,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	badrange_init(&nvdimm_bus->badrange);
 	nvdimm_bus->nd_desc = nd_desc;
 	nvdimm_bus->dev.parent = parent;
-	nvdimm_bus->dev.release = nvdimm_bus_release;
+	nvdimm_bus->dev.type = &nvdimm_bus_dev_type;
 	nvdimm_bus->dev.groups = nd_desc->attr_groups;
 	nvdimm_bus->dev.bus = &nvdimm_bus_type;
 	nvdimm_bus->dev.of_node = nd_desc->of_node;
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 9204f1e9fd14..81231ca23db0 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -385,10 +385,14 @@ static struct attribute *nvdimm_bus_attributes[] = {
 	NULL,
 };
 
-struct attribute_group nvdimm_bus_attribute_group = {
+static const struct attribute_group nvdimm_bus_attribute_group = {
 	.attrs = nvdimm_bus_attributes,
 };
-EXPORT_SYMBOL_GPL(nvdimm_bus_attribute_group);
+
+const struct attribute_group *nvdimm_bus_attribute_groups[] = {
+	&nvdimm_bus_attribute_group,
+	NULL,
+};
 
 int nvdimm_bus_add_badrange(struct nvdimm_bus *nvdimm_bus, u64 addr, u64 length)
 {
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index 9a971a59dec7..e02f60ad6c99 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -8,11 +8,6 @@
 #include <linux/libnvdimm.h>
 #include <linux/module.h>
 
-static const struct attribute_group *e820_pmem_attribute_groups[] = {
-	&nvdimm_bus_attribute_group,
-	NULL,
-};
-
 static int e820_pmem_remove(struct platform_device *pdev)
 {
 	struct nvdimm_bus *nvdimm_bus = platform_get_drvdata(pdev);
@@ -55,7 +50,6 @@ static int e820_pmem_probe(struct platform_device *pdev)
 	struct nvdimm_bus *nvdimm_bus;
 	int rc = -ENXIO;
 
-	nd_desc.attr_groups = e820_pmem_attribute_groups;
 	nd_desc.provider_name = "e820";
 	nd_desc.module = THIS_MODULE;
 	nvdimm_bus = nvdimm_bus_register(dev, &nd_desc);
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index e7f3a2fee2ab..577800242110 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -300,6 +300,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig);
 extern const struct attribute_group *nd_pfn_attribute_groups[];
 extern const struct attribute_group nd_device_attribute_group;
 extern const struct attribute_group nd_numa_attribute_group;
+extern const struct attribute_group *nvdimm_bus_attribute_groups[];
 #else
 static inline int nd_pfn_probe(struct device *dev,
 		struct nd_namespace_common *ndns)
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index c0b5ac36df9d..8224d1431ea9 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -9,11 +9,6 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 
-static const struct attribute_group *bus_attr_groups[] = {
-	&nvdimm_bus_attribute_group,
-	NULL,
-};
-
 struct of_pmem_private {
 	struct nvdimm_bus_descriptor bus_desc;
 	struct nvdimm_bus *bus;
@@ -35,7 +30,6 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->bus_desc.attr_groups = bus_attr_groups;
 	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
 	priv->bus_desc.module = THIS_MODULE;
 	priv->bus_desc.of_node = np;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 3644af97bcb4..9df091bd30ba 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -65,8 +65,6 @@ enum {
 	DPA_RESOURCE_ADJUSTED = 1 << 0,
 };
 
-extern struct attribute_group nvdimm_bus_attribute_group;
-
 struct nvdimm;
 struct nvdimm_bus_descriptor;
 typedef int (*ndctl_fn)(struct nvdimm_bus_descriptor *nd_desc,

