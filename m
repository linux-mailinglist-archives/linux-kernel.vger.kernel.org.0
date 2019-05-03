Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCE12EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfECND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 09:03:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:03:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 909AA263ADE
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@savoirfairelinux.com>
Subject: [PATCH] uapi libc compat: fix spelling typo
Date:   Fri,  3 May 2019 09:04:01 -0400
Message-Id: <20190503130401.27294-1-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaël PORTAY <gael.portay@savoirfairelinux.com>

Replace 'm' with 'n' in "comflicting".

Signed-off-by: Gaël PORTAY <gael.portay@savoirfairelinux.com>
---
 include/uapi/linux/libc-compat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 8254c937c9f4..50ec41c4b660 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -21,7 +21,7 @@
  *      e.g. #include <linux/libc-compat.h>
  *     This include must be as early as possible.
  *
- * (b) In libc-compat.h add enough code to detect that the comflicting
+ * (b) In libc-compat.h add enough code to detect that the conflicting
  *     userspace libc header has been included first.
  *
  * (c) If the userspace libc header has been included first define a set of
-- 
2.21.0

