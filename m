Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5411F69A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 07:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfLOGGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 01:06:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:45572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfLOGGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 01:06:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3191B12D;
        Sun, 15 Dec 2019 06:06:22 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.5-rc2
Date:   Sun, 15 Dec 2019 07:06:21 +0100
Message-Id: <20191215060621.8328-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5b-rc2-tag

xen: branch for v5.5-rc2

It contains two fixes: one for a resource accounting bug in some
configurations and a fix for another patch which went into rc1.

Thanks.

Juergen

 drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
 drivers/xen/balloon.c              |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

Juergen Gross (1):
      xen/balloon: fix ballooned page accounting without hotplug enabled

Paul Durrant (1):
      xen-blkback: prevent premature module unload
