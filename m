Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8763D517D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfJLSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 14:05:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37605 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfJLSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:05:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so7992834pfo.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duF6ZL+HCwryTSjDdcx8z2lA9a6wjYiYn4UO3glWalg=;
        b=pe7Upv5GfSHEXJ3lhjxOf3Fl+J1g/S58wZMBl9VhRB6wt2D79P8Rad6mBvV5OHm6eE
         iaXPrBRedzy5X6lCx+aD+JrD0P1mrRBxGODoMDXwRry1yh/7Gte1dkCAvpeVuhfMFK4g
         LR113Wq4elzpROMOqS/lWxhQr3sEoV6EzCzfImBXOl01Yoe0t9H6nuieu8b4DBZZ8dsO
         zEBDBzHmdeN02DKQo7J0j9RrkLnhAMiqpCFnyl/exqW0v89UKJBZFPcC2C3IK6Pa7bDs
         Z7j19LoEn0JwmY0ad5Rcww6hVOCaT/SlEfRkSsyDcaI7zDdnYiFrbkknDLQSGd/Wl8Vw
         K23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duF6ZL+HCwryTSjDdcx8z2lA9a6wjYiYn4UO3glWalg=;
        b=VvKyxlLZWCYAmADi5ypU4dR5jF1eHHm0Bw2eW12k8WnXfCa15jfIolgTtcDN4L1xZa
         1uOaBFQ9XupWc6wwh6XlLIZqtP4K+wQp4VSYjjoNoSmYCR7izX/nJ60dhEygfx5O8xqk
         BkCwQ1Zu66vPALx1HfW8G6n46CcVdaKnr/g+3rnRKL0oHJFLoV6hAmW1o7QELGeTJOQE
         zJ++/FF1zYVC5yb9m3HE5BsDLPjaTeG4CZa58IToTt9nGNSKT4Ayw4Un+01fm+fpUZz0
         jeH3o2RL6i5Ou2h6c1oQX1DrzhY8G750WhpnG0N4ATkJ7FtyJZ2COYM1MxjB/IC2xh14
         1EMQ==
X-Gm-Message-State: APjAAAWr5OeUZFuKerZwEk8Rop/4/74AONF6O+e2wKpvDE50AftBORuX
        oepxaORxIDlAvMWp7at9U5Q=
X-Google-Smtp-Source: APXvYqxyH2oAjlVd09KUjtf8fw9mfDuaJ59X4EJ14uuiV1wImxZE3GucWiwxaBXvXfI7x4WVNUopvw==
X-Received: by 2002:a63:541e:: with SMTP id i30mr23580760pgb.130.1570903528903;
        Sat, 12 Oct 2019 11:05:28 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p17sm12183475pfn.50.2019.10.12.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:05:28 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 0/5] Remove typedef declarations in staging: octeon
Date:   Sat, 12 Oct 2019 21:04:30 +0300
Message-Id: <cover.1570821661.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes the addition of new typedefs data types in octeon,
along with replacing the previous uses with the new declaration format.

v2 of the series removes the obsolete "_t" notation in the named types.

Wambui Karuga (5):
  staging: octeon: remove typedef declaration for cvmx_wqe
  staging: octeon: remove typedef declaration for cvmx_helper_link_info
  staging: octeon: remove typedef declaration for cvmx_fau_reg_32
  staging: octeon: remove typedef declartion for cvmx_pko_command_word0
  staging: octeon: remove typedef declaration for cvmx_fau_op_size

 drivers/staging/octeon/ethernet-mdio.c   |  6 +--
 drivers/staging/octeon/ethernet-rgmii.c  |  4 +-
 drivers/staging/octeon/ethernet-rx.c     |  6 +--
 drivers/staging/octeon/ethernet-tx.c     |  4 +-
 drivers/staging/octeon/ethernet.c        |  6 +--
 drivers/staging/octeon/octeon-ethernet.h |  2 +-
 drivers/staging/octeon/octeon-stubs.h    | 56 ++++++++++++------------
 7 files changed, 43 insertions(+), 41 deletions(-)

-- 
2.23.0

