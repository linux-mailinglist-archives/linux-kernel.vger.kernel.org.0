Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386E9349F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfFDOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:18:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfFDOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fQNjrRRG0JXmnC2bc/oI9ttAVWkiwCnUOXEY32vBUqw=; b=hxTpvHzDzRk4jCcpTyHRD1soUM
        pDpjEkszOABmHjhyE0Xp9N8Kfpj3ZwcRfVqPmTqXCgAO2FY1gDO8Bpjsl7GNioH/PN+ibxxhNF9VM
        vM4eB/XzOO8qnRpW0qCwg/dd/NnPQ1a+gQzgkPmoL/IRzYBzmssI6Euwk8kOBbRop0P+PLj/Qfsu/
        6Iji+LxM484O7xq/40mk93wkoZAoJEDxQoHooXRdUaeDr1QMBS0tKeiqjKBGWpO0WdeLTZv1UjYTJ
        PH92FDF+sUzmMtJVXbNy36MaDNKRM0pbkn4F6QN8pJxNgeQBqxr414cTIiMIJEtr7IyYqHYprJ66J
        KnN1VW0w==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGM-0001Ry-Av; Tue, 04 Jun 2019 14:18:06 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGF-0002mF-1u; Tue, 04 Jun 2019 11:17:59 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 21/22] docs: isdn: remove hisax references from kernel-parameters.txt
Date:   Tue,  4 Jun 2019 11:17:55 -0300
Message-Id: <a02ca3104dd0613c104e0df86d76edcde802dd66.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hisax driver got removed on 85993b8c9786 ("isdn: remove hisax driver"),
but a left-over was kept at kernel-parameters.txt.

Fixes: 85993b8c9786 ("isdn: remove hisax driver")

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ab29adb55d18..ef03220fdf8f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1388,9 +1388,6 @@
 			Valid parameters: "on", "off"
 			Default: "on"
 
-	hisax=		[HW,ISDN]
-			See Documentation/isdn/README.HiSax.
-
 	hlt		[BUGS=ARM,SH]
 
 	hpet=		[X86-32,HPET] option to control HPET usage
-- 
2.21.0

