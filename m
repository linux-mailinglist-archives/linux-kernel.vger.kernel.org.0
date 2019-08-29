Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2024A207D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfH2QPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 12:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfH2QPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:15:07 -0400
Subject: Re: [GIT PULL] mtd: Fixes for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567095307;
        bh=WTpIdLvaLoglhAbyijHyx/3yZK7koc4yT9tfo593Q34=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bGn8KcdcLHdGEsPai3B34D/fYykSI13X9qOOxFmskGYOBmWX54VKJlgd3RNruHHeq
         o8Grjvv79Fw70FHSbQpwL/Eug5c+AIHoHpgDNb5NUTJzQ/1vZUnFal6j0N6WJRptsC
         d5mN8glHj3CC/JBv4qyGQGq/lDplnP60dbDlvuB8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190829144428.3cb4d481@xps13>
References: <20190829144428.3cb4d481@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190829144428.3cb4d481@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/mtd/fixes-for-5.3-rc7
X-PR-Tracked-Commit-Id: dc9cfd2692225a2164f4f20b7deaf38ca8645de3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e73079d39f62a5a46fbc30260acb0bd890c28df
Message-Id: <156709530703.2214.13976882612421454190.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Aug 2019 16:15:07 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Aug 2019 14:44:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e73079d39f62a5a46fbc30260acb0bd890c28df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
