Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A590EB36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 21:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfD2T6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 15:58:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32774 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2T6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:58:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so5685816pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+0pEvJHfgnRVL31bGXerHYLPtlqb793XRK9UCWud7Go=;
        b=jDz96PvqkXsvt2iFVhZf6RMWGPNt1zIabeQePrmGpbuy4I8jzBJxCFWlsmQ/z40mcl
         tATLM6g6AAQYBGwz6xp9LnxyVOb/35LHbsUaEPBtQeZ5spmamP4Ag68lKwvrcQMzlIYH
         CUWWa7gTifnDKg6+kwvaKU2ZsIM2LAU02xotc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+0pEvJHfgnRVL31bGXerHYLPtlqb793XRK9UCWud7Go=;
        b=LApVEOL5dF4VIWK7JVsJS9a9kInhHFxR/6LF3AqEo+qHVETrVsIkKgRD2lwdgghT7B
         JgqSIl+WuLehUB0y/xQvCkBGSwPVbslYQOR+Mv4+uiW90L3/zxehMsf59tHL8rIMgoFT
         Pr4XFRyNuxUv0I2aWaOJJh8lYkcNS26S58W31KxnyFbmYMV1GOOMfFo1AaRoR6naRLr1
         KbzxqZ4pqKEB+g+Yc+iwgOR7xTTWpvAkBisxpE7p/WMx2KuGS7LeMdsKHegni1iRceUC
         NUlZZ0v4OtHuey8o/q5DRBLkmB+xAY7drPjJRkXDxDF/XRhwntrX5d5KWh49NR1mfg+R
         6XnA==
X-Gm-Message-State: APjAAAUi95HshDlhf8BiJoWTayCsoMGpWypfn55k9XhtnmqEYY8uC9tW
        QVJ54n6VpD1gLTcX3D4W2kqgig==
X-Google-Smtp-Source: APXvYqxiIgh5n28OFLjkoA8cDfNSicOV7qyHbwvpCBktMKbOU7Gb05aDaHYrjmrYob5e3IFeNwM73g==
X-Received: by 2002:a63:f444:: with SMTP id p4mr61384597pgk.32.1556567918686;
        Mon, 29 Apr 2019 12:58:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t13sm68644501pgo.14.2019.04.29.12.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:58:37 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:58:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>,
        syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com,
        Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] seccomp fixes for v5.1-rc8
Message-ID: <20190429195836.GA30688@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp fixes for v5.1-rc8. Syzbot found a use-after-free
bug in seccomp due to flags that should not be allowed to be used together.
Tycho fixed this, I updated the self-tests, and the syzkaller PoC has been
running for several days without triggering KASan (before this fix, it
would reproduce). These patches have also been in -next for almost a week,
just to be sure.

Thanks!

-Kees

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.1-rc8

for you to fetch changes up to 7a0df7fbc14505e2e2be19ed08654a09e1ed5bf6:

  seccomp: Make NEW_LISTENER and TSYNC flags exclusive (2019-04-25 15:55:58 -0700)

----------------------------------------------------------------
seccomp use-after-free fix

- Add logic for making some seccomp flags exclusive (Tycho)
- Update selftests for exclusivity testing (Kees)

----------------------------------------------------------------
Kees Cook (1):
      selftests/seccomp: Prepare for exclusive seccomp flags

Tycho Andersen (1):
      seccomp: Make NEW_LISTENER and TSYNC flags exclusive

 kernel/seccomp.c                              | 17 ++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 34 ++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 11 deletions(-)

-- 
Kees Cook
