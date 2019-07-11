Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD80564DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 23:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfGJVSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 17:18:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfGJVSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:18:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 185923082E09;
        Wed, 10 Jul 2019 21:18:01 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F4AF52FC2;
        Wed, 10 Jul 2019 21:18:00 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Forney <mforney@mforney.org>
Subject: [PATCH] objtool: Use Elf_Scn typedef instead of assuming struct name
Date:   Wed, 10 Jul 2019 16:17:35 -0500
Message-Id: <d270e1be2835fc2a10acf67535ff2ebd2145bf43.1562793448.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 10 Jul 2019 21:18:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Forney <mforney@mforney.org>

The libelf implementation might use a different struct name, and the
Elf_Scn typedef is already used throughout the rest of objtool.

Signed-off-by: Michael Forney <mforney@mforney.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 1121926bdc1b..e18698262837 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -463,7 +463,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
-	struct Elf_Scn *s;
+	Elf_Scn *s;
 	Elf_Data *data;
 
 	sec = malloc(sizeof(*sec));
-- 
2.20.1

