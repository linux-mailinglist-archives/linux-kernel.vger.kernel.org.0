Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD91935E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCZC0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 22:26:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29069 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727560AbgCZC0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585189599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GfJ4nA8hsV5lYbIG/OIJe+XHSi1/g2DRiOwxW3jISRw=;
        b=BlRf+TsFkB/Bz+xfQKFBC+zh/vX9HUQQ0W6QFrQlQupmp5BKKOAbFPCaBxVMf8MaDsCl29
        LPT3DKT/6rpC6lZPmAPf3M26M7rAEGKCjSry8+9wMCczFGhqQeu9poKdf2aAlMTeQbTLJh
        YXXiEaQyG/IOgVKdWjwzxtTspcF46Kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-X_n7FecCOoedl6RYvBPtGQ-1; Wed, 25 Mar 2020 22:26:37 -0400
X-MC-Unique: X_n7FecCOoedl6RYvBPtGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E358800D53;
        Thu, 26 Mar 2020 02:26:36 +0000 (UTC)
Received: from llong.com (ovpn-117-53.rdu2.redhat.com [10.10.117.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2528B19C70;
        Thu, 26 Mar 2020 02:26:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] mm: Remove dummy struct bootmem_data/bootmem_data_t
Date:   Wed, 25 Mar 2020 22:26:17 -0400
Message-Id: <20200326022617.26208-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both bootmem_data and bootmem_data_t structures are no longer defined.
Remove the dummy forward declarations.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/alpha/include/asm/mmzone.h | 2 --
 include/linux/mmzone.h          | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/alpha/include/asm/mmzone.h b/arch/alpha/include/asm/mmzone.h
index 7ee144f484f1..9b521c857436 100644
--- a/arch/alpha/include/asm/mmzone.h
+++ b/arch/alpha/include/asm/mmzone.h
@@ -8,8 +8,6 @@
 
 #include <asm/smp.h>
 
-struct bootmem_data_t; /* stupid forward decl. */
-
 /*
  * Following are macros that are specific to this numa platform.
  */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f6873905a..5c388eced889 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -706,7 +706,6 @@ struct deferred_split {
  * Memory statistics and page replacement data structures are maintained on a
  * per-zone basis.
  */
-struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
 	struct zonelist node_zonelists[MAX_ZONELISTS];
-- 
2.18.1

