Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99AC195CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 18:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0RbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 13:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0RbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:31:22 -0400
Received: from C02YQ0RWLVCF.internal.digitalocean.com (c-73-181-34-237.hsd1.co.comcast.net [73.181.34.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2BD2073B;
        Fri, 27 Mar 2020 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585330282;
        bh=8qJQPj9pCV/ucE13Md57BSv0v16W7nEKjkdA+w0bXpo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZwhMBj7G3ZR7lgq1ToMbkYHWUURkvB3DIO0OmuB3z5vF/oATecgQoLzCrL2VIXmm8
         HB/6dUjyBupoa4cD+vJ0zDyl87dBg7RXT8TyCN+e+jiPYJbcNBSDEzru6KoR3g1JnD
         961o+5AXodSuVEPfoOxXbWvNjkfqM3GkuOkPIIDk=
From:   David Ahern <dsahern@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Shailabh Nagar <nagar@watson.ibm.com>
Subject: [PATCH] getdelays: Fix netlink attribute length
Date:   Fri, 27 Mar 2020 11:31:11 -0600
Message-Id: <20200327173111.63922-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to the netlink code:
  6e237d099fac ("netlink: Relax attr validation for fixed length types")
logs a warning when programs send messages with invalid attributes
(e.g., wrong length for a u32). Yafang reported this error message
for tools/accounting/getdelays.c.

send_cmd() is wrongly adding 1 to the attribute length. As noted in
include/uapi/linux/netlink.h nla_len should be NLA_HDRLEN + payload
length, so drop the +1.

Fixes: 9e06d3f9f6b1 ("per task delay accounting taskstats interface: documentation fix")
Signed-off-by: David Ahern <dsahern@kernel.org>
Tested-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
---
 tools/accounting/getdelays.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 8cb504d30384..5ef1c15e88ad 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -136,7 +136,7 @@ static int send_cmd(int sd, __u16 nlmsg_type, __u32 nlmsg_pid,
 	msg.g.version = 0x1;
 	na = (struct nlattr *) GENLMSG_DATA(&msg);
 	na->nla_type = nla_type;
-	na->nla_len = nla_len + 1 + NLA_HDRLEN;
+	na->nla_len = nla_len + NLA_HDRLEN;
 	memcpy(NLA_DATA(na), nla_data, nla_len);
 	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
 
-- 
2.17.1

