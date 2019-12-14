Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD05311F272
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 16:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLNP2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 10:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLNP2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 10:28:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06707214AF;
        Sat, 14 Dec 2019 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576337330;
        bh=3i3TJGlWnxTn79DIaJC4lzjFScVGz3jYaZBKCKe9FIk=;
        h=Date:From:To:Cc:Subject:From;
        b=kIFbaNPOeiVez5C2G8X4UEY2h+MAyRcNQ432eHWbJJz5Mf2LLdePgwNSaZA0Aic0F
         E32rUtfQ4F+hMR7nxVnu90/siF8yvG0BwcrZqs5HRKiWUQQA1UGxWXt/DYYLEUJHmz
         SLRO3b+8TIWwmHgIhU8IB+fSaDB4fwco+RH6ieO8=
Date:   Sat, 14 Dec 2019 16:28:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.5-rc2
Message-ID: <20191214152848.GA3460394@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9455d25f4e3b3d009fa1b810862e5b06229530e4:

  Merge tag 'ntb-5.5' of git://github.com/jonmason/ntb (2019-12-07 18:38:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc2

for you to fetch changes up to 16981742717b04644a41052570fb502682a315d2:

  binder: fix incorrect calculation for num_valid (2019-12-14 09:10:47 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.5-rc2

Here are 6 small fixes for some reported char/misc driver issues:
 - fix build warnings with new 'awk' with the raid6 code
 - 4 interconnect driver bugfixes
 - binder fix for reported problem

All of these except the binder fix have been in linux-next with no
reported issues.  The binder fix is "new" but Todd says it is good as he
has tested it :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Georgi Djakov (3):
      interconnect: qcom: sdm845: Walk the list safely on node removal
      interconnect: qcom: qcs404: Walk the list safely on node removal
      interconnect: qcom: msm8974: Walk the list safely on node removal

Greg Kroah-Hartman (1):
      lib: raid6: fix awk build warnings

Krzysztof Kozlowski (1):
      interconnect: qcom: Fix Kconfig indentation

Todd Kjos (1):
      binder: fix incorrect calculation for num_valid

 drivers/android/binder.c            |  4 ++--
 drivers/interconnect/qcom/Kconfig   | 14 +++++++-------
 drivers/interconnect/qcom/msm8974.c |  8 ++++----
 drivers/interconnect/qcom/qcs404.c  |  8 ++++----
 drivers/interconnect/qcom/sdm845.c  |  4 ++--
 lib/raid6/unroll.awk                |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)
