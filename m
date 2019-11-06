Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0DF0BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 02:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfKFByp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 20:54:45 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:40900 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfKFByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 20:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7vvV5L0601CAUiOPYf
        8CukAk1WE0CrhJELEoxyFHq0E=; b=R7hQ6h9+LQwyQ2RaM7z1iKkKUx0eNDsSqB
        K8BSX0Fp49x34ptdaJk3c9AmIgOIylIQABUGJwIAxPF/KHwdrx2E3jDDxVmmGxpC
        ddpN2CqYayHCZYku7CNiR2ooPgwkZ+urwpOmkUtnvvyIq48gKyJgCIa0MEYU8vMa
        AHwp7MqZ0=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp2 (Coremail) with SMTP id GtxpCgBX4d7bJ8JdCcYxBA--.238S3;
        Wed, 06 Nov 2019 09:54:38 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] usb: dwc2: fix potential double free
Date:   Wed,  6 Nov 2019 09:54:33 +0800
Message-Id: <1573005273-35877-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GtxpCgBX4d7bJ8JdCcYxBA--.238S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyUCw1rWw48AF45Gw4Uurg_yoW3AFgEgF
        4YqF47ZrW3Kas8tryjvr1UtrW0k3W8Z3WSqF1vqrWS9F43KrWxZFy09rWF9a45Cw42kF9r
        AF47tF9rurn7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbeMNUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQB5lclSIdHvmrgAAsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member hsotg->desc_gen_cache is assigned NULL after it is destroyed
to avoid being freed twice when the call to usb_add_hcd() fails.

Fixes: 3b5fcc9ac2f4 ("usb: dwc2: host: use kmem cache to allocate descriptors")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/usb/dwc2/hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 81afe553aa66..3b943352b296 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5183,6 +5183,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 				"unable to create dwc2 hs isoc desc cache\n");
 
 			kmem_cache_destroy(hsotg->desc_gen_cache);
+			hsotg->desc_gen_cache = NULL;
 
 			/*
 			 * Disable descriptor dma mode since it will not be
-- 
2.7.4

