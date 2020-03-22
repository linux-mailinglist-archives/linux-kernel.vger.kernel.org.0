Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1018E5F2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 03:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgCVCTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 22:19:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34966 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgCVCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 22:19:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id v15so8735601qto.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 19:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7SHC7AQfO9TwwpN/x0z3E15F8GnLYestCEz0TtL0YM=;
        b=wuN8YhHsGNS+KBnGqTssJtfUY56E0cibB4sykRbRaY8Uzc+i5+w1tUbC+QacGhjerF
         2FKP+0tqFKpl5j6mvSpNhHrzHI2RBcE9nKKbqsXo8WPFNcaSf55ZHe0L5o66KwwNiwSk
         6vmBzdMEzCYwgRzBV91lIxRvfLKdELWAHnRdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7SHC7AQfO9TwwpN/x0z3E15F8GnLYestCEz0TtL0YM=;
        b=bvYh0d9K4LvhvI/e3r8qAYyK4NH7A5Par/r88q/kkZtymVQVZ1h7fkYF2a4LrUSaSj
         Lye+5aKfpKTBFnL8cdmQdVbb47CsnsZjzleluXdP9pN+axwXNTpsbl0wYXnBT/c11U7z
         P1mUJlfJBG7WEpLoUjO+XYU11i4m0BmHPd5Mlpq765cJZZ9FfQyRhds0EYwtRkA7mXLg
         I764QCF6AkC8StNRxL5scx8SjWZHfG1E/X29q9RwuE3/egcu8o8iAra62Rsh88FTF/eM
         QcAKazZuwG5M1xOIbWz5zA2UaV1e3wl3KoitIrRd48BWAjiqgfNlXq7nQQW3zV4sNaKg
         pfYw==
X-Gm-Message-State: ANhLgQ2dDpBUoKSu0N8QdcBUIVNtoOckALl9UF/Dbx3ghcxvCbmE1yWX
        iUF7E5SMkkZXtJF4sBa1Q7cMi3pxC24=
X-Google-Smtp-Source: ADFU+vuZl6DL/jFqnNj4u0sNih/73JNqy/GIOCoxZp/XGx+R2DvQ+abdhYVPGYbeEZYzc7Sq2kUaBg==
X-Received: by 2002:ac8:748e:: with SMTP id v14mr15603731qtq.82.1584843588059;
        Sat, 21 Mar 2020 19:19:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h138sm8150819qke.86.2020.03.21.19.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 19:19:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org Felipe Balbi" <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org Kalle Valo" <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Documentation: Clarify better about the rwsem non-owner release issue
Date:   Sat, 21 Mar 2020 22:19:38 -0400
Message-Id: <20200322021938.175736-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reword and clarify better about the rwsem non-owner release issue.

Link: https://lore.kernel.org/linux-pci/20200321212144.GA6475@google.com/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/locking/locktypes.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 6f2c0f5b041e..656dce72f11f 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -292,7 +292,7 @@ implementations to provide priority inheritance for all lock types except
 the truly spinning ones. Priority inheritance on ownerless locks is
 obviously impossible.
 
-For now the rwsem non-owner release excludes code which utilizes it from
-being used on PREEMPT_RT enabled kernels. In same cases this can be
-mitigated by disabling portions of the code, in other cases the complete
-functionality has to be disabled until a workable solution has been found.
+For now, a PREEMPT_RT kernel just disables code sections that perform a
+non-owner release of an rwsem. In some cases, parts of the code are disabled.
+In other cases, the complete functionality has to be disabled until a workable
+solution has been found.
-- 
2.25.1.696.g5e7596f4ac-goog

