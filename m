Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB1DB2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 18:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502968AbfJQQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 12:42:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502771AbfJQQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:42:53 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HGV4am003212
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=owGDN6Bsj2UyeshzZXzK7BiilPxbptNkzY6xDioUKfQ=;
 b=Riq+D40Pm+iOjGG8YhC7ggyfbrvZi2ZRmWeSLzMbzU1APzgOBEaX0BvjyvdPeizO3E55
 E2e5QB7BwMDGXIXl/lJVYL49dw00NpMQXIALwPiJfVAP3F2rvERmpZhTw4nnRPYtumNM
 Bx/kXibzJTBb+H9dDM0X616Ln4yDgpr0y10= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp5k0e290-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:52 -0700
Received: from 2401:db00:2050:5076:face:0:7:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 17 Oct 2019 09:42:52 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B620A62E1477; Thu, 17 Oct 2019 09:42:50 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 4/5] mm/thp: allow drop THP from page cache
Date:   Thu, 17 Oct 2019 09:42:21 -0700
Message-ID: <20191017164223.2762148-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017164223.2762148-1-songliubraving@fb.com>
References: <20191017164223.2762148-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=752
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910170149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Once a THP is added to the page cache, it cannot be dropped via
/proc/sys/vm/drop_caches. Fix this issue with proper handling in
invalidate_mapping_pages().

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/truncate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/truncate.c b/mm/truncate.c
index 8563339041f6..dd9ebc1da356 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -592,6 +592,16 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					unlock_page(page);
 					continue;
 				}
+
+				/* Take a pin outside pagevec */
+				get_page(page);
+
+				/*
+				 * Drop extra pins before trying to invalidate
+				 * the huge page.
+				 */
+				pagevec_remove_exceptionals(&pvec);
+				pagevec_release(&pvec);
 			}
 
 			ret = invalidate_inode_page(page);
@@ -602,6 +612,8 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 			 */
 			if (!ret)
 				deactivate_file_page(page);
+			if (PageTransHuge(page))
+				put_page(page);
 			count += ret;
 		}
 		pagevec_remove_exceptionals(&pvec);
-- 
2.17.1

