Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9712101228
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 04:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKSD1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 22:27:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbfKSD1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:27:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 713B0C8CB653863E022A;
        Tue, 19 Nov 2019 11:27:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 19 Nov 2019 11:27:05 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <davem@davemloft.net>, <sgarzare@redhat.com>,
        <kstewart@linuxfoundation.org>, <alexios.zavras@intel.com>,
        <tglx@linutronix.de>, <maowenan@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] vsock/vmci: make vmci_vsock_cb_host_called static
Date:   Tue, 19 Nov 2019 11:25:34 +0800
Message-ID: <20191119032534.52090-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using make C=2 drivers/misc/vmw_vmci/vmci_driver.o
to compile, below warning can be seen:
drivers/misc/vmw_vmci/vmci_driver.c:33:6: warning:
symbol 'vmci_vsock_cb_host_called' was not declared. Should it be static?

This patch make symbol vmci_vsock_cb_host_called static.

Fixes: b1bba80a4376 ("vsock/vmci: register vmci_transport only when VMCI guest/host are active")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/misc/vmw_vmci/vmci_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index 95fed46..cbb706d 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -30,7 +30,7 @@ static bool vmci_host_personality_initialized;
 
 static DEFINE_MUTEX(vmci_vsock_mutex); /* protects vmci_vsock_transport_cb */
 static vmci_vsock_cb vmci_vsock_transport_cb;
-bool vmci_vsock_cb_host_called;
+static bool vmci_vsock_cb_host_called;
 
 /*
  * vmci_get_context_id() - Gets the current context ID.
-- 
2.7.4

