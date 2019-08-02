Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE39B7E772
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 03:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHBBWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 21:22:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729345AbfHBBWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:22:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AB44843D26697CDE4409;
        Fri,  2 Aug 2019 09:22:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 09:21:49 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chao@kernel.org>, <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] mailmap: add entry for Jaegeuk Kim
Date:   Fri, 2 Aug 2019 09:21:35 +0800
Message-ID: <20190802012135.31419-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry to connect all Jaegeuk's email addresses.

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 477debe3d960..70d41c86e644 100644
--- a/.mailmap
+++ b/.mailmap
@@ -89,6 +89,9 @@ Henrik Kretzschmar <henne@nachtwindheim.de>
 Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
 Jacob Shin <Jacob.Shin@amd.com>
+Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
+Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
+Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
 James Bottomley <jejb@mulgrave.(none)>
 James Bottomley <jejb@titanic.il.steeleye.com>
 James E Wilson <wilson@specifix.com>
-- 
2.18.0.rc1

