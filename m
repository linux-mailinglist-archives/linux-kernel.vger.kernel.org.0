Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572D517CD48
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 10:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCGJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 04:36:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:49050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgCGJgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:36:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BDDF4AC67;
        Sat,  7 Mar 2020 09:36:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.6-rc5
Date:   Sat,  7 Mar 2020 10:36:17 +0100
Message-Id: <20200307093617.11819-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.6b-rc5-tag

xen: branch for v5.6-rc5

It contains 4 fixes and a small cleanup patch:

- 2 fixes by Dongli Zhang fixing races in the xenbus driver
- 2 fixes by me fixing issues introduced in 5.6
- a small cleanup by Gustavo Silva replacing a zero-length array with
  a flexible-array

Thanks.

Juergen

 drivers/block/xen-blkfront.c              | 80 ++++++++++++++++---------------
 drivers/xen/xen-pciback/pciback.h         |  2 +-
 drivers/xen/xenbus/xenbus_comms.c         |  4 ++
 drivers/xen/xenbus/xenbus_probe.c         | 10 ++--
 drivers/xen/xenbus/xenbus_probe_backend.c |  5 +-
 drivers/xen/xenbus/xenbus_xs.c            |  9 ++--
 include/xen/interface/io/tpmif.h          |  2 +-
 include/xen/xenbus.h                      |  3 +-
 8 files changed, 64 insertions(+), 51 deletions(-)

Dongli Zhang (2):
      xenbus: req->body should be updated before req->state
      xenbus: req->err should be updated before req->state

Gustavo A. R. Silva (1):
      xen: Replace zero-length array with flexible-array member

Juergen Gross (2):
      xen/xenbus: fix locking
      xen/blkfront: fix ring info addressing
