Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF22802B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfEWOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 10:48:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:34698 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730710AbfEWOsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:48:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EBB7EAB5;
        Thu, 23 May 2019 14:48:05 +0000 (UTC)
Date:   Thu, 23 May 2019 08:48:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Documentation fixes for 5.2
Message-ID: <20190523084805.63901c65@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.2-fixes

for you to fetch changes up to a65fd4f0def56f59822b2c49522d36319bc8da8b:

  Documentation: kdump: fix minor typo (2019-05-21 09:31:28 -0600)

----------------------------------------------------------------
A handful of fixes for a docs build problem, along with catching the
spdxcheck.py script up with the current state of affairs.

----------------------------------------------------------------
Cengiz Can (1):
      Documentation: kdump: fix minor typo

Randy Dunlap (1):
      counter: fix Documentation build error due to incorrect source file name

Sven Eckelmann (2):
      scripts/spdxcheck.py: Fix path to deprecated licenses
      scripts/spdxcheck.py: Add dual license subdirectory

 Documentation/driver-api/generic-counter.rst | 2 +-
 Documentation/kdump/kdump.txt                | 2 +-
 scripts/spdxcheck.py                         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
