Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD5D89EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389899AbfJPHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:38:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2334 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729325AbfJPHi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:38:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G7cuDD021649
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=zrAPYDiSSBeYl9pi34XWmCSyjb3ARooOO/3Eeb8qCdE=;
 b=ifA8WfELQi1f7lV14dL7V9uK9tukn53dguAnaYOpHOvVihfj9dKJc3ja6aqK9ROP6sjl
 z05EF00HX23u48KesHDVn5NDzmIEl2tYTIP1LxwmtlBgRSja2bkpiVPbXaBVxv6iF4rE
 JAF6kru4D+YKUGUEPMP0ZIHN+IMTbFdHBCU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vnpry1q2g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:38:56 -0700
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 00:38:26 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AECFC62E2A2F; Wed, 16 Oct 2019 00:38:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 0/4] Fixes for THP in page cache
Date:   Wed, 16 Oct 2019 00:37:27 -0700
Message-ID: <20191016073731.4076725-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 mlxlogscore=686 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160071
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set includes a few fixes for THP in page cache. They are based on
Linus's master branch.

Thanks,
Song

Kirill A. Shutemov (3):
  proc/meminfo: fix output alignment
  mm/thp: fix node page state in split_huge_page_to_list()
  mm/thp: allow drop THP from page cache

Song Liu (1):
  uprobe: only do FOLL_SPLIT_PMD for uprobe register

 fs/proc/meminfo.c       |  4 ++--
 kernel/events/uprobes.c | 10 ++++++++--
 mm/huge_memory.c        |  9 +++++++--
 mm/truncate.c           | 12 ++++++++++++
 mm/vmscan.c             |  3 ++-
 5 files changed, 31 insertions(+), 7 deletions(-)

--
2.17.1
