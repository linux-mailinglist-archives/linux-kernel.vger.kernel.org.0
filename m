Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9011D0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfENUkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 16:40:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfENUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:40:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so130163pgi.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIOBUSdFGWh4ytKMsx2gV6KVpDwgsT8dia1L2z+1aIo=;
        b=UBCTegOVcrmBucXSEQsRP7KuBSmMckd4rWyA909XrGIvv1lbC3YPJEF6INKW04IYP+
         873oJhup8CG7B0l0e23udaA0/RCr5bttrTvE/Etic+Ily+vVX7oA/ACsMYHGzy0jdJjs
         Yivt5wnzO11T7M/yqVqbbVEC8FDt8TQf3WYx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIOBUSdFGWh4ytKMsx2gV6KVpDwgsT8dia1L2z+1aIo=;
        b=DchAZUhsuYdNVXcDw/RkddMpi0b+5YAXiUm2oTsmfsefUxrxYUiuLslZT2C+LuidAD
         Nb6TV/o21jvee9tyoSkNCdOcAWHsUAXIhd9idBmHa3mFK6iYqHH/EHQFsHyptZN5waJj
         pqhyaGnLDNN+IMIVDjvGyfcHwTmrcE0HrtCYgxzvfXogLIgqQV8uM6ivDR94mMmMnQUr
         8qhbnL50gW3YMbF2adR4HURXX1M+pEBADXxGwRgFEu+J3QNWvsClEMsu2SPeugK/6Ntb
         FMDVQKc5vozX6nlQzq+jErC1E+qvToCqSG5SJ2X9+cSd9q12bibWPEPRnvJ4FnK6nart
         5xTg==
X-Gm-Message-State: APjAAAW58zVLSUR4GTE7ei+rFj9JXP0ulY+p3vbOWgSiZZcKn/HfDjSN
        F0jbrjWrMStpD+HZjmJiXfI8Xw==
X-Google-Smtp-Source: APXvYqxFHQdmCkF2np3gSVvG0axUZJ+fDWHo9HY/6a+LOYNDPidD1KKxau1pq9ijEN6/RT2Rx45MqQ==
X-Received: by 2002:aa7:9dc9:: with SMTP id g9mr5890932pfq.228.1557866454788;
        Tue, 14 May 2019 13:40:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p2sm2137pfi.73.2019.05.14.13.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 13:40:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2 0/3] Cleanup some unused functions in fdt.c
Date:   Tue, 14 May 2019 13:40:50 -0700
Message-Id: <20190514204053.124122-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some unused functions, marks some more as __init,
marks the FDT as __ro_after_init for some more protections, and updates
the common properties binding to be less Linux specific.

Changes from v1:
 * New patch for dt-bindings and removal of that hunk from patch 2

Stephen Boyd (3):
  dt-bindings: Remove Linuxisms from common-properties binding
  of/fdt: Remove dead code and mark functions with __init
  of/fdt: Mark initial_boot_params as __ro_after_init

Cc: Hsin-Yi Wang <hsinyi@chromium.org>

 .../devicetree/bindings/common-properties.txt | 17 ++++----
 drivers/of/fdt.c                              | 39 +++----------------
 include/linux/of_fdt.h                        | 11 ------
 3 files changed, 14 insertions(+), 53 deletions(-)


base-commit: e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
-- 
Sent by a computer through tubes

