Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92E811F98F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfLORMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 12:12:44 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41572 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfLORMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 12:12:44 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bWDq0Jq9z9vYkY
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 17:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IdPLWI0kfu7V for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 11:12:42 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bWDp68sLz9vYkW
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:12:42 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id a190so967805ywe.15
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhtlch/cxMxWFqhg5J9e0u6iluOrhN5n/YoxV6vgAHw=;
        b=RRHGLZR6ustuYdKO8l7flwqB2ODykJg3s+gUufn2+cnqJUZnf90AidnC7J4gEbgpjX
         P1FXQt/fPXkeCpSn89bNmVzDB1bJYNvDfzXXLkFOc67Cn2OYJPH42OebHzivAgyfU9NW
         dQshdiJOZ7y84P8wVoSCakfcvpFzG9AdOJW4ntI5wbe42CEF+euU6b+51Tmlh18Bum5f
         9brC8VxO0bXu2ACn2v8ONUsNSSXtm41LonLCI2RDtEWmvehExYrbOUXM0LbHIxG5nJkV
         aBNFqL15GltjxrbiRt8YVIjX0cld6OWCFUXdzn1Jr9VFXpjbSj8aVdjEyzZR+pzqPvDC
         nY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhtlch/cxMxWFqhg5J9e0u6iluOrhN5n/YoxV6vgAHw=;
        b=VvzyoeTwU/WWVWsfFyaFK6UJr7xXicusHqucZzQWhwRtT4U5LR2RmIag88f9prmqu3
         nFy6UkOuGQ/AdVUZBtsPlzrfJ/QOdaJHX3zMk+PO+/Z8KblCrBt/IIINAnvXJxl9zgWs
         jD2aEKi020dCzgtfY6hYxy5jfxH+Y45H6AC5HgmUu3adfdviF0AGAJp7osQxioVb2lII
         vQaCWOSlh0+QBwuwtxK5yCHf28nk0YFxTcJJjpOXLpZSzwpJ6eVumSGSiY5QuRrQ3YJp
         OM8dk1lLbzpP3yEr0lyePonG8rfpWi/reWJ4tIECEdaB5kw3gt1xMRjOL8k9qt2VYJRO
         BsDQ==
X-Gm-Message-State: APjAAAWaBBL+PfzuF4Onxcs/4bt7pWkCg1h9px3XvmB0s5IMlz7jyibL
        yunZVOx1i7HxBB2tl9IrmHiAUECw4Q6MJHxgf1B32Fpn82VfAKXS1pzp3/ABNWg6fqe8eZq0hLb
        C/38muEHeqpy3WObpm8XRSJcF41aP
X-Received: by 2002:a0d:d5cf:: with SMTP id x198mr16663602ywd.80.1576429962334;
        Sun, 15 Dec 2019 09:12:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYCROf8cfDp7PKzWucgQEPd95CFFWqsUgOZcKkKLNUNNvfWa15pchhEHzFjQ4HKE5bYgnJVA==
X-Received: by 2002:a0d:d5cf:: with SMTP id x198mr16663586ywd.80.1576429962091;
        Sun, 15 Dec 2019 09:12:42 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id h68sm3256433ywe.21.2019.12.15.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 09:12:41 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove BUG_ON used as assertions
Date:   Sun, 15 Dec 2019 11:12:36 -0600
Message-Id: <20191215171237.27482-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
and cannot fail. There are multiple invocations of BUG_ON on the
return value to check for failure. The patch replaces certain
invocations of BUG_ON by returning the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/btrfs/extent_io.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eb8bd0258360..e72e5a333e71 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -989,7 +989,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	node = tree_search_for_insert(tree, start, &p, &parent);
 	if (!node) {
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = insert_state(tree, prealloc, start, end,
 				   &p, &parent, &bits, changeset);
 		if (err)
@@ -1054,7 +1057,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = split_state(tree, state, prealloc, start);
 		if (err)
 			extent_io_tree_panic(tree, err);
@@ -1091,7 +1097,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			this_end = last_start - 1;
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 
 		/*
 		 * Avoid to free 'prealloc' if it can be merged with
@@ -1121,7 +1130,10 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 
 		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = split_state(tree, state, prealloc, end + 1);
 		if (err)
 			extent_io_tree_panic(tree, err);
-- 
2.20.1

