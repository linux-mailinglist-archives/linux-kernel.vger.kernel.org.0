Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC818EA88
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCVQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 12:40:05 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:51762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgCVQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:40:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3CD3D837F253;
        Sun, 22 Mar 2020 16:40:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:973:988:989:1260:1311:1314:1345:1437:1515:1534:1541:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3867:3868:4605:5007:6261:8603:10004:10848:11657:11658:11914:12043:12291:12297:12683:12895:13069:13311:13357:13894:14095:14096:14384:14394:14721:21080:21433:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tramp02_1da0cf8f3de29
X-Filterd-Recvd-Size: 1709
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Mar 2020 16:40:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-nilfs@vger.kernel.org
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] nilfs2: Logging style changes
Date:   Sun, 22 Mar 2020 09:38:09 -0700
Message-Id: <cover.1584894497.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce object size and use more common kernel logging styles.

Joe Perches (2):
  nilfs2: Convert __nilfs_msg to integrate the level and format
  nilfs2: Use a more common logging style

 fs/nilfs2/alloc.c     | 38 +++++++++----------
 fs/nilfs2/btree.c     | 42 ++++++++++-----------
 fs/nilfs2/cpfile.c    | 10 ++---
 fs/nilfs2/dat.c       | 14 +++----
 fs/nilfs2/direct.c    | 14 ++++---
 fs/nilfs2/gcinode.c   |  2 +-
 fs/nilfs2/ifile.c     |  4 +-
 fs/nilfs2/inode.c     | 29 +++++++--------
 fs/nilfs2/ioctl.c     | 37 +++++++++----------
 fs/nilfs2/mdt.c       |  2 +-
 fs/nilfs2/namei.c     |  6 +--
 fs/nilfs2/nilfs.h     | 18 ++++++---
 fs/nilfs2/page.c      | 11 +++---
 fs/nilfs2/recovery.c  | 32 +++++++---------
 fs/nilfs2/segbuf.c    |  2 +-
 fs/nilfs2/segment.c   | 38 +++++++++----------
 fs/nilfs2/sufile.c    | 29 +++++++--------
 fs/nilfs2/super.c     | 73 +++++++++++++++++++------------------
 fs/nilfs2/sysfs.c     | 29 +++++++--------
 fs/nilfs2/the_nilfs.c | 85 ++++++++++++++++++++-----------------------
 20 files changed, 254 insertions(+), 261 deletions(-)

-- 
2.24.0

