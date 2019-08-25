Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996609C597
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 20:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfHYSpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 14:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfHYSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:45:08 -0400
Subject: Re: [GIT PULL] UBIFS/JFFS2 fixes for 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566758707;
        bh=tG0MK9TyFVx02z6HUQkIbsbsa1b5/TczVDn0f6gTUa8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LM5JqlghKD7kKmjjDNPlKcfW0eaNQ5QFfvO0CWhMPl+zM80as8sDlbiAsDomge9cS
         C2i4RF6Awc0aJRpay5EEdGoMGcsl/9TJwZ3g2UD4wNsiwWwK/lxG1wGF3bS4SNLLap
         Fkyy6aCUkzcAKbQ+kGeyUdAAld6IhYberbVWJyWU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1811413787.73825.1566741710952.JavaMail.zimbra@nod.at>
References: <1811413787.73825.1566741710952.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1811413787.73825.1566741710952.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/for-linus-5.3-rc6
X-PR-Tracked-Commit-Id: 0af83abbd4a6e36a4b209d8c57c26143e40eeec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94a76d9b525c2dd81af2a98e26fe01f99b20727d
Message-Id: <156675870718.26029.880083478324011500.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 18:45:07 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 16:01:50 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94a76d9b525c2dd81af2a98e26fe01f99b20727d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
