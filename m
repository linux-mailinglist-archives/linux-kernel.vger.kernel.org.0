Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368BE45B48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfFNLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 07:16:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60946 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfFNLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:16:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DE7A328606D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH 2/3] platform/chrome: cros_ec_debugfs: Fix kernel-doc comment first line
Date:   Fri, 14 Jun 2019 13:15:50 +0200
Message-Id: <20190614111551.28686-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614111551.28686-1-enric.balletbo@collabora.com>
References: <20190614111551.28686-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc comments have a prescribed format. To be _particularly_
correct we should also capitalise the brief description and terminate
it with a period.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 970ba13df9a1..cd3fb9c22a44 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -25,7 +25,8 @@
 
 #define CIRC_ADD(idx, size, value)	(((idx) + (value)) & ((size) - 1))
 
-/* struct cros_ec_debugfs - ChromeOS EC debugging information
+/**
+ * struct cros_ec_debugfs - EC debugging information.
  *
  * @ec: EC device this debugfs information belongs to
  * @dir: dentry for debugfs files
-- 
2.20.1

