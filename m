Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF999C440
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfHYOB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 10:01:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36582 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfHYOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:01:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2B21A608311C;
        Sun, 25 Aug 2019 16:01:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Nta8AqioS28R; Sun, 25 Aug 2019 16:01:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E8821608313E;
        Sun, 25 Aug 2019 16:01:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kKYVBkGZUTjW; Sun, 25 Aug 2019 16:01:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CD223608311C;
        Sun, 25 Aug 2019 16:01:55 +0200 (CEST)
Date:   Sun, 25 Aug 2019 16:01:55 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1911490926.73826.1566741715800.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 5.3-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Index: pPeSnhbRqvkS7PPySedx74XvOJTvew==
Thread-Topic: UML fixes for 5.3-rc6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.3-rc6

for you to fetch changes up to e0917f879536cbf57367429d084775d8224c986c:

  um: fix time travel mode (2019-08-23 00:39:53 +0200)

----------------------------------------------------------------
This pull request contains a single bug fix for UML:

- Fix time travel mode

----------------------------------------------------------------
Johannes Berg (1):
      um: fix time travel mode

 arch/um/include/shared/timer-internal.h | 14 ++++++++++----
 arch/um/kernel/process.c                |  2 +-
 arch/um/kernel/time.c                   | 16 +++++++++-------
 3 files changed, 20 insertions(+), 12 deletions(-)
