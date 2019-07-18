Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1C6C976
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389172AbfGRGw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 02:52:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfGRGw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CA31ACBA;
        Thu, 18 Jul 2019 06:52:26 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 0/2] xen/gntdev: sanitize user interface handling
Date:   Thu, 18 Jul 2019 08:52:20 +0200
Message-Id: <20190718065222.31310-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen gntdev driver's checking of the number of allowed mapped pages
is in need of some sanitizing work.

Juergen Gross (2):
  xen/gntdev: replace global limit of mapped pages by limit per call
  xen/gntdev: switch from kcalloc() to kvcalloc()

 drivers/xen/gntdev-common.h |  2 +-
 drivers/xen/gntdev-dmabuf.c | 11 +++-------
 drivers/xen/gntdev.c        | 52 ++++++++++++++++++---------------------------
 3 files changed, 25 insertions(+), 40 deletions(-)

-- 
2.16.4

