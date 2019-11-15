Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C5FD1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 00:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKNXu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 18:50:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45035 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNXu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:50:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so5352965pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 15:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAXCSE8RsS2TWO21RWnhtm76NxZ2ySF6w57KIvYvRPM=;
        b=hlPmThvEp6FY/5F3T68W7LRi7VNRRza2Wmj6ZxGuZ3WTas30FTruoeXykKed42OFXM
         WBEKz8bQ37HaBisqa2RX8aeNQestQL5KcG8R0QYziNfuAlH6AikC/jPZKctiA9w/EadW
         vSitHBLE+JZ59n9kH6IN3PAD6MjRtgMghzx24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAXCSE8RsS2TWO21RWnhtm76NxZ2ySF6w57KIvYvRPM=;
        b=teO2IOpXvg7UqXQTTe+vJwf3RvGb08A0osIWh+VRCOcS6zsSVBa//S/2vvh7YA+C9S
         T4RIS36enW9GALOxJPhcCzJzkZ8Apg9wmeD2QzBZ3Gjf+klM6NPAvX3+YxXJrankTuXW
         tNa9+5UGKblNf0RHWSvk+oCZYmgQCvfKYPuZRCRrZwTaDKdZdBzSfB9O0ETap3vjLZ7l
         TxJkWBeRdTqXaO0T+V2TAx+pfZTkkabMrxK/pZ+z7thZGhvtgehPLccMshVE/h6GfKbR
         aeJrhUBRmAIGsqSvz/L3mKUO+euMjQZ6hpx5eta4xfbMgS0OWOWCBXC9XTW7YzzwMSts
         7M6Q==
X-Gm-Message-State: APjAAAWEc6uVhxuaG2C6/kVo16/PkgFEvt9E7FEvPcCjTh4fnxqP5834
        ikqgljAUuGr+NO1zPmcIf6bXDmuwDBuTsA==
X-Google-Smtp-Source: APXvYqz2XU1rqg7wTU351zL0+ECaY0FD7KcYDCkAhwVCSh6ng8JvVjMSMt2DZw24D6miBNHpdy4JaQ==
X-Received: by 2002:a63:8443:: with SMTP id k64mr13103025pgd.417.1573775427021;
        Thu, 14 Nov 2019 15:50:27 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v63sm7904458pfb.181.2019.11.14.15.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Nov 2019 15:50:26 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] loop: Better discard for block devices
Date:   Thu, 14 Nov 2019 15:50:06 -0800
Message-Id: <20191114235008.185111-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.

The errors look like this:
[   90.880875] print_req_error: I/O error, dev loop5, sector 0

The errors occur when trying to do a discard or write zeroes operation
on a loop device backed by a block device that does not support write zeroes.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
zeroing capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does an fallocate operation on the
backing device. After this change, backing block devices that do support
zeroing will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support zeroing will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.

Changes in v7:
- Use errno_to_blk_status() (Christoph)
- Rebase on top of Darrick's patch
- Tweak opening line of commit description (Darrick)

Changes in v6:
- Updated tags

Changes in v5:
- Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)

Changes in v4:
- Mirror blkdev's write_zeroes into loopdev's discard_sectors.

Changes in v3:
- Updated tags
- Updated commit description

Changes in v2:
- Unnested error if statement (Bart)

Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 47 ++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

-- 
2.21.0

