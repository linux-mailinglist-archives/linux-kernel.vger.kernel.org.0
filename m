Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08079155CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 18:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 12:16:16 -0500
Received: from ms.lwn.net ([45.79.88.28]:49974 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgBGRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:16:16 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1B34728;
        Fri,  7 Feb 2020 17:16:15 +0000 (UTC)
Date:   Fri, 7 Feb 2020 10:16:14 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.6
Message-ID: <20200207101614.4b5d6bc0@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
77ce1a47ebca88bf1eb3018855fc1709c7a1ed86:

  docs: filesystems: add overlayfs to index.rst (2020-01-28 13:41:57 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.6-2

for you to fetch changes up to d1c9038ab5c1c96c0fd9d13ec56f2d650fe4c59f:

  Allow git builds of Sphinx (2020-02-05 10:33:44 -0700)

----------------------------------------------------------------
A handful of small documentation fixes that wandered in.

----------------------------------------------------------------
Randy Dunlap (1):
      Documentation: changes.rst: update several outdated project URLs

Sameer Rahmani (1):
      Documentation: build warnings related to missing blank lines after explicit markups has been fixed

SeongJae Park (3):
      docs/locking: Fix outdated section names
      Documentation/ko_KR/howto: Update broken web addresses
      Documentation/ko_KR/howto: Update a broken link

Stephen Kitt (1):
      Allow git builds of Sphinx

Tiezhu Yang (1):
      mailmap: add entry for Tiezhu Yang

 .mailmap                                             |  1 +
 Documentation/doc-guide/contributing.rst             |  1 +
 Documentation/doc-guide/maintainer-profile.rst       |  1 +
 Documentation/locking/spinlocks.rst                  |  4 ++--
 Documentation/process/changes.rst                    | 14 +++++++++-----
 Documentation/trace/kprobetrace.rst                  |  2 +-
 Documentation/translations/it_IT/process/changes.rst | 14 +++++++++-----
 Documentation/translations/ko_KR/howto.rst           |  6 +++---
 scripts/sphinx-pre-install                           |  2 +-
 9 files changed, 28 insertions(+), 17 deletions(-)
