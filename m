Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC40F2203
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 23:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfKFWnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 17:43:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726779AbfKFWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573080229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lS+dCPRsw8mKe+le1Zkw7/5bXkrSkYDfn4dgVdUMQG4=;
        b=goMeXVsTBG95ZZnE0BKy5sjJDMKWBKsTESPISAwg64M8m8iSMu+S81Nbll7pnK+bcf5aRO
        d2RX+cV4J+pT1dZGdPK/SPpHp0Xwu6TdZVCnjEuOJOQtVNX7Pc9VjLM8AxTA91wepMoJjl
        TEW3Q04kjGab01h7EgSjVUMyHue/3CE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45--x2kj8y5M569zTGeJgJ96g-1; Wed, 06 Nov 2019 17:43:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF84E8017DD;
        Wed,  6 Nov 2019 22:43:46 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6275860BE0;
        Wed,  6 Nov 2019 22:43:46 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/stacktrace: update kconfig help text for reliable unwinders
Date:   Wed,  6 Nov 2019 17:43:44 -0500
Message-Id: <20191106224344.8373-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -x2kj8y5M569zTGeJgJ96g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6415b38bae26 ("x86/stacktrace: Enable HAVE_RELIABLE_STACKTRACE
for the ORC unwinder") marked the ORC unwinder as a "reliable" unwinder.
Update the help text to reflect that change: the frame pointer unwinder
is no longer the only one that provides HAVE_RELIABLE_STACKTRACE.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 arch/x86/Kconfig.debug | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index bf9cd83de777..69cdf0558c13 100644
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
@@ -333,6 +329,10 @@ config UNWINDER_GUESS
 =09  useful in many cases.  Unlike the other unwinders, it has no runtime
 =09  overhead.
=20
+=09  This option is not recommended if you want to use the livepatch
+=09  consistency model, as this unwinder cannot guarantee reliable stack
+=09  traces.
+
 endchoice
=20
 config FRAME_POINTER
--=20
2.21.0

