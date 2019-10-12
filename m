Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62249D4F29
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 12:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfJLKvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 06:51:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728732AbfJLKvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 06:51:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FBF8AD26;
        Sat, 12 Oct 2019 10:51:33 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 5.4-rc3
Date:   Sat, 12 Oct 2019 12:51:31 +0200
Message-Id: <20191012105131.10908-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc3-tag

xen: fixes for 5.4-rc3

It contains the following patches:

- a patch to correct panic handling when running as a Xen guest

- a cleanup in the Xen grant driver to remove printing a pointer being
  always NULL

- a patch to remove a soon to be wrong call of of_dma_configure()


Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/x86/xen/enlighten.c                        | 28 ++++++++++++++++++++++---
 drivers/gpu/drm/xen/xen_drm_front.c             | 12 ++---------
 drivers/xen/gntdev.c                            | 13 ++----------
 drivers/xen/grant-table.c                       |  3 +--
 5 files changed, 34 insertions(+), 26 deletions(-)

Boris Ostrovsky (1):
      x86/xen: Return from panic notifier

Fuqian Huang (1):
      xen/grant-table: remove unnecessary printing

Rob Herring (1):
      xen: Stop abusing DT of_dma_configure API
