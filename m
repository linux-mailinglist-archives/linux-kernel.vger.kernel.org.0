Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EEB2579
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 20:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfIMS7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 14:59:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59200 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 14:59:06 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2324B28F197;
        Fri, 13 Sep 2019 19:59:01 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/4] null_blk: match the type of parameter nr_devices
Date:   Fri, 13 Sep 2019 15:57:44 -0300
Message-Id: <20190913185746.337429-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913185746.337429-1-andrealmeid@collabora.com>
References: <20190913185746.337429-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the variable nr_devices is an unsigned int, the module_param()
should also use this type. Change the type so they can match.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index be32cb5ed339..5d20d65041bd 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -142,7 +142,7 @@ module_param_named(bs, g_bs, int, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
 static unsigned int nr_devices = 1;
-module_param(nr_devices, int, 0444);
+module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
 
 static bool g_blocking;
-- 
2.23.0

