Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57AB4524
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390950AbfIQBIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 21:08:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728842AbfIQBIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:08:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8H171Wg001985
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 21:08:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2eer5mpm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 21:08:40 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 17 Sep 2019 02:08:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Sep 2019 02:08:33 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8H18WR663176780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 01:08:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D31F1A404D;
        Tue, 17 Sep 2019 01:08:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F785A4053;
        Tue, 17 Sep 2019 01:08:32 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Sep 2019 01:08:32 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 336A7A019A;
        Tue, 17 Sep 2019 11:08:31 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm: Add a bounds check in devm_memremap_pages()
Date:   Tue, 17 Sep 2019 11:07:48 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917010752.28395-1-alastair@au1.ibm.com>
References: <20190917010752.28395-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091701-0012-0000-0000-0000034CE080
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091701-0013-0000-0000-00002187584B
Message-Id: <20190917010752.28395-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

The call to check_hotplug_memory_addressable() validates that the memory
is fully addressable.

Without this call, it is possible that we may remap pages that is
not physically addressable, resulting in bogus section numbers
being returned from __section_nr().

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 mm/memremap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 86432650f829..de2b67586401 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -175,6 +175,11 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	int error, nid, is_ram;
 	bool need_devmap_managed = true;
 
+	error = check_hotplug_memory_addressable(res->start,
+						 resource_size(res));
+	if (error)
+		return ERR_PTR(error);
+
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
-- 
2.21.0

