Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4501D115D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfEBIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 04:54:11 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50898 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfEBIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:54:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 68A47608F44D;
        Thu,  2 May 2019 10:54:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tCZgGT9srGJB; Thu,  2 May 2019 10:54:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E47066083114;
        Thu,  2 May 2019 10:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DSTtttNaDo7h; Thu,  2 May 2019 10:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2DB38608F44D;
        Thu,  2 May 2019 10:54:06 +0200 (CEST)
Date:   Thu, 2 May 2019 10:54:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <1906022472.41848.1556787246765.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD fixes for 5.1 final
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Index: DfL9m5ltWhnTV5AkF4L36VKfZfOrxA==
Thread-Topic: MTD fixes for 5.1 final
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.1-rc6

for you to fetch changes up to 9a8f612ca0d6a436e6471c9bed516d34a2cc626f:

  mtd: rawnand: marvell: Clean the controller state before each operation (2019-04-25 23:21:51 +0200)

----------------------------------------------------------------
This pull request contains a single fix for MTD:

- Regression fix for the marvell nand driver.

----------------------------------------------------------------
Miquel Raynal (1):
      mtd: rawnand: marvell: Clean the controller state before each operation

 drivers/mtd/nand/raw/marvell_nand.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
