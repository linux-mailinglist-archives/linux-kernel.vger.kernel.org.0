Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C80E6DC570
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408272AbfJRMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 08:52:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43015 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408105AbfJRMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so6089231ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8tXbinQHwrpjZVR5SZDxD1u91iSiuAMbDTcJXFPWb8=;
        b=ZqtTvUIddQBWXaS8eT4AyKxHQxxb4LutuCYu8Et1I6qRRkCdNpIZDsBMkkiqP5LJJ3
         T++Y9k8fNV6dq4whnCc4qJYUxpkzOBGqaKv9D+WlmA2Nnrs7pPTF+ryD2Ysn6PV0lyhL
         my8Exob7bYpSp/7oQ9MbAyg6EO3GvkCC8XS9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8tXbinQHwrpjZVR5SZDxD1u91iSiuAMbDTcJXFPWb8=;
        b=SzTM4v2EJg3Y8pOxAqWFvFJUmaQkYnZ5yf+J9E3hmAF3AA14ZyRxJaJoigOU7iLD73
         tn1ZglA90XiXHvdr5KN3Hx53W3xn5nyf0LVd21ycQuUAnRbvx325EY9eHBcP5NZxqyYV
         HP+8ZjR1nFozORLx0/0I86zoDqeEISXH/6TkswnHPPAthL4JYo5DQN+KByRouEpayVxF
         yeDt9X5V9KbAWZaZmXGaexl5OWyaaPbocMfptq4U/JKrrFdXtqxuxfPv40sz1UOd6wpo
         HiRCYx+o3T8tzn0f1cZwCn1B7YsUvjNWuR/tO5uEK5dCNKefILvsuOVXpWBsDsnLJroh
         6MZQ==
X-Gm-Message-State: APjAAAV9XLvatL0GUqJrcA9MG1Y1LUO+Vd6wH2xAlP+UNrphJfIDip7N
        yO1pFr48nlf3e+XCzNpopuo9jw==
X-Google-Smtp-Source: APXvYqyF9yPf+tbU7h7RQICAL7Ec07Pxt3Ja7hV0UEFHDzE2BYMYhcr3tkeM8h/HHzKMwhMhBwF9EQ==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr6031311lja.162.1571403159942;
        Fri, 18 Oct 2019 05:52:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/7] towards QE support on ARM
Date:   Fri, 18 Oct 2019 14:52:27 +0200
Message-Id: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been several attempts in the past few years to allow
building the QUICC engine drivers for platforms other than PPC. This
is (the beginning of) yet another attempt. I hope I can get someone to
pick up these relatively trivial patches (I _think_ they shouldn't
change functionality at all), and then I'll continue slowly working
towards removing the PPC32 dependency for CONFIG_QUICC_ENGINE.

Tested on an MPC8309-derived board.

Rasmus Villemoes (7):
  soc: fsl: qe: remove space-before-tab
  soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
  soc: fsl: qe: avoid ppc-specific io accessors
  soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
  serial: make SERIAL_QE depend on PPC32
  serial: ucc_uart.c: explicitly include asm/cpm.h
  soc/fsl/qe/qe.h: remove include of asm/cpm.h

 drivers/soc/fsl/qe/gpio.c     | 30 ++++++++--------
 drivers/soc/fsl/qe/qe.c       | 44 +++++++++++------------
 drivers/soc/fsl/qe/qe_ic.c    |  8 ++---
 drivers/soc/fsl/qe/qe_ic.h    |  2 +-
 drivers/soc/fsl/qe/qe_io.c    | 40 ++++++++++-----------
 drivers/soc/fsl/qe/qe_tdm.c   |  8 ++---
 drivers/soc/fsl/qe/ucc.c      | 12 +++----
 drivers/soc/fsl/qe/ucc_fast.c | 66 ++++++++++++++++++-----------------
 drivers/soc/fsl/qe/ucc_slow.c | 38 ++++++++++----------
 drivers/soc/fsl/qe/usb.c      |  2 +-
 drivers/tty/serial/Kconfig    |  1 +
 drivers/tty/serial/ucc_uart.c |  1 +
 include/soc/fsl/qe/qe.h       |  1 -
 13 files changed, 126 insertions(+), 127 deletions(-)

-- 
2.20.1

