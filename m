Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9B130381
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgADQYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 11:24:25 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:43152 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgADQYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:24:23 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qnCm5QvSzqH;
        Sat,  4 Jan 2020 17:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578155060; bh=SJg9+JjaSMHNa+k1IX8sg3nhFNF9mHiHz291qBzLAzk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=msCqm+84765w7SpzJsxnOwOi7tPzAgsIQPFtxj72jU1VlDaI3CyKtkWcp9BAtbLzv
         RwKbR6/C5LOnNohSvLnSAHVOIzS0xrCfpRbxJMq1zfbuVk1xfENTdZjinXffSeWN1g
         J81kpUCX2gF8so+57y7RgnFhEc+aXSzf/UbABr5osi+RcTh6nEwSHrNdGnSc3Sdhok
         TwFlrUEVl88b93HErq53okY6V65oeeLBKRs1LUvx1RiGpOlSOVPLmU3Nz532YFrF8H
         t3L+WTfhs0N2yVglbv3tOephyJ+vX9LO0qn7SrMu/Gmdh8UPiiIFoZDt4b6GbIHG0k
         wQv3ym7N20Q/g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 17:24:20 +0100
Message-Id: <2b13cbb612add74856aa88a71375db3718d4aae6.1578154967.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <6e542430795eeddb718db88cb08224d2e1bc6b4b.1578154967.git.mirq-linux@rere.qmqm.pl>
References: <6e542430795eeddb718db88cb08224d2e1bc6b4b.1578154967.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] block: allow empty cmdline partition set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make no-partitions setting valid. This makes it possible to prevent
kernel from trying to read partition table from a device.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 Documentation/block/cmdline-partition.rst | 2 +-
 block/cmdline-parser.c                    | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/block/cmdline-partition.rst b/Documentation/block/cmdline-partition.rst
index 530bedff548a..a5ccacee982f 100644
--- a/Documentation/block/cmdline-partition.rst
+++ b/Documentation/block/cmdline-partition.rst
@@ -13,7 +13,7 @@ Users can easily change the partition.
 The format for the command line is just like mtdparts:
 
 blkdevparts=<blkdev-def>[;<blkdev-def>]
-  <blkdev-def> := <blkdev-id>:<partdef>[,<partdef>]
+  <blkdev-def> := <blkdev-id>:[<partdef>[,<partdef>]]
     <partdef> := <size>[@<offset>](part-name)
 
 <blkdev-id>
diff --git a/block/cmdline-parser.c b/block/cmdline-parser.c
index f2a14571882b..bc63e46e7bfc 100644
--- a/block/cmdline-parser.c
+++ b/block/cmdline-parser.c
@@ -133,11 +133,9 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 		next_subpart = &(*next_subpart)->next_subpart;
 	}
 
-	if (!newparts->subpart) {
-		pr_warn("cmdline partition has no valid partition.");
-		ret = -EINVAL;
-		goto fail;
-	}
+	if (!newparts->subpart)
+		pr_warn("%s: cmdline partition has no valid partitions.",
+			newparts->name);
 
 	*parts = newparts;
 
-- 
2.20.1

