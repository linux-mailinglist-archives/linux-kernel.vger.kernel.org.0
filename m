Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1A15159
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfEFQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 12:31:50 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:33246 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfEFQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:31:48 -0400
Received: by mail-ot1-f74.google.com with SMTP id 18so4466889otu.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BvoYtYVsULamnYvbwO19c3h5oHA1gsMsAv5tZYbLYtI=;
        b=hn4rH9KTek8R37jjBWMcf/SnTi9wO6imyjbK43Qo3YFFy0w0QB9ppRC7K8TE7v3vlN
         nPLbzWoXhcOl9RZZTW0CT+GOCLOJRZHlTgH0IFE90/0mo3gA6Benvmv0xM9qlEM2L7iM
         a5/5EdryhXK5o1zmP38+JskPbuvRNi2KBDqgGoYwdgZckW/t0t3zXYlgA28tCgQWx38p
         zeMjQt/2TKtd8YWaOZqpDqkiV1tfPRGdf11R4Vmzgti01WpJ/ug4M22kRPfo4KNLvnrQ
         G8KQ2Dx3TZLoioP3vZYIMjrpzIYzmaefwwMqniR4qNzu+AscTWd9F/aHBCgCKh66bnIf
         LcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BvoYtYVsULamnYvbwO19c3h5oHA1gsMsAv5tZYbLYtI=;
        b=QNvh96HJ0EJkuV2hiaLnxspUsNNnB2b/vPRU6jCX1aWmvqqRUEiZTMQ/FSPCOB6Osy
         cxuWF52BVL7xO4KRYR7Wg9ScqLsLTlVEZXtyqz6bpG26W2mGARRq6kQAQGEfZeB6KqPX
         nD2l9809N9cCX+H+56mhp3nx5wKBAzuESaHgnpj3vuWTwRr4I+7dTpU3ukOXXnbTnSUg
         axuxUhxZCE2Xo3iQ+GaafX52QJXy8JTPftIRFNTlOLWwF7WoYph7eaVbJ/+WhmhfiMkP
         HRa8wRz59mVpesvs399iqyKwaPc7V+g1whCxpeX7AfYNyC6lU4rB2S8uMpbWN3Zg2vp8
         KKGA==
X-Gm-Message-State: APjAAAXwhihLNOo6+f0XBmNpHknFMOv9fJwuWZxyEE2hwHqgoyQJ0PAi
        /V6WYlsD542pHO9NZl/NdvCxmt1lzNulsmuY
X-Google-Smtp-Source: APXvYqy3zk1gAf1HD3ERPdP+fu/IbJWPYjnwXEpH7KM/4Kolrw9tSDmooPMwqXT4nvIVhZWlBkow5/TqTCzeTPOv
X-Received: by 2002:a9d:6008:: with SMTP id h8mr18251374otj.55.1557160307352;
 Mon, 06 May 2019 09:31:47 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:59 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 13/17] IB, arm64: untag user pointers in ib_uverbs_(re)reg_mr()
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 062a86c04123..36e7b52577d0 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -708,6 +708,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
+	cmd.start = untagged_addr(cmd.start);
+
 	if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
 		return -EINVAL;
 
@@ -790,6 +792,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
+	cmd.start = untagged_addr(cmd.start);
+
 	if (cmd.flags & ~IB_MR_REREG_SUPPORTED || !cmd.flags)
 		return -EINVAL;
 
-- 
2.21.0.1020.gf2820cf01a-goog

