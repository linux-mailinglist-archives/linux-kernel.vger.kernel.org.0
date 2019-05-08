Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84817E42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 18:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfEHQk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 12:40:57 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46057 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfEHQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:40:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id w18so16734830ywa.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pTdoN4SflFP4fbr2SxTsp4j5gxt4IEGJ5+rLZXtfkwo=;
        b=C+Yvedgm6x5TyN5rAF0fQpyyP7vco20p/5yRzDHrxwY8DiIs8kMFlJHh64PWZTR7BQ
         Ji/Jy3CL1KMBFbHirIji8wqMjsyknJUwRdWnxzWyWCYAolL/9Dc2VZSDT6SZaDFhUJre
         capLnF2C4Z0/6DPmdLxIADMM86o22HdI1Ging=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pTdoN4SflFP4fbr2SxTsp4j5gxt4IEGJ5+rLZXtfkwo=;
        b=J3H1OgnCJhKAEKv/HO/swJSNZMJ4Pnd7i5ptCvRMn46J5Vo9Zl8dk+eAyqZfOOYYnX
         70w6pLGyrPBoWRGUAWMjWJqlXsY47Zx3v/FbYBxrUwh1kuluzKWZH/II0ED64sUK9Azh
         ahv3oguqM8m7uCGLw21uQcp2tA7ZekFbaAfL5oUV1ruE92u8B+Y6MVHVhYITcvXfLF1Y
         Sbjj95CBpI/zZP72OWpBtB1VYJeYxo08Gn7GKDsIDxRayUxxsmaGmp2uGIYufKV+Fxfp
         Y2mK2IzfTwYWyvqVL9SrKXUnlN1nMcvd5afNH6ZSDdKH0uu2DqxfIzG3v09gKZFOxtSw
         orsw==
X-Gm-Message-State: APjAAAVgQjoNeZDM71Rv1qFulOoEmZbDxSYr/Jm2Z2MJDapcvCiDopmK
        5DjMuVgDNF3UZejitRb9nB7dfQ==
X-Google-Smtp-Source: APXvYqwmGI3bpXiAHaDGzTa99Dfvb2iN7LenRuQNW3bTo1/dsMzLvmARRa06QIQ4/vyHIh5XMA+X8w==
X-Received: by 2002:a81:244e:: with SMTP id k75mr18594001ywk.44.1557333656568;
        Wed, 08 May 2019 09:40:56 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u6sm4671081ywl.71.2019.05.08.09.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:40:55 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
Date:   Wed,  8 May 2019 09:40:42 -0700
Message-Id: <20190508164044.22451-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes data hold timing issues for various sdhci-iproc
ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
in quirks.

Changes from v1:
 - Change fixes tag to Cc: stable@vger.kernel.org to specify version to backport to

Trac Hoang (2):
  mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
    problem
  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

