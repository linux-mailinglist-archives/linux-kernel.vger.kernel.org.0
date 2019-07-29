Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62DB79146
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfG2Qmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:42:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42422 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfG2Qmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:42:45 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so91056830iob.9;
        Mon, 29 Jul 2019 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bmQBBxHIt/eza4I+J3H3QVjWn12oGbnozJKzf9V+0Ig=;
        b=eg7LsPyDXHvp4+juupUsF6DEW1xyfkm0S7KlgYBgIvTviXu5aaPxd2Ra64WBP1Hp19
         LRvBFDEvdorvIFrVkf67rS7O0YL2ARodjMsu7RpaaV0i9mP+vvBMrLBvQv23AGwBFyy7
         0LnuDifYQh8F/A3jUi6O5BiItpq3U8TZcdaovZA8U9UHoJXB1ZO0O6VpSwU/dfm5rVzH
         7LNznnMqtliI6e+NCruUP/fiLNPqEipr39KpcpUV9L3yvf6fnvNbv5nmgbvnN4+2ofol
         2xFPlOwsTjkytoJB3siD+JoT+bN9B66Wt94mOlbdxjAprgYUHvTeiG3HAFhXCCAs8/EJ
         vmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bmQBBxHIt/eza4I+J3H3QVjWn12oGbnozJKzf9V+0Ig=;
        b=YtneJs6n1b9/OQHhPwj0YiI4w83acq9W5M5QSOmqj74RhxfA1Mdw/bs4t1rOKGEK7J
         yQuhnamENKMBcZwgIXmV/5H+kuzCDsmCae39tT2pQGVvia+j5JgM1F4mpRlpOKLeTmdd
         FGxI2mIW5MsC9TszpgPiAJs6oXa+3rtlTl7KH9b+mEseAKb5WGesmOHyXHmewqvps5rS
         UczKedinLOh8qj9qxAOKThFgulUngxYr/MsB82ZSBhNt4QxjdgTydyeRmkJ5PNBMqcbo
         dq++CYTr4lhLlCe7De8J594US60Mmb8BgZ7myZPuh7jm3DAL6I6Vf1LkE1iDgEE913UN
         ljCQ==
X-Gm-Message-State: APjAAAU2VMR9Brvk3PMzBMTGP0JKCbQiK/xtEWR4/Hbu4xW62om4Iufa
        Y2Blnkdlx7BrMnSGujK6Nzo=
X-Google-Smtp-Source: APXvYqx9RAnoQcF1WuI32NPf46CQ9XRe79lNZjazF9WSw9v2zVi05F9kaIX9YjTFK/o1qyuwb1eP3g==
X-Received: by 2002:a6b:f114:: with SMTP id e20mr102069896iog.169.1564418565034;
        Mon, 29 Jul 2019 09:42:45 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id z17sm83662696iol.73.2019.07.29.09.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 09:42:44 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     josef@toxicpanda.com
Cc:     kjlu@umn.edu, smccaman@umn.edu, secalert@redhat.com,
        emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nbd_genl_status: null check for nla_nest_start
Date:   Mon, 29 Jul 2019 11:42:26 -0500
Message-Id: <20190729164226.22632-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729130912.7imtg3hfnvb4lt2y@MacBook-Pro-91.local>
References: <20190729130912.7imtg3hfnvb4lt2y@MacBook-Pro-91.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_nest_start may fail and return NULL. The check is inserted, and
errno is selected based on other call sites within the same source code.
Update: removed extra new line.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/block/nbd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9bcde2325893..2410812d1e82 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2149,6 +2149,11 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.17.1

