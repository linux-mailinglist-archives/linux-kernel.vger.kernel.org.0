Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674EE28D84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 00:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfEWW4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 18:56:55 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:41632 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387762AbfEWW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:56:55 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 8C000E8BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 17:56:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TwdqhZsapdnCeTwdqhFkzX; Thu, 23 May 2019 17:56:54 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=48070 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTwdp-001XDD-O9; Thu, 23 May 2019 17:56:53 -0500
Date:   Thu, 23 May 2019 17:56:53 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] flow_offload: use struct_size() in kzalloc()
Message-ID: <20190523225653.GA24864@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTwdp-001XDD-O9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:48070
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
   int stuff;
   struct boo entry[];
};

instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/core/flow_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index 5ce7d47a960e..3d93e51b83e0 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -7,8 +7,7 @@ struct flow_rule *flow_rule_alloc(unsigned int num_actions)
 {
 	struct flow_rule *rule;
 
-	rule = kzalloc(sizeof(struct flow_rule) +
-		       sizeof(struct flow_action_entry) * num_actions,
+	rule = kzalloc(struct_size(rule, action.entries, num_actions),
 		       GFP_KERNEL);
 	if (!rule)
 		return NULL;
-- 
2.21.0

