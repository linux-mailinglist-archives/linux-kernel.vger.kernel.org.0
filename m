Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A45F0EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 07:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfKFGKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 01:10:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbfKFGKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:10:15 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA66ACib028981
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 22:10:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=iBiMo+12y6HLPZMvxe/0Ndb0dqSCd+cXriHq+6VsBx8=;
 b=Id1K7J29/MVtCajtXkD61JsiLizYsvBj7UnMnJ6WvGRiYX8CrlEQeYdekTk0ax72kLCt
 eCCZ6QX4jpI1AF2wUo1UIPrDtIP9KWkRjb7uQ3EuuYvr+RBxFIhA5gbg4aIP6nlu5M9k
 jLpwdLiMSMXfxGlSxgNDLTw9LIUsERFL4sI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w3em1txkw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 22:10:14 -0800
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 22:09:50 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E6D5262E36EB; Tue,  5 Nov 2019 22:09:48 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 0/2] fix and improvement for file THP
Date:   Tue, 5 Nov 2019 22:09:28 -0800
Message-ID: <20191106060930.2571389-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_01:2019-11-05,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxlogscore=469 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1911060064
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set includes a fix and an improvement for file THP.

1/2 fixes pagecache corruption for file THP, where !PageUptodate page gets
collapsed into huge page. 1/2 is needed for 5.4.

2/2 improve collapse of file THP by flushing dirty page in collapse_file().
2/2 can wait until 5.5.

Thanks,
Song

Song Liu (2):
  mm,thp: recheck each page before collapsing file THP
  mm/thp: flush file for !is_shmem PageDirty() case in collapse_file()

 mm/khugepaged.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

--
2.17.1
