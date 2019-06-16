Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F49473D6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 10:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFPI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 04:58:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35403 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfFPI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:58:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so6087781wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 01:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tyLCtkeeaSbQ0/DZJIU/kBEIiONfg61xJ9wYqMhu3iQ=;
        b=IPpS4kpRX2/0HqbBNmlwYccMlW4AhFAP2yOzaxWpwV2UFXwqQ+5LxGVL8Pf62rupd1
         JqDnNG+cANiihrX0SdtOTUaVlMnf9ajW4qEgwUvNwaRnURl59zxVKwLCKXFk5l0WjTxT
         oQJNetEZo8zjdxtiZJU9BL5KOv0gLvRTPY3DsQOBCTMIhLvMvvzh/kBw6hyaoH0JFDmX
         BzGoIvtIPXO+cQfV/PBjwF/gXNBfeyJfDxDkKuFmSI2dOooPL8WUJ8Mu63RjN9in6zPN
         odjbYyxMmDzsMBomzz2UnkD2l9jDd7eg6Y30dGFoktnNkB4/LHfXlkphlwDU1XSruXMx
         yGow==
X-Gm-Message-State: APjAAAWb7oDzFumBUVNkzlUCyO+l/cwJE0u/q+XhM0JafiAJ+iK/Oubz
        6kdlPhDIkLzYRzjAaOQatgwg2ovzydM=
X-Google-Smtp-Source: APXvYqwKzUqg8BlO1Ylb95tRjzIGZjsZsFmWcv2rFYrJ9MB+V7yC0LnQN11PT1XceFWw6KKnypDx5w==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr1885273wmc.170.1560675517908;
        Sun, 16 Jun 2019 01:58:37 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j123sm16804248wmb.32.2019.06.16.01.58.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:36 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 0/5] Extend remote madvise API to KSM hints
Date:   Sun, 16 Jun 2019 10:58:30 +0200
Message-Id: <20190616085835.953-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Minchan.

This is a set of commits based on our discussion on your submission [1].

First 2 implement minor suggestions just for you to not forget to take
them into account.

uio.h inclusion was needed for me to be able to compile your series
successfully. Also please note I had to enable "Transparent Hugepage
Support" as well as "Enable idle page tracking" options, otherwise the
build failed. I guess this can be addressed by you better since the
errors are introduced with MADV_COLD introduction.

Last 2 commits are the actual KSM hints enablement. The first one
implements additional check for the case where the mmap_sem is taken for
write, and the second one just allows KSM hints to be used by the remote
interface.

I'm not Cc'ing else anyone except two mailing lists to not distract
people unnecessarily. If you are fine with this addition, please use it
for your next iteration of process_madvise(), and then you'll Cc all the
people needed.

Thanks.

[1] https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.org/

Oleksandr Natalenko (5):
  mm: rename madvise_core to madvise_common
  mm: revert madvise_inject_error line split
  mm: include uio.h to madvise.c
  mm/madvise: employ mmget_still_valid for write lock
  mm/madvise: allow KSM hints for remote API

 mm/madvise.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.22.0

