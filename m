Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456AA14C81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfEFOkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 10:40:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:42784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbfEFOkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:40:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6371DAC0C;
        Mon,  6 May 2019 14:40:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.org, dan.carpenter@oracle.com,
        stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 0/3] staging: vchiq: use interruptible waits
Date:   Mon,  6 May 2019 16:40:27 +0200
Message-Id: <20190506144030.29056-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this series tries to address an issue that came up in Raspbian's kernel
tree [1] and upstream distros [2][3].

We adopted some changes that moved wait calls from a custom
implementation to the more standard killable family of functions. Users
complained that all the VCHIQ threads showed up in D state (which is the
expected behaviour).

The custom implementation we deleted tried to mimic the killable family
of functions, yet accepted more signals than the later; SIGKILL |
SIGINT | SIGQUIT | SIGTRAP | SIGSTOP | SIGCONT for the custom
implementation as opposed to plain old SIGKILL.

Raspbian maintainers decided roll back some of those changes and leave
the wait functions as interruptible. Hence creating some divergence
between both trees.

One could argue that not liking having the threads stuck in D state is
not really a software issue. It's more a cosmetic thing that can scare
people when they look at "uptime". On the other hand, if we are ever to
unstage this driver, we'd really need a proper justification for using
the killable family of functions. Which I think it's not really clear at
the moment.

As Raspbian's kernel has been working for a while with interruptible
waits I propose we follow through. If needed we can always go back to
killable. But at least we'll have a proper understanding on the actual
needs. In the end the driver is in staging, and the potential for errors
small.

Regards,
Nicolas

[1] https://github.com/raspberrypi/linux/issues/2881
[2] https://archlinuxarm.org/forum/viewtopic.php?f=65&t=13485
[3] https://lists.fedoraproject.org/archives/list/arm@lists.fedoraproject.org/message/GBXGJ7DOV5CQQXFPOZCXTRD6W4BEPT4Q/

--

Changes since v1:
  - Proplery format revert commits
  - Add code comment to remind of this issue
  - Add Fixes tags

Nicolas Saenz Julienne (3):
  staging: vchiq_2835_arm: revert "quit using custom
    down_interruptible()"
  staging: vchiq: revert "switch to wait_for_completion_killable"
  staging: vchiq: make wait events interruptible

 .../interface/vchiq_arm/vchiq_2835_arm.c      |  2 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 21 +++++++------
 .../interface/vchiq_arm/vchiq_core.c          | 31 ++++++++++++-------
 .../interface/vchiq_arm/vchiq_util.c          |  6 ++--
 4 files changed, 35 insertions(+), 25 deletions(-)

-- 
2.21.0

