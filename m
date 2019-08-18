Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8451F915C1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHRJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 05:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHRJKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:10:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E916A21773;
        Sun, 18 Aug 2019 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566119424;
        bh=5U7y42Pt8zr5Hk0ekJwkLhY0BnGV5MzUrNKfva94WKA=;
        h=Date:From:To:Cc:Subject:From;
        b=wsPpQyIvarvon+d6qZcTvnadPWQ/6hra6PVJZ46q9oTMwlDKAI5Kuuawa7liCXOrw
         sxos3HPvsgNi63rvN8bgyC0FH72ImuIHxCuuyiUPhoYViPJzOwKbmH7UO2gpJhSoi0
         Gy+go4CLoclnK+ojoeIOpjHJIMW6o6YtJBqVCsKo=
Date:   Sun, 18 Aug 2019 11:10:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX fixes for 5.3-rc5
Message-ID: <20190818091022.GA30528@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.3-rc5

for you to fetch changes up to 0dda5907b0fc60f72f67f479f224e02c95d06e21:

  i2c: stm32: Use the correct style for SPDX License Identifier (2019-08-05 18:06:10 +0200)

----------------------------------------------------------------
SPDX fixes for 5.3-rc5

Here are 4 small SPDX fixes for 5.3-rc5.  A few style fixes for some
SPDX comments, added an SPDX tag for one file, and fix up some GPL
boilerplate for another file.

All of these have been in linux-next for a few weeks with no reported
issues (they are comment changes only, so that's to be expected...)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Matthias Maennich (1):
      coccinelle: api/atomic_as_refcounter: add SPDX License Identifier

Nishad Kamdar (2):
      intel_th: Use the correct style for SPDX License Identifier
      i2c: stm32: Use the correct style for SPDX License Identifier

Thomas Huth (1):
      kernel/configs: Replace GPL boilerplate code with SPDX identifier

 drivers/hwtracing/intel_th/msu.h                  |  2 +-
 drivers/hwtracing/intel_th/pti.h                  |  2 +-
 drivers/i2c/busses/i2c-stm32.h                    |  2 +-
 kernel/configs.c                                  | 16 +---------------
 scripts/coccinelle/api/atomic_as_refcounter.cocci |  1 +
 5 files changed, 5 insertions(+), 18 deletions(-)
