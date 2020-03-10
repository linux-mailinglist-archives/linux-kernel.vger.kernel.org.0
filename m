Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB1180394
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgCJQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:32:45 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35974 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgCJQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:32:44 -0400
Received: by mail-pf1-f201.google.com with SMTP id h125so3171489pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=orSnkR0b0kEaczXYpxz6sH2e+X0g5twrn8pQx+WIZsU=;
        b=f9d7nMDELRVltXLuc+w/x0sA9qcoRpITVlGtCZMS3SIPIR4GcWsOQof7Ev82kZrUii
         yH3Z0EpkdC9MD2e2RMoP4DIxM/2rLW21qeBviJy2WyMN1ZrMJs0Bhjx49QLTzoJNBTgU
         4DMR+vHmZuhQ5UxOTBoN5opUtIVAkohIuqimV4s5pO8ct8XofVo/Jq4E51k5/JCWKCg/
         9Xdi9jFPKgNrJJHhPKJRGbDvxBibwI2RwjxjoxPElmsRuV+ytDt3a1OncyBBUIt6mv7u
         nnMwGE+x2qN37Zue0ZsnAEUNJ6aiIz2zNk6x/lDi8UuFo+udFUd6vGTP/HhRoUoJ4q9R
         XdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=orSnkR0b0kEaczXYpxz6sH2e+X0g5twrn8pQx+WIZsU=;
        b=pHk5tsybvL+JkF17AGiClKFP9QY+3a1WpSFNzDXsORt2779X3zCRao8EGP3/TrRuqq
         d/iVMblXuyd7yG+Da1g90vM2wQbhoOfhf/aakpEbmYGB9/gfN4b/5wNMkUS0Vnpp+Vgt
         b2ySOOz/3eaLyz4NZ3hbtu5MUpYAwVVjAEnrJUIIbYLZipWrAzLmm3igIxZKPOocfTUY
         uadaImGQpwz4O+NeVJ2QLKegoEqoyLAUmkBlk9pvSThjNbGkDaP8HxmR3Tmjb5v0uXTw
         dl2kyIOhLijCkwDeQHh+Aholk5EJKxdlMh6AOnM838tejJqyHUdKK+v9JbtEhqQvuFhS
         E5Ow==
X-Gm-Message-State: ANhLgQ1GqqoWw/MuiJlhuszWj/K1sLajx6ZchTuyv1R+1hTJEvHOEqAt
        tA/x2z+yrLNZWm1Kvno/TP/ieicZ3SeVlg==
X-Google-Smtp-Source: ADFU+vsk/MhKLnMEl6XXM0gmfMX/+yVoxQ1mlYcZ9OVXE+KVATINDkuf9BSlNbBWf92pBgHmMAtRTSSReTRc3A==
X-Received: by 2002:a17:90a:be0c:: with SMTP id a12mr2651608pjs.26.1583857963999;
 Tue, 10 Mar 2020 09:32:43 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:31:50 -0700
Message-Id: <20200310093101.1.Iaa45f22c4b2bb1828e88211b2d28c24d6ddd50a7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] Bluetooth: mgmt: add mgmt_cmd_status in add_advertising
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Joseph Hwang <josephsih@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

From: Joseph Hwang <josephsih@chromium.org>

If an error occurs during request building in add_advertising(),
remember to send MGMT_STATUS_FAILED command status back to bluetoothd.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/mgmt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1002c657768a0..2398f57b7dc3c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6747,8 +6747,11 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (!err)
 		err = hci_req_run(&req, add_advertising_complete);
 
-	if (err < 0)
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_FAILED);
 		mgmt_pending_remove(cmd);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.25.1.481.gfbce0eb801-goog

