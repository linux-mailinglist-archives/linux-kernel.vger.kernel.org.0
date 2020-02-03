Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0651508F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgBCPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 10:00:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52908 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBCPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:00:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so16291719wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 07:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8k+vdwDiy/I9apMvVObpyzznnzplSbwF4INXo8Gvzbg=;
        b=nO/0iFLnChABOmCMm+xrIgWBq4M1n2xdXVAS2q3NE0W+nA86o5v6zG5++vNHqbFfKO
         AkG2U/+OE8IBHMIwlvCtVJ8r3vm0cag2DU38TgESZU97kYukp8tVaGAByGDxAA75SHa5
         ODj/TjF+eR8h5ABFdWcVGmo0cAX+AXfNbQ8M3nvgTWpUSakakjPh+qubEWm4IQ/b5xiN
         7YYRvoJjgT+71HSTsPWFzdOocx/c3mK2oY/tX0fnngDwUbBwXAnQg2xTdF5/TiX1sQan
         cg8h8jCQR1cUXNHJ3pEeujAZ0HlptiO6yW9Enp2UihtNIb6J1L9fZDWK1STJCTwwr/Iu
         QzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8k+vdwDiy/I9apMvVObpyzznnzplSbwF4INXo8Gvzbg=;
        b=nb9eBZUX69wejbtkIO1Yz6siYKpklHaPz+xAWwFSMHFZ/hFuf1QPJnQXyaEPo9EHpV
         6HTNNy85jmSBE+8cEFk+M1b9TxPP10Anchmvcxpq6HHMGU5CHbxhei7wpwm09O7MGPH2
         pjWSm3N6QQsEeNZTeMYmUnRFgn3P8h9bgeS4jA8cMwljHRCa6B01Zi+zSVnUQd+0JJ2F
         wf7861eaDn5Fg9Fsa1cua+4U/axwYDw1kd5wC1ZUSOJP3qVlyqe/70GplqaM3H4VNi4T
         q41vUYr761moFTNXtL6XNriE+ERQjMj/k7Q7rkybBAb548PZaB5TEeee+FVOiOUS9JOE
         hUOg==
X-Gm-Message-State: APjAAAXddERGRBHOnWVpIkKAh3grvEoq5/Rosl2gTX/z0FZsNuKjeoLn
        QrC1V5BdK5R7vqtmpCI0ckyboQ==
X-Google-Smtp-Source: APXvYqzqKMDimEMI1+Fx1wdkqzXtI2qebL2Qe5BAMKgy9ef6P7VwrBLjGqlORskaER+Fyumjo01RgQ==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr30353863wmb.33.1580742031742;
        Mon, 03 Feb 2020 07:00:31 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n13sm23730639wmd.21.2020.02.03.07.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:00:31 -0800 (PST)
Date:   Mon, 3 Feb 2020 15:00:29 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [GIT PULL] kgdb changes v5.6-rc1
Message-ID: <20200203150029.ogdtk5ep7fd3m3hg@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.6-rc1

for you to fetch changes up to dc2c733e65848b1df8d55c83eea79fc4a868c800:

  kdb: Use for_each_console() helper (2020-01-31 17:34:54 +0000)

----------------------------------------------------------------
kgdb patches for 5.6-rc1

Everything for kgdb this time around is either simplifications or clean
ups.

In particular Douglas Anderson's modifications to the backtrace machine
in the *last* dev cycle have enabled Doug to tidy up some MIPS specific
backtrace code and stop sharing certain data structures across the
kernel.  Note that The MIPS folks were on Cc: for the MIPS patch and
reacted positively (but without an explicit Acked-by).

Doug also got rid of the implicit switching between tasks and register
sets during some but not of kdb's backtrace actions (because the
implicit switching was either confusing for users, pointless or both).

Finally there is a coverity fix and patch to replace open coded console
traversal with the proper helper function.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      kdb: Use for_each_console() helper

Colin Ian King (1):
      kdb: remove redundant assignment to pointer bp

Douglas Anderson (5):
      MIPS: kdb: Remove old workaround for backtracing on other CPUs
      kdb: kdb_current_regs should be private
      kdb: kdb_current_task shouldn't be exported
      kdb: Gid rid of implicit setting of the current task / regs
      kdb: Get rid of confusing diag msg from "rd" if current task has no regs

 arch/mips/kernel/traps.c       |  5 -----
 include/linux/kdb.h            |  2 --
 kernel/debug/kdb/kdb_bp.c      |  1 -
 kernel/debug/kdb/kdb_bt.c      |  8 +-------
 kernel/debug/kdb/kdb_io.c      |  9 +++------
 kernel/debug/kdb/kdb_main.c    | 31 ++++++++++++++-----------------
 kernel/debug/kdb/kdb_private.h |  2 +-
 7 files changed, 19 insertions(+), 39 deletions(-)
