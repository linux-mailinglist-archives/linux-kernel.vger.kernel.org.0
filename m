Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7577DE6A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 02:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfJ1BNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 21:13:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:57247 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfJ1BNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:13:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 18:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="224486495"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2019 18:13:02 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iOtag-0004hM-6I; Mon, 28 Oct 2019 09:13:02 +0800
Date:   Mon, 28 Oct 2019 09:12:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     kbuild-all@lists.01.org, alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Greg Kurz <groug@kaod.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [RFC PATCH] nvdimm: scm_get() can be static
Message-ID: <20191028011252.ebr7djanid6k25ok@4978f4969bb8>
References: <20191025044721.16617-9-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025044721.16617-9-alastair@au1.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 0d40f55b9035 ("nvdimm: Add driver for OpenCAPI Storage Class Memory")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ocxl-scm.c          |    4 ++--
 ocxl-scm_internal.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/ocxl-scm.c b/drivers/nvdimm/ocxl-scm.c
index f4e6cc022de8a..c169cb0bc71d4 100644
--- a/drivers/nvdimm/ocxl-scm.c
+++ b/drivers/nvdimm/ocxl-scm.c
@@ -733,7 +733,7 @@ static void scm_put(struct scm_data *scm_data)
 	put_device(&scm_data->dev);
 }
 
-struct scm_data *scm_get(struct scm_data *scm_data)
+static struct scm_data *scm_get(struct scm_data *scm_data)
 {
 	return (get_device(&scm_data->dev) == NULL) ? NULL : scm_data;
 }
@@ -2142,7 +2142,7 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return -ENXIO;
 }
 
-struct pci_driver scm_pci_driver = {
+static struct pci_driver scm_pci_driver = {
 	.name = "ocxl-scm",
 	.id_table = scm_pci_tbl,
 	.probe = scm_probe,
diff --git a/drivers/nvdimm/ocxl-scm_internal.c b/drivers/nvdimm/ocxl-scm_internal.c
index e7c247835817b..ee11fb72e1ecd 100644
--- a/drivers/nvdimm/ocxl-scm_internal.c
+++ b/drivers/nvdimm/ocxl-scm_internal.c
@@ -64,8 +64,8 @@ int scm_admin_command_request(struct scm_data *scm_data, u8 op_code)
 	return scm_command_request(scm_data, &scm_data->admin_command, op_code);
 }
 
-int scm_command_response(const struct scm_data *scm_data,
-			 const struct command_metadata *cmd)
+static int scm_command_response(const struct scm_data *scm_data,
+				const struct command_metadata *cmd)
 {
 	u64 val;
 	u16 id;
