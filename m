Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF373A26E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 00:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfFHWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 18:53:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfFHWwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:52:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D753AAF90
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:52:50 +0000 (UTC)
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 928012C171
        for <bp@suse.de>; Sat,  8 Jun 2019 21:31:13 +0000 (UTC)
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTPS id 5CA80AD00
        for <bp@suse.de>; Sat,  8 Jun 2019 21:31:12 +0000 (UTC)
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LV4gN3146124
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:31:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LV4gN3146124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029465;
        bh=RRlzNxhAlOWt95dvAlPKt2Yp3/d2vmjzwWesJbbJewY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=SbDPpzsFEp/GzdvGGpZBG5blwkTpiEBoWfZBeR+HsYjRXV2POnyz0SxmV0GmlpU3h
         7CrlZuvPkVrUSyKhHr2sdGrfX3/D/QlEi68/XzUXTjeK1k1GKKuv3H269lVkEXxS1f
         2JluglKwnbnuYfhhvXCJUjIwC0XfbTgWPw0Sazidug+sA+3V2MbAttBe61yBXds5ci
         C2MGPhUgbM9JKbmTA3v1ueckXuQJ+OTPs1z1jUhUjQkUOwIAwExQh0pMYO4YbSPq2Z
         KXR0MvlqqMrRjq2r2a6GiapGrfc7D/zlD+L7Ya1+0e7SoLdF2dUzS7wxK0ayo+oTfY
         m/Q0c/kbB8hkA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LV4NA3146121;
        Sat, 8 Jun 2019 14:31:04 -0700
Date:   Sat, 8 Jun 2019 14:31:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-09afc797f3629f722df6a90ca6eb944013133c7a@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, bp@suse.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Add copyright
Git-Commit-ID: 09afc797f3629f722df6a90ca6eb944013133c7a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  09afc797f3629f722df6a90ca6eb944013133c7a
Gitweb:     https://git.kernel.org/tip/09afc797f3629f722df6a90ca6eb944013133c7a
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 22:06:43 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:40:28 +0200

RAS/CEC: Add copyright

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/ras/cec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 0907dc6f4afe..5d545806d930 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2019 Borislav Petkov, SUSE Labs.
+ */
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
