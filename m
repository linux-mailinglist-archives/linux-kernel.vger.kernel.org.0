Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6210DED1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfK3TNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 14:13:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41768 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3TNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:13:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id t8so14214657plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=slpAZDwZWDADlCMgH+Fw7mw8kHdwTXpWpj7pI/cHAUQ=;
        b=vOTUyQCm+gKm5+qAR06wlEvjsIex8J6pFrkYRSXyaXbbWURPgmRn8nKex4bKSYKYmg
         /vLdGKTROJvMc+R6stKoaxzk1RKIe04DJzEh+meNpKMmIqsA87iNbWolDW46dgzymWJn
         4p533gtjGYp0BS1ZUvF5sN5y0jSIV6Ck3t1sIx50QDqy86Jl+W5m6885Eo24dIJ0bkWk
         31qjefXJUs+tsdgcibzV35ZayvEOmlH/1HIbGDjU73MkLHh9xiXMsyoMwmgmBIaddZCI
         tbJ0b+Kzn+xm2ooY3EGs56Gv9CKFVxXd/+lyrRh0cTqvq4gvfqqHR5U25cgGAuo3okG8
         e6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=slpAZDwZWDADlCMgH+Fw7mw8kHdwTXpWpj7pI/cHAUQ=;
        b=jf7obZ+iErtjQDuvV82uTFUrVD6IwlIP2g4X8CIOpiYSs8fW2jt+1toNDL99UE90eF
         oXA+T61lJgVI8KU1JquovEm2gbD7nTOiRkOOzNnqhJFVU0/+1q93BEv/wEcqKZvM4P4m
         Oqem45Y3fBZ0/4tsJt2gO3DxjbQhE3LTIho8L1ytZkkvS9CVUJIEWlJeSpPvmo+9kF1A
         hKZguoOxtsGQbQIuERs9/leP9j7VoN4A01S4nHEFVM2qmUhhstN13Mv7RUkdCizGwp7G
         sMOPKFTq21WViVPCbe4V85HLEYFfyqtHaDizrlQFOQRZhcBVBHuya/05LDMqmu1AmjYc
         a48g==
X-Gm-Message-State: APjAAAUCdMpZQBFV/LJ9QiEQSYK7F7AxN7paWUArq5ssHrFIzIgHLEgS
        uemToiQ7R26Ra7wWjBcKXdYCjA==
X-Google-Smtp-Source: APXvYqx/SuxtuGn5asmfUmbqJ6ZWVISvGwOgHAfd8yZqXaGiHmw+kUvojW9ai9JY5NMQIJ9vw/FKnw==
X-Received: by 2002:a17:90a:eac1:: with SMTP id ev1mr25527117pjb.66.1575141214204;
        Sat, 30 Nov 2019 11:13:34 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x2sm27882492pge.76.2019.11.30.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 11:13:33 -0800 (PST)
Date:   Sat, 30 Nov 2019 11:13:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Clement Leger <cleger@kalray.eu>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [GIT PULL] remoteproc updates for v5.5
Message-ID: <20191130191330.GA151303@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.5

for you to fetch changes up to e3cb40d4d80516a8f4e9afaebe4d672821a2c97b:

  Revert "dt-bindings: remoteproc: stm32: add wakeup-source" (2019-11-30 10:41:03 -0800)

----------------------------------------------------------------
remoteproc updates for v5.5

This adds support for booting the modem processor on Qualcomm MSM8998
and carries some cleanup up and bug fixes to the framework and the stm32
driver.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      remoteproc: stm32: use workqueue to treat mailbox callback

Ben Dooks (Codethink) (1):
      remoteproc: fix argument 2 of rproc_mem_entry_init

Bjorn Andersson (1):
      Revert "dt-bindings: remoteproc: stm32: add wakeup-source"

Clement Leger (2):
      remoteproc: remove useless typedef
      remoteproc: Fix wrong rvring index computation

Ding Xiang (1):
      remoteproc: debug: Remove unneeded NULL check

Fabien Dessenne (3):
      dt-bindings: remoteproc: stm32: add wakeup-source
      remoteproc: stm32: wakeup the system by wdg irq
      remoteproc: stm32: fix probe error case

Jeffrey Hugo (2):
      dt-bindings: remoteproc: qcom: Add Q6v5 Modem PIL binding for MSM8998
      remoteproc: qcom_q6v5_mss: Add support for MSM8998

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   6 ++
 drivers/remoteproc/qcom_q6v5_mss.c                 |  52 +++++++++--
 drivers/remoteproc/remoteproc_core.c               |   9 +-
 drivers/remoteproc/remoteproc_debugfs.c            |   3 -
 drivers/remoteproc/stm32_rproc.c                   | 100 +++++++++++++++++++--
 5 files changed, 149 insertions(+), 21 deletions(-)
