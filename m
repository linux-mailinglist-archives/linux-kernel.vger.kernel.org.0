Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A1563A91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGISGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfGISFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:08 -0400
Subject: Re: [GIT PULL] i3c: Changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695507;
        bh=YOQIGj8196mFVtXj3Kiaq7v6ACBv31XOD/iowZB9rFA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hbhZHPWH8b6XB6rgc3Dt2FAhPd4rgcaAW3vctZp2m/NpkF5j2NrHywmmcukeJIidy
         IDftRyblefiWeGzsYWeYsx7dSzLNwL+PXqo8+QsD+S52z8EZ1cPrOxIwPc3MzyBkag
         m27T2aWLiFgL4IgmwofBeS62u72RTpWDjOSqyI6Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190706092755.1e0e8275@collabora.com>
References: <20190706092755.1e0e8275@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190706092755.1e0e8275@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.3
X-PR-Tracked-Commit-Id: ede2001569c32e5bafd2203c7272bbd3249e942e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96407298ff6ef59c4554833d47d29c775d1e7652
Message-Id: <156269550794.14383.5695856165136336391.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:07 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c <linux-i3c@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jul 2019 09:27:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96407298ff6ef59c4554833d47d29c775d1e7652

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
