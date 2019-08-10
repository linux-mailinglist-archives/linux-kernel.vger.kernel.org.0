Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139C888C76
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfHJRZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 13:25:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfHJRZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 13:25:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6808F3082129;
        Sat, 10 Aug 2019 17:25:43 +0000 (UTC)
Received: from max.com (unknown [10.40.205.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C8AE5D6A0;
        Sat, 10 Aug 2019 17:25:39 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [GIT PULL] Fix incorrect lseek / fiemap results
Date:   Sat, 10 Aug 2019 19:25:37 +0200
Message-Id: <20190810172537.27433-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 10 Aug 2019 17:25:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following gfs2 fix?

Thanks,
Andreas

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.3-rc3.fixes

for you to fetch changes up to a27a0c9b6a208722016c8ec5ad31ec96082b91ec:

  gfs2: gfs2_walk_metadata fix (2019-08-09 16:56:12 +0100)

----------------------------------------------------------------
Fix incorrect lseek / fiemap results

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: gfs2_walk_metadata fix

 fs/gfs2/bmap.c | 164 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 101 insertions(+), 63 deletions(-)
