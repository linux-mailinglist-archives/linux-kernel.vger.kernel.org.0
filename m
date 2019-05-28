Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACC2C34B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfE1JbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 05:31:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfE1JbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:31:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 843716CB1DD698876870;
        Tue, 28 May 2019 17:31:13 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 17:31:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>, <lkundrak@v3.sk>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 0/2] Platform: OLPC: Fix two randbuild error
Date:   Tue, 28 May 2019 17:28:04 +0800
Message-ID: <20190528092806.20080-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two randbuild error:
1) Fix build error with CONFIG_SPI is not set
2) Fix build error with CONFIG_INPUT is set to m

YueHaibing (2):
  Platform: OLPC: Fix build error without CONFIG_SPI
  Platform: OLPC: Add INPUT dependencies

 drivers/platform/olpc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4


