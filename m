Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BFB678CC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 08:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfGMGR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 02:17:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37434 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfGMGRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:17:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3577214EF7474;
        Fri, 12 Jul 2019 23:17:25 -0700 (PDT)
Date:   Fri, 12 Jul 2019 23:17:24 -0700 (PDT)
Message-Id: <20190712.231724.1616414132879925665.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Ide
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Jul 2019 23:17:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get this small cleanup.

Thanks.

The following changes since commit 54dee406374ce8adb352c48e175176247cb8db7c:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2019-05-22 08:36:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 13990cf8a180cc070f0b1266140e799db8754289:

  ide: use BIT() macro for defining bit-flags (2019-07-09 14:52:14 -0700)

----------------------------------------------------------------
Amol Surati (1):
      ide: use BIT() macro for defining bit-flags

 include/linux/ide.h | 272 +++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------
 1 file changed, 136 insertions(+), 136 deletions(-)
