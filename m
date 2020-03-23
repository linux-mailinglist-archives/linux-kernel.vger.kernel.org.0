Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDAE18F340
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 11:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgCWK7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 06:59:49 -0400
Received: from mout01.posteo.de ([185.67.36.65]:56926 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgCWK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:59:49 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D6E60160066
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1584961186; bh=XDHP1uEKV3Zyvo+tMi/ZAw+skOWJHrU9lwfxt887eQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=aWJuVcThLqSOOjf4ei0ql3Dwk7fQXdkQRUwVOFv3zuaKmDwBLzXJgQUbzqGgzFfc4
         dr+euvKiy/94Ugkf3j05YYitjQL0tKrRukv9oaf9OtoFdUzlSbndR2gfLAFk+FpW7C
         mtMI+P6TbUB4ehCmRcANBORIUeLaXXVdAUj9VGYckAylPTCNvJ28K8Ib4hBhxpq7ww
         cz0NTjzQ6Od9sG7YmFZt5FmBPCkIKVHJIFDl2qOckwrk3APRcEsfv3qaJTvoqiMK7I
         u+fFl4L8UyVPu7jq6GFkPO1bbl6QSLPmObTEoYSsGr6jS48dLKfKQ0JZnFC4N/aop2
         T1h3uSDDrTsdQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48mBGp23wDz6tmD;
        Mon, 23 Mar 2020 11:59:46 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/cpu: Fix a -Wmissing-prototypes warning
Date:   Mon, 23 Mar 2020 11:59:34 +0100
Message-Id: <20200323105934.26597-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing include in order to fix -Wmissing-prototypes warning:

arch/x86/kernel/cpu/feat_ctl.c:95:6: warning: no previous prototype for ‘init_ia32_feat_ctl’ [-Wmissing-prototypes]
   95 | void init_ia32_feat_ctl(struct cpuinfo_x86 *c)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/kernel/cpu/feat_ctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 0268185bef94..29a3bedabd06 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -5,6 +5,7 @@
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 #include <asm/vmx.h>
+#include "cpu.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"x86/cpu: " fmt
-- 
2.17.1

