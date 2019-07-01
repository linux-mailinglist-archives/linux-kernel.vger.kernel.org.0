Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C439658
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 22:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfFGUDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 16:03:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42849 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfFGUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:03:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1692839pgd.9;
        Fri, 07 Jun 2019 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2H0Ur/sD7AC58kzRcp/q9H0oOXHyisFzvBJWy6T5K1U=;
        b=ayfjXIwybJJwfhB5BsfKrVeZjeoigG1jOpx2ZQFx+kiCrB2OVv6qz6QZkvwcygQM0+
         DENnbgDDRAq5BIMX2a4ZINdW9YSiFub/IX3DETCWSA1QnRGChpi3Obcd4bTLUL0dhilO
         NjOT8v1P2fcCCpG+y+r9IM4Xclb6yV0plXaxIaj3eTfc+uho8bYxM7/fJXooZyrtkAe2
         8cJSrCkPNR9LRf3xcKGNI4e7OG8EE7bPtNwcKUGLHgAwSHgotWrCCJ61YMZI+ESZLS5B
         6CnQGQiNGqQZfzcq8twWcjW8YDg/hyfjez9WkV85jP4mJK10OpXc0P+YNuRk73NJB4II
         3Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2H0Ur/sD7AC58kzRcp/q9H0oOXHyisFzvBJWy6T5K1U=;
        b=O1fCCR6mORdT9KTVRbZRaa/vHBR71zp8UDIV2EIG6cIdNQ7Gyfkq5O7tgpnhumVHqg
         QnesidqsVKIbevBk5A/ji9FprkLyoUQbIZqfN7YlfWIusRCnEnhnzlYpyVUULh7ENCXZ
         Y0cFfnDr5IO7RNjfg4rsibYxsI+IDY9QGtAMKdMjtypMgXxnzvleTdwRtUO3+PLhNhT0
         fjNMlPmEZCi9AyBdEWrp9tzoC9MZoUIEj7bFP36dL9k/uKYVpvIVRc0kYrDAVAEmw3Zi
         LWw1b0lyn/eEAWWt3fIUR97jcD2KGaF/f6GxwhzSSfli0/z4S2ma1b/9wkll5drunoba
         f7vg==
X-Gm-Message-State: APjAAAXQyUAFGw79YDkbFIqV3eQvg+8spc3eai5iOuBYE3FG7ZC19dlC
        EwXLAIPP8nGUCgeMuruqQj9pbBI8smA=
X-Google-Smtp-Source: APXvYqxjQShwLr/YJzQWrUJA8tgq4mvBQTLC81+hA0dJk0oXkAQuSBTmoLWinWLfICwN6Muy5TEZ0Q==
X-Received: by 2002:a17:90a:2e89:: with SMTP id r9mr7647154pjd.117.1559937780483;
        Fri, 07 Jun 2019 13:03:00 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s5sm3289405pgj.60.2019.06.07.13.02.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 13:02:59 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] crypto: caam - Add i.MX8MQ support
Date:   Fri,  7 Jun 2019 13:02:21 -0700
Message-Id: <20190607200225.21419-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

Picking up where Chris left off (I chatted with him privately
beforehead), this series adds support for i.MX8MQ to CAAM driver. Just
like [v1], this series is i.MX8MQ only.

Feedback is welcome!
Thanks,
Andrey Smirnov

Changes since [v1]

  - Series reworked to continuse using register based interface for
    queueing RNG initialization job, dropping "crypto: caam - use job
    ring for RNG instantiation instead of DECO"

  - Added a patch to share DMA mask selection code

  - Added missing Signed-off-by for authors of original NXP tree
    commits that this sereis is based on

[v1] https://patchwork.kernel.org/cover/10825625/

Andrey Smirnov (2):
  crypto: caam - move DMA mask selection into a function
  crypto: caam - always select job ring via RSR on i.MX8MQ

Chris Spencer (2):
  crypto: caam - do not initialise clocks on the i.MX8
  crypto: caam - correct DMA address size for the i.MX8

 drivers/crypto/caam/ctrl.c        | 164 +++++++++++++++++-------------
 drivers/crypto/caam/desc_constr.h |  24 ++---
 drivers/crypto/caam/intern.h      |  24 ++++-
 drivers/crypto/caam/jr.c          |  15 +--
 drivers/crypto/caam/pdb.h         |  49 ++++-----
 drivers/crypto/caam/regs.h        |  21 +++-
 6 files changed, 170 insertions(+), 127 deletions(-)

-- 
2.21.0

