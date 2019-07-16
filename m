Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3D6B0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 22:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfGPUuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 16:50:39 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:38854 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728575AbfGPUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:50:39 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBB4AC1BCE;
        Tue, 16 Jul 2019 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563310239; bh=Xd83pvvL6NxmddJj03K0woFOzaR2CHGlGI+s16rvEvE=;
        h=From:To:Cc:Subject:Date:From;
        b=k0PnxTcQErzLC7klEjemFCHSyDoskZUR7M5STFOQ0B/JvpsAw4QrHUX6HqGP8dsQz
         cQhD0cQii+FiO0GM1CCRDuAhHiAiGyy8VrNHf2sBM/kuwb/rXseY1uUzyBvJOxu4Sh
         23HE5qHx/nGzHzfG9729cTyZUQ5ekwzvTmvH8VUypkKi6UrLLvH8YT0XRotdYSnKnQ
         08tOmdTN5OGQp/AKojnFs8rEov0/ghikyKKMRuZ0mTku4ZtNS/lwf4V1u6nbn9MVda
         97XBJsvOGND5/WgPCw2kWK/85vDmAgxh84crHlxzCiHg0RcLZulicny849Y/gnTVbU
         bQfH1nT5QLohA==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 49766A0057;
        Tue, 16 Jul 2019 20:50:37 +0000 (UTC)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARCv2: Don't pretend we may set U & DE bits in STATUS32 with kflag
Date:   Tue, 16 Jul 2019 23:50:34 +0300
Message-Id: <20190716205034.42466-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per PRM "kflag" instruction doesn't change state of
DE-flag ("Delayed branch is pending") and U-flag ("User mode")
in STATUS32 register so let's not act as if we can affect those bits.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/include/asm/entry-arcv2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 225e7df2d8ed..6558e2edb583 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -237,7 +237,7 @@
 
 .macro FAKE_RET_FROM_EXCPN
 	lr      r9, [status32]
-	bic     r9, r9, (STATUS_U_MASK|STATUS_DE_MASK|STATUS_AE_MASK)
+	bic     r9, r9, STATUS_AE_MASK
 	or      r9, r9, STATUS_IE_MASK
 	kflag   r9
 .endm
-- 
2.16.2

