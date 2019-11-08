Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B77F3E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 04:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfKHDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 22:47:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfKHDr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AhS0hfY7dji15vBBZYbmhQ/17T0/OWvjJ00UQHM0cCE=; b=n3lmSJF3auiKdCxzfpQK31macO
        u6bBA+7p9bzfPf4j6AgTyCkq0285EXgwL4lZi7btSnfS4ImUm0lIg4Rv94J1FGGDlblTLqkuhdBnm
        Qje+2PAPnTlSzDUAkE4YScQkU6JTlMkDpFHy/6qJQQ/e7Cs5C17zsIBNkerqpdGUnKsn9ufDoO06D
        QxWDxGBQTST9g6wq6JhtaIqYSWkDGqOw/+BfuOcpNvA86ShMcP9MK+pXUxoTIM8B1w3Dnfy06h45/
        NQ+61tx842kDnxbn+iVAa6XuQ3Ht+e/b2Y6kvtBWgIy2ESsPshpTlDVcigNmM0gxaBLsN2etdYXjX
        KKsEvAxA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSvF9-0000r4-IC; Fri, 08 Nov 2019 03:47:27 +0000
Date:   Thu, 7 Nov 2019 19:47:27 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray updates for 5.4
Message-ID: <20191108034727.GA30611@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.4

for you to fetch changes up to b7e9728f3d7fc5c5c8508d99f1675212af5cfd49:

  idr: Fix idr_alloc_u32 on 32-bit systems (2019-11-03 06:36:50 -0500)

----------------------------------------------------------------
XArray updates for 5.4

These patches all fix various bugs, some of which people have tripped
over and some of which have been caught by automatic tools.

Matthew Wilcox (Oracle) (5):
  XArray: Fix xas_next() with a single entry at 0
  idr: Fix idr_get_next_ul race with idr_remove
  radix tree: Remove radix_tree_iter_find
  idr: Fix integer overflow in idr_for_each_entry
  idr: Fix idr_alloc_u32 on 32-bit systems

----------------------------------------------------------------
Matthew Wilcox (Oracle) (5):
      XArray: Fix xas_next() with a single entry at 0
      idr: Fix idr_get_next_ul race with idr_remove
      radix tree: Remove radix_tree_iter_find
      idr: Fix integer overflow in idr_for_each_entry
      idr: Fix idr_alloc_u32 on 32-bit systems

 include/linux/idr.h        |  2 +-
 include/linux/radix-tree.h | 18 ------------------
 lib/idr.c                  | 31 +++++++++++--------------------
 lib/radix-tree.c           |  2 +-
 lib/test_xarray.c          | 24 ++++++++++++++++++++++++
 lib/xarray.c               |  4 ++++
 6 files changed, 41 insertions(+), 40 deletions(-)

