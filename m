Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD69631A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfGIHNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 03:13:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbfGIHNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:13:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D3E85B44D641D74B3B97;
        Tue,  9 Jul 2019 15:12:59 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 15:12:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rpeterso@redhat.com>, <agruenba@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] gfs2: Make gfs2_fs_parameters static
Date:   Tue, 9 Jul 2019 15:12:43 +0800
Message-ID: <20190709071243.56992-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

fs/gfs2/ops_fstype.c:1330:39: warning:
 symbol 'gfs2_fs_parameters' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index a1182eb..7ff4d6d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1327,7 +1327,7 @@ static const struct fs_parameter_enum gfs2_param_enums[] = {
 	{}
 };
 
-const struct fs_parameter_description gfs2_fs_parameters = {
+static const struct fs_parameter_description gfs2_fs_parameters = {
 	.name = "gfs2",
 	.specs = gfs2_param_specs,
 	.enums = gfs2_param_enums,
-- 
2.7.4


