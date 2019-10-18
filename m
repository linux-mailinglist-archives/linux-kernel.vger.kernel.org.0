Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20B3DC844
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439545AbfJRPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:20:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38265 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbfJRPUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:20:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id q28so1756113lfa.5;
        Fri, 18 Oct 2019 08:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2FnFyACZvrRV+bqhzHnYdXs/H6lR7JPzFZntZNQnSw=;
        b=CsThKPeyQPFBB9/McwW9CQ5/2ykAGYMmB+I8YQk8EjQ1V9Ml5Ye7gi3gdfk/roWtYI
         aMXyR0NDV/1/PhTBCTtTFcIfrSUZKc9E9YHOJ/iAnq5VtLvWFHreY5wGymZvScPXSTI9
         i9gnvIN/MjYIUNWixA7ododScmLK8EEseJMRHhb3JosO9FkYPrA6GPXuSOcmYMoHQm45
         Vbfh0lM42/maCwOKDZmE3s41muLsWRv6yh04nGdj9iffz4cTMd76J0rx2NhXKLuDuZ4M
         /8vqtCMPXTlL4b89WqnF4AkXDz8Jpek0+bItfMPxACFQgoZGJp8KAPslTo8Lm3aMGFPn
         K7CA==
X-Gm-Message-State: APjAAAXkt06zRlWqy8s4Y7dSTIU2Z5nkmPk9tp8g7+utJBvMamFhXlWx
        hck8uinQuyF4BFtba7wnA3c=
X-Google-Smtp-Source: APXvYqxx22vrIkVRmaj0uy9waAgKOO6pL/ZoreUi3ajJjGn05eGS5ccmk9ol4nSCTVN2pYzhIhjuxA==
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr6201630lfm.109.1571411999790;
        Fri, 18 Oct 2019 08:19:59 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id i21sm2544449lfl.44.2019.10.18.08.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:19:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iLU30-0006YC-9e; Fri, 18 Oct 2019 17:20:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] USB: ldusb: fix ring-buffer bugs
Date:   Fri, 18 Oct 2019 17:19:53 +0200
Message-Id: <20191018151955.25135-1-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot has been reporting a slab-out-of-bounds/bad user copy in ldusb
for some time now.

This turned out to due to a bug in the read() implementation, which
would have read() access the uninitialised ring buffer and leak huge
amounts of slab data on URB completion errors (e.g. disconnect).

The first patch plugs the info leaks.

The second patch fixes a couple of issues in the custom ring-buffer
implementation, which before the first patch also could have led to
info leaks.

In an attempt to avoid copying the ring-buffer entry to a temporary
buffer while holding the spinlock, I added an smp_rmb() before
copy_to_user() which I think will suffice, but I'd appreciate if you
could help me verify that. Hence the RFC on that one.

The first commit could go to Linus meanwhile.

Johan

v2
 - fix buffer-entry length check in 1/2


Johan Hovold (2):
  USB: ldusb: fix read info leaks
  USB: ldusb: fix ring-buffer locking

 drivers/usb/misc/ldusb.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.23.0

