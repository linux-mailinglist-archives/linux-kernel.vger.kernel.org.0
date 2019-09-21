Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC92DB9F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfIUSPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 14:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbfIUSPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:24 -0400
Subject: Re: [GIT PULL] MTD updates for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089724;
        bh=bBHYtE7nzeS8vbO+KYHOuR4V++/A2K2IKrb0HKTD+SQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fR7TgMaJoZFtmX5b3+WjpVtYjRLLiII17jM1AmB6zc0SGbPavifvifdQHo8zg17Jx
         io4ggEExuuabRD1UQroqbar72ZbWNb0CgWET9GWdEPntwtvGOsKeZOEnGDkEjM1idk
         zUj/z9ca7JU2zAi/+zGz1qAiBM515iIrsSo6gJ5k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1742349117.3527.1569051395780.JavaMail.zimbra@nod.at>
References: <1742349117.3527.1569051395780.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1742349117.3527.1569051395780.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.4
X-PR-Tracked-Commit-Id: 2cfcfadb8e1380938d6631cffa4fa567b13f52b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4553d469d6f88028f185de57e771dd29aba10d90
Message-Id: <156908972436.32474.2390391454365007694.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 18:15:24 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Sep 2019 09:36:35 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4553d469d6f88028f185de57e771dd29aba10d90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
