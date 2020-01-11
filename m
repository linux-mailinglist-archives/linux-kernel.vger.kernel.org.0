Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5F138196
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgAKOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbgAKOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:07 -0500
Subject: Re: [GIT PULL] mtd: Fixes for v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753907;
        bh=xFLLe4it5mNDvoJLxOcP4M0geVtKDiKe48kDBedvCAo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qH1K7UWQ5MUOFWdkX4YhOqPYJrHkRIasG9LoFWJ0Ol2ieOw4mQidYQKncB+A35TXz
         0Vm29esVJTD0+mPf05Tdzavs3Uk1h0c13abH2+QvtlmpzSJy04sUVeph2IGcwNPLdZ
         yaNycruxg1SW1D6RvXhpZJcmA4ZnMgqHR/jPRIas=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110154218.0b28309f@xps13>
References: <20200110154218.0b28309f@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110154218.0b28309f@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/mtd/fixes-for-5.5-rc6
X-PR-Tracked-Commit-Id: 82de6a6fb67e16a30ec2f586b1f6976c2d7b4b62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4936ce17bf7c4a17a9223a0b7d96c49d62767762
Message-Id: <157875390743.30634.6587556550158546529.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:07 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 15:42:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4936ce17bf7c4a17a9223a0b7d96c49d62767762

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
