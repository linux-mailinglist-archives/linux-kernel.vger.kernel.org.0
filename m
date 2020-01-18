Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA51417F3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAROXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 09:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgAROXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 09:23:12 -0500
Received: from localhost (170.143.71.37.rev.sfr.net [37.71.143.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F1BE2469A;
        Sat, 18 Jan 2020 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579357390;
        bh=Px3wZd1evIa/kJo2u1vji4A4/pwco9kYqMOVkqytVas=;
        h=Date:From:To:Cc:Subject:From;
        b=XF/WsSaQruNXwKHBYybQ7D84lWBcBqBgr+Z3FNAW0EIGaMTOVgqG752hP1qhDCfMd
         pc/lDBl1Qwc0fqh1t7+zsspYe9uXsvMVPM9BaS+jBfs7OnmlHEctosyVPzifcX2jD5
         zzS15H7Pns7bhES07molCotf4ahMOHXdbBUEUflc=
Date:   Sat, 18 Jan 2020 15:23:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging and IIO driver fixes for 5.5-rc7
Message-ID: <20200118142307.GA80149@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc7

for you to fetch changes up to 9fea3a40f6b07de977a2783270c8c3bc82544d45:

  staging: comedi: ni_routes: allow partial routing information (2020-01-15 13:30:09 +0100)

----------------------------------------------------------------
Staging/IIO driver fixes for 5.5-rc7

Here are some small staging and iio driver fixes for 5.5-rc7

All of them are for some small reported issues.  Nothing major, full
details in the shortlog.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Tachici (1):
      iio: adc: ad7124: Fix DT channel configuration

Guido Günther (1):
      iio: light: vcnl4000: Fix scale for vcnl4040

Ian Abbott (2):
      staging: comedi: ni_routes: fix null dereference in ni_find_route_source()
      staging: comedi: ni_routes: allow partial routing information

Lars Möllendorf (1):
      iio: buffer: align the size of scan bytes to size of the largest element

Stephan Gerhold (1):
      iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID

Tomasz Duszynski (1):
      iio: chemical: pms7003: fix unmet triggered buffer dependency

 drivers/iio/adc/ad7124.c                     | 12 +++++-------
 drivers/iio/chemical/Kconfig                 |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  3 ++-
 drivers/iio/industrialio-buffer.c            |  6 +++++-
 drivers/iio/light/vcnl4000.c                 |  3 ++-
 drivers/staging/comedi/drivers/ni_routes.c   | 12 ++++++------
 6 files changed, 21 insertions(+), 16 deletions(-)
