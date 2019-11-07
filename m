Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65CF2D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfKGLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 06:15:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:39062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388206AbfKGLPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:15:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9479BAD5F;
        Thu,  7 Nov 2019 11:15:48 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 0/2] xen/gntdev: sanitize user interface handling
Date:   Thu,  7 Nov 2019 12:15:44 +0100
Message-Id: <20191107111546.26579-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen gntdev driver's checking of the number of allowed mapped pages
is in need of some sanitizing work.

Changes in V2:
- enhanced commit message of patch 1 (Andrew Cooper)

Juergen Gross (2):
  xen/gntdev: replace global limit of mapped pages by limit per call
  xen/gntdev: switch from kcalloc() to kvcalloc()

 drivers/xen/gntdev-common.h |  2 +-
 drivers/xen/gntdev-dmabuf.c | 11 +++------
 drivers/xen/gntdev.c        | 55 +++++++++++++++++++--------------------------
 3 files changed, 27 insertions(+), 41 deletions(-)

-- 
2.16.4

