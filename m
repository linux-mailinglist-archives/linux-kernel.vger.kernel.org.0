Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA957E394
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbfHATxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 15:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388761AbfHATxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:53:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE9CF30EA984;
        Thu,  1 Aug 2019 19:53:05 +0000 (UTC)
Received: from max.com (unknown [10.40.205.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDFFE60BE0;
        Thu,  1 Aug 2019 19:53:01 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [GIT PULL] Fix gfs2 cluster coherency bug
Date:   Thu,  1 Aug 2019 21:52:58 +0200
Message-Id: <20190801195259.27274-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 01 Aug 2019 19:53:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following gfs2 bug fix?

Thanks,
Andreas


The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.3-rc2.fixes

for you to fetch changes up to 706cb5492c8c459199fa0ab3b5fd2ba54ee53b0c:

  gfs2: Inode dirtying fix (2019-07-31 18:51:50 +0200)

----------------------------------------------------------------
Fix gfs2 cluster coherency bug

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Inode dirtying fix

 fs/gfs2/bmap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)
