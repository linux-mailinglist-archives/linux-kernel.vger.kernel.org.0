Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442156EF4E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 14:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfGTMXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 08:23:45 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57214 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfGTMXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:23:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 10750D83
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 12:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7vm2i2yM4bCZ for <linux-kernel@vger.kernel.org>;
        Sat, 20 Jul 2019 07:23:42 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id D84CED86
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 07:23:42 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id e20so37467046ioe.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 05:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K+9BHnE6RbUTOFhStcy8LrNMOZBD7Jm9/NExEpRtGTs=;
        b=VsAKaUY5H8pRtOL9M2UvY9iZeZDLaYKRfFF0N8a+Ayc6PHMdqmm/9LShwhaw19OENE
         pxtbM5Fx5DUA1WzHR5dxLHVeAKGy9wKZXYgRBawbE8gT60iqJsAjGCOPSjBdSDDgFxvu
         b7Wr0bcGk88XngcmuNvn83WoG1nUCpjjQaU9cJI+MIRtg86w26V7jxttyupJtMxWd/HB
         ZNw/Rn624IVLdtvABLf7EWYHrhdx7u+JpOfG34xrmKCHBbNWQawqc/DwOrZRcYdi1DQ/
         3tvSHgoFfGyPCW6CymV+IYbxh4sDtLrW7kVl2JQZ6QC8HV0+Ih1vS9KCl1OiZvVwOR6c
         aJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K+9BHnE6RbUTOFhStcy8LrNMOZBD7Jm9/NExEpRtGTs=;
        b=gqrHAGLPIXYqSjOXeiGLfUUa5D3p3uRM6tTSm10iS1khNetiyGpcytoQtVnB5pSDyT
         pD1VGwC4GKQFYSs0FUxDCVfxsbsTPR6YlxpLGD7Yx/0kfGSjD/NerQhh9ICfPVMpXDhn
         zt3V1NXAkJIU7JYLRDFbUtS8rUA/up8R/w5r92p6ikUwXQL7QehikcrsX0Sfsbg7iEIu
         +NEk0D2b3aF4dkQ1kDXdPgoaiIyxXv5VoEE9WeU6/ND8jgaFaWZxnQk46EueiRxgKyjX
         EmcrsaUWUFNzFU93jcqgYj7lffq6d0woDxLOZFwPzrq+JKycs43XrmFXL08FxEus1KOZ
         uqTQ==
X-Gm-Message-State: APjAAAVUjYdb4IERBSPTFVbF+C9/LPjc2nj6JvXPaak64ihMKVF3NeW5
        nMSASacVhncIytfuwgUu3ehoZqt4ABARMYrOYLwe1/eM+SIEWyxClzWvQEl8WLi1TDwS74SZHiQ
        NopbTwGjXEClhoMwdGa5znbL8Q26n
X-Received: by 2002:a6b:b206:: with SMTP id b6mr58517918iof.286.1563625422515;
        Sat, 20 Jul 2019 05:23:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxIvZ8x2BA1J9vY8UGimtCbB808vFCxS2Rq0GnEylvdPLpsmWAHPUhim/AqK6Ko3OIPJUTULA==
X-Received: by 2002:a6b:b206:: with SMTP id b6mr58517902iof.286.1563625422367;
        Sat, 20 Jul 2019 05:23:42 -0700 (PDT)
Received: from BlueSky.hil-mspphdt.msp.wayport.net ([107.17.71.65])
        by smtp.gmail.com with ESMTPSA id m10sm58326660ioj.75.2019.07.20.05.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Jul 2019 05:23:41 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org (open list:NETFILTER),
        coreteam@netfilter.org (open list:NETFILTER),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        netdev@vger.kernel.org (open list:ETHERNET BRIDGE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] netfilter: ebtables: compat: fix a memory leak bug
Date:   Sat, 20 Jul 2019 07:22:45 -0500
Message-Id: <1563625366-3602-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

In compat_do_replace(), a temporary buffer is allocated through vmalloc()
to hold entries copied from the user space. The buffer address is firstly
saved to 'newinfo->entries', and later on assigned to 'entries_tmp'. Then
the entries in this temporary buffer is copied to the internal kernel
structure through compat_copy_entries(). If this copy process fails,
compat_do_replace() should be terminated. However, the allocated temporary
buffer is not freed on this path, leading to a memory leak.

To fix the bug, free the buffer before returning from compat_do_replace().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 963dfdc..fd84b48e 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2261,8 +2261,10 @@ static int compat_do_replace(struct net *net, void __user *user,
 	state.buf_kern_len = size64;
 
 	ret = compat_copy_entries(entries_tmp, tmp.entries_size, &state);
-	if (WARN_ON(ret < 0))
+	if (WARN_ON(ret < 0)) {
+		vfree(entries_tmp);
 		goto out_unlock;
+	}
 
 	vfree(entries_tmp);
 	tmp.entries_size = size64;
-- 
2.7.4

