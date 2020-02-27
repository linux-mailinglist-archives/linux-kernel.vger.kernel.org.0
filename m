Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E171713B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 10:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgB0JGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 04:06:52 -0500
Received: from ms.lwn.net ([45.79.88.28]:51440 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbgB0JGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:06:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B7DC42AE;
        Thu, 27 Feb 2020 09:06:50 +0000 (UTC)
Date:   Thu, 27 Feb 2020 02:06:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.6
Message-ID: <20200227020645.212d7c7c@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.6-fixes

for you to fetch changes up to adc10f5b0a03606e30c704cff1f0283a696d0260:

  docs: Fix empty parallelism argument (2020-02-25 03:11:04 -0700)

----------------------------------------------------------------
A pair of docs-build fixes.

----------------------------------------------------------------
Kees Cook (1):
      docs: Fix empty parallelism argument

Stephen Kitt (1):
      docs: remove MPX from the x86 toc

 Documentation/sphinx/parallel-wrapper.sh | 2 +-
 Documentation/x86/index.rst              | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
