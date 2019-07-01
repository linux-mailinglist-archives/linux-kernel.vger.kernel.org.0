Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BAF2304A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfETJ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 05:26:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfETJ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:26:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3908ABD7;
        Mon, 20 May 2019 09:26:49 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] firmware: Add support for loading compressed files
Date:   Mon, 20 May 2019 11:26:42 +0200
Message-Id: <20190520092647.8622-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a patch set to add the support for loading compressed firmware
files.

The primary motivation is to reduce the storage size; e.g. currently
the amount of /lib/firmware on my machine counts up to 419MB, and this
can be reduced to 130MB file compression.  No bad deal.

The feature adds only fallback to the compressed file, so it should
work as it was as long as the normal firmware file is present.  The
f/w loader decompresses the content, so that there is no change needed
in the caller side.

Currently only XZ format is supported.  A caveat is that the kernel XZ
helper code supports only CRC32 (or none) integrity check type, so
you'll have to compress the files via xz -C crc32 option.

The patch set begins with a few other improvements and refactoring,
followed by the compression support.

In addition to this, dracut needs a small fix to deal with the *.xz
files.

Also, the latest patchset is found in topic/fw-decompress branch of my
sound.git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git


thanks,

Takashi

===

Takashi Iwai (5):
  firmware: Free temporary page table after vmapping
  firmware: Unify the paged buffer release helper
  firmware: Use kvmalloc for page tables
  firmware: Factor out the paged buffer handling code
  firmware: Add support for loading compressed files

 drivers/base/firmware_loader/Kconfig    |  18 +++
 drivers/base/firmware_loader/fallback.c |  63 ++--------
 drivers/base/firmware_loader/firmware.h |  16 ++-
 drivers/base/firmware_loader/main.c     | 212 +++++++++++++++++++++++++++++---
 4 files changed, 235 insertions(+), 74 deletions(-)

-- 
2.16.4

