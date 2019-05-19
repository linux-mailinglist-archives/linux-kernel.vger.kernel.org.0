Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1AC228C9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 22:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfESUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 16:40:21 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35033 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfESUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 16:40:21 -0400
Received: by mail-wr1-f51.google.com with SMTP id m3so12129759wrv.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg8ed2q+lhuAK9+Mk+OYXgpMTiIhPvCyFel37fn9zCY=;
        b=JlgVrj59D+Pab/X/1I4fSB0dKZMKC6agTXDLCWkLtC2ZzGD7WhjSjiuOKOyFtd0dnM
         dvfgp06ueceAPHHb2JlGDwNr8S6zWfzsthqvnTZau54enq5fV/Xr4M90HStYygRP6h/3
         OhyZ6DsoJ8Bjll9SWID1lD06RuVeEpdVHIxh0qIEk+QK+WFLEULuSFTYzGx6KZVeHCFC
         WIP4U2FGrPJBC4UUI3/AFbMpBGeoLbH4VbCQVaCWL3DGcQHyxVMG2hg3OPx3r50PV/N5
         jcsfTW19MBDNMAeO8VJ5F26C1HV5gwD6k4DPv6BtBRaTza+wllRoqIVcKMD86mC8eNoi
         H9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg8ed2q+lhuAK9+Mk+OYXgpMTiIhPvCyFel37fn9zCY=;
        b=nXOQ7VFdcShpDBBudCrsdrUgUYwGiSE3ClC7slBOaJCuAdpiwSqvbSigaoYKzwd5rd
         GtFd2ylbIkLcjlk8Pt+VLLaoS7Refq8uRXv2sLnLX5+ctZWPr3Ejw3bYTQHwgJaXAdQh
         5OzklYodmNnL9lhyCJ7PtZ/+qr+TGoc2Ui1kY8jlh5m38q7r0Q0Kju27OR9553WfM+Qn
         285mF7m3eL03G2MMMu4uhuCTRFi45gz9kcJ+AEevJ0icDP44qL3qPIEC3/Iq3sVjHwVD
         avgJ0xvieFSx4qRoh6dvYAUZzLgjvf8G1k+xGaQP+JaBomsXUkmChI72I2K4vI4WLaXv
         jbjQ==
X-Gm-Message-State: APjAAAVySoy6RB4dI0zaTZaZfdA9mPdbVjv2yjRFAt8pUlUt304ezlzC
        sAeQzR897SrSlODYh+k7W8K8PnLeiiI=
X-Google-Smtp-Source: APXvYqza4uzMgs9BPwMCPxl1b3mfhj62LzgTH+Kd/01KnCo8mMeACSfDX+Fz/0ja55aLLwZo6yjkNQ==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr14780797wrn.198.1558298419745;
        Sun, 19 May 2019 13:40:19 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d17sm8710814wrw.18.2019.05.19.13.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 13:40:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] at24: use devm_i2c_new_dummy_device()
Date:   Sun, 19 May 2019 22:40:10 +0200
Message-Id: <20190519204012.31861-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I see Linus pulled the new helper, so here's a patch using it in at24
and also a small code tweak for better readability.

Bartosz Golaszewski (2):
  eeprom: at24: use devm_i2c_new_dummy_device()
  eeprom: at24: drop unnecessary label

 drivers/misc/eeprom/at24.c | 65 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

-- 
2.21.0

