Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8FE18BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEIObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 10:31:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfEIObv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:31:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E8A6AC7E;
        Thu,  9 May 2019 14:31:50 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 1/4] staging: vchiq_2835_arm: revert "quit using custom down_interruptible()"
Date:   Thu,  9 May 2019 16:31:33 +0200
Message-Id: <20190509143137.31254-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509143137.31254-1-nsaenzjulienne@suse.de>
References: <20190509143137.31254-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The killable version of down() is meant to be used on situations where
it should not fail at all costs, but still have the convenience of being
able to kill it if really necessary. VCHIQ doesn't fit this criteria, as
it's mainly used as an interface to V4L2 and ALSA devices.

Fixes: ff5979ad8636 ("staging: vchiq_2835_arm: quit using custom down_interruptible()")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index a9a22917ecdb..49d3b39b1059 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -514,7 +514,7 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
 		(g_cache_line_size - 1)))) {
 		char *fragments;
 
-		if (down_killable(&g_free_fragments_sema)) {
+		if (down_interruptible(&g_free_fragments_sema) != 0) {
 			cleanup_pagelistinfo(pagelistinfo);
 			return NULL;
 		}
-- 
2.21.0

