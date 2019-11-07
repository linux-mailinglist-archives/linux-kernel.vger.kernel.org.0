Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9BF25F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 04:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbfKGDaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 22:30:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727581AbfKGDaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573097409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ysog8BJEqUBkq8d1ilBdsk1voJg26ciFZ92elSxaQhs=;
        b=PgWbF6u8KTn/195D79iIYGE24dgeLQ0cOG7q4Qqj+x5QlkOUlCHxEFqfkNPSvoKJnRtnV3
        XLss2XsUtmkEPi4yG6mXZouHDbgAIT9j/O1GvAKf5XkrHF5Zi0Jqy2yEBEmxa+95VogpMN
        EdN4AyYig840tqChdtz4CID+fwb+N0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-0D2ve2QbP6m0-ulIW5FPqw-1; Wed, 06 Nov 2019 22:30:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1161800D7B;
        Thu,  7 Nov 2019 03:30:07 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E42975D9CD;
        Thu,  7 Nov 2019 03:30:02 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2] x86/stacktrace: update kconfig help text for reliable unwinders
Date:   Wed,  6 Nov 2019 22:29:58 -0500
Message-Id: <20191107032958.14034-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 0D2ve2QbP6m0-ulIW5FPqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6415b38bae26 ("x86/stacktrace: Enable HAVE_RELIABLE_STACKTRACE
for the ORC unwinder") added the ORC unwinder as a "reliable" unwinder.
Update the help text to reflect that change: the frame pointer unwinder
is no longer the only one that can provide HAVE_RELIABLE_STACKTRACE.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---

v2: dropped hunk that added unnecessary text to UNWIND_GUESS

 arch/x86/Kconfig.debug | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index bf9cd83de777..409c00f74e60 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -316,10 +316,6 @@ config UNWINDER_FRAME_POINTER
 =09  unwinder, but the kernel text size will grow by ~3% and the kernel's
 =09  overall performance will degrade by roughly 5-10%.
=20
-=09  This option is recommended if you want to use the livepatch
-=09  consistency model, as this is currently the only way to get a
-=09  reliable stack trace (CONFIG_HAVE_RELIABLE_STACKTRACE).
-
 config UNWINDER_GUESS
 =09bool "Guess unwinder"
 =09depends on EXPERT
--=20
2.21.0

