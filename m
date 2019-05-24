Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7B296E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 13:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfEXLQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 07:16:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390410AbfEXLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so5708640wrn.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0j4i2J4EeszNjwRF8F3m6xPyIjfO+MOVuVKbdSEJWUQ=;
        b=Xmgm6LOjczjlBpGlalrNHIFGzjQKW1ZDiVs4Z3Bi4Ny4nPS98lbXSEQV5oEIEkQB9o
         /PnZlkg5xOGoUsLFcyHqD2LGiAPxLTimvUSG+X2f7PanxvbaFza8PthyZ12kk23Sqo+Q
         7WGEI09BYEGj9kaloXxOey2eSYHwwSHVkB9y8NOJcV8Lb18j2aLruGJmFI/adrFOFxCp
         9BCfDAaG3+ZjDKT8MU5h3pEhAofnUAa7wrhTWBfJ+qntjq2qNvLNYuA62jNAyrRA8CuE
         xZQutS8xoBVvRl+RNSPPukmcyWnX0x0YRe9lUaOGsMJxDArA4PYg2PgQ9MBznRdr1LA/
         BeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0j4i2J4EeszNjwRF8F3m6xPyIjfO+MOVuVKbdSEJWUQ=;
        b=LLsIxQlFNZbZzfw/gznX9I/27XEGUMVuUIZDagzmpbG3HGkSDDs0+o0Bc4z+WN/p/j
         tD5D3boq12uSKYP87ccwTFh13GbZK0vNFiLpBe354mTnbhG4Y7s4lQI0OdRpgbem+nCT
         weauoVQ12Cj6jKDr7I8UPbqlnhDzzHLQjxe9RYvi7QB5AF4JAJzP9CpAtyc+X2W/0RzT
         WqiDDCehbFlYzqN7n0WZ+tp03RvCH+HVpCUfyYfeX0RhFcrfkips9TSmwR4t/AxJhjY2
         hJCQsJSPCf08O58DXguz0pm4r0pEEkqktPWK6WutP+MiakNwPq8Z6a+Mxb0XIUood/b9
         bLVw==
X-Gm-Message-State: APjAAAWO43sxJAaaVMiG0KluNMx7y/K+xJboJXQ8T5gdb520dtWaFT0S
        /c9P2CWjWnQ+gP71yzpzoYJb5Q==
X-Google-Smtp-Source: APXvYqxPoKP2/nnB8Gj9sulH129I3eofITOk6NLOsT+e3SxQswPDiyvtP35buMc9daCHnQ1f4h6QnA==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr81276wro.253.1558696594810;
        Fri, 24 May 2019 04:16:34 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 0/9] genirq/timings: Fixes and selftests
Date:   Fri, 24 May 2019 13:16:06 +0200
Message-Id: <20190524111615.4891-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides a couple of fixes, an optimization and the code
to do the selftests. 

While writing the selftests, a couple of issues were spotted with
the circular buffer handling and the routine searching for the pattern
multiple times.

In addition, a small optimization has been found while investigating the
bugs above.

In order to write the selftest, the routine needed by the core code and
the tests are wrapped into function which are always inline so the current
code is not impacted by a new function call. There is no functional
changes in this part.

Finally, the selftest uses samples to insert values in the arrays and
use them to predict the next event. These tests cover the most difficult
part of the code.

Changelog:

V2:
  - remove defaulting to 'n' as it is already the case

Daniel Lezcano (9):
  genirq/timings: Fix next event index function
  genirq/timings: Fix timings buffer inspection
  genirq/timings: Optimize the period detection speed
  genirq/timings: Use the min kernel macro
  genirq/timings: Encapsulate timings push
  genirq/timings: Encapsulate storing function
  genirq/timings: Add selftest for circular array
  genirq/timings: Add selftest for irqs circular buffer
  genirq/timings: Add selftest for next event computation

 kernel/irq/Makefile    |   3 +
 kernel/irq/internals.h |  21 +-
 kernel/irq/timings.c   | 458 +++++++++++++++++++++++++++++++++++++----
 lib/Kconfig.debug      |   8 +
 4 files changed, 445 insertions(+), 45 deletions(-)

-- 
2.17.1

