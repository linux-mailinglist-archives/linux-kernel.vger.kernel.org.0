Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8974C18128A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 09:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgCKICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 04:02:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgCKICP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:02:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F6B6B03B;
        Wed, 11 Mar 2020 08:02:13 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drivers/base/cpu: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:02:06 +0100
Message-Id: <20200311080207.12046-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311080207.12046-1-tiwai@suse.de>
References: <20200311080207.12046-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6265871a4af2..67aaa052c7a2 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -258,13 +258,13 @@ static ssize_t print_cpus_offline(struct device *dev,
 			buf[n++] = ',';
 
 		if (nr_cpu_ids == total_cpus-1)
-			n += snprintf(&buf[n], len - n, "%u", nr_cpu_ids);
+			n += scnprintf(&buf[n], len - n, "%u", nr_cpu_ids);
 		else
-			n += snprintf(&buf[n], len - n, "%u-%d",
+			n += scnprintf(&buf[n], len - n, "%u-%d",
 						      nr_cpu_ids, total_cpus-1);
 	}
 
-	n += snprintf(&buf[n], len - n, "\n");
+	n += scnprintf(&buf[n], len - n, "\n");
 	return n;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
-- 
2.16.4

