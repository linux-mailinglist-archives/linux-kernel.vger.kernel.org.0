Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C79E708
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfH0LtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 07:49:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:9615 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfH0LtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:49:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 04:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="197296588"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2019 04:49:18 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] uuid: Add helpers for finding UUID from an array
Date:   Tue, 27 Aug 2019 14:49:18 +0300
Message-Id: <20190827114918.25090-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching function that compares every UUID in an array to a
given UUID with guid_equal().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Hi,

I don't have a user for these helpers, but since they are pretty
trivial, I figured that might as well propose them in any case.
Though, I think there was somebody proposing of doing the same thing
that these helpers do at one point, but just the hard way in the
drivers, right Andy?

thanks,
---
 include/linux/uuid.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 0c631e2a73b6..13e4d99f26dd 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -48,6 +48,16 @@ static inline bool guid_is_null(const guid_t *guid)
 	return guid_equal(guid, &guid_null);
 }
 
+static inline bool guid_match(const guid_t *guids, const guid_t *guid)
+{
+	const guid_t *id;
+
+	for (id = guids; !guid_is_null(id); id++)
+		if (guid_equal(id, guid))
+			return true;
+	return false;
+}
+
 static inline bool uuid_equal(const uuid_t *u1, const uuid_t *u2)
 {
 	return memcmp(u1, u2, sizeof(uuid_t)) == 0;
@@ -63,6 +73,16 @@ static inline bool uuid_is_null(const uuid_t *uuid)
 	return uuid_equal(uuid, &uuid_null);
 }
 
+static inline bool uuid_match(const uuid_t *uuids, const uuid_t *uuid)
+{
+	const uuid_t *id;
+
+	for (id = uuids; !uuid_is_null(id); id++)
+		if (uuid_equal(id, uuid))
+			return true;
+	return false;
+}
+
 void generate_random_uuid(unsigned char uuid[16]);
 
 extern void guid_gen(guid_t *u);
-- 
2.23.0.rc1

