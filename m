Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A167D7A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfHAIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 04:31:49 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:53143 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfHAIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:31:49 -0400
Received: from localhost.localdomain ([176.167.121.156])
        by mwinf5d80 with ME
        id jkXg2000Y3NZnML03kXgAC; Thu, 01 Aug 2019 10:31:48 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2019 10:31:48 +0200
X-ME-IP: 176.167.121.156
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        allison@lohutok.net, tglx@linutronix.de, clg@kaod.org,
        groug@kaod.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] powerpc/xive: 2 small tweaks in 'xive_irq_bitmap_add()'
Date:   Thu,  1 Aug 2019 10:31:44 +0200
Message-Id: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch uses GFP_KERNEL instead of GFP_ATOMIC.
The 2nd adds a check for memory allocation failure.

Christophe JAILLET (2):
  powerpc/xive: Use GFP_KERNEL instead of GFP_ATOMIC in
    'xive_irq_bitmap_add()'
  powerpc/xive: Add a check for memory allocation failure

 arch/powerpc/sysdev/xive/spapr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.20.1

