Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36298143211
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 20:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgATTTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 14:19:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:35262 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgATTTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:19:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400"; 
   d="scan'208";a="258800861"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:08 -0800
Subject: [PATCH v3 3/6] powerpc/papr_scm: Switch to numa_map_to_online_node()
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        x86@kernel.org
Date:   Mon, 20 Jan 2020 11:03:05 -0800
Message-ID: <157954698550.2239526.944556508250743163.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core exports numa_map_to_online_node() switch to that
instead of the locally coded duplicate.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c |   21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index c2ef320ba1bf..057ed703e882 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -284,25 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	return 0;
 }
 
-static inline int papr_scm_node(int node)
-{
-	int min_dist = INT_MAX, dist;
-	int nid, min_node;
-
-	if ((node == NUMA_NO_NODE) || node_online(node))
-		return node;
-
-	min_node = first_online_node;
-	for_each_online_node(nid) {
-		dist = node_distance(node, nid);
-		if (dist < min_dist) {
-			min_dist = dist;
-			min_node = nid;
-		}
-	}
-	return min_node;
-}
-
 static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 {
 	struct device *dev = &p->pdev->dev;
@@ -347,7 +328,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
 	target_nid = dev_to_node(&p->pdev->dev);
-	online_nid = papr_scm_node(target_nid);
+	online_nid = numa_map_to_online_node(target_nid);
 	ndr_desc.numa_node = online_nid;
 	ndr_desc.target_node = target_nid;
 	ndr_desc.res = &p->res;

