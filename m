Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449D11098F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 06:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfKZFpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 00:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfKZFpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:45:07 -0500
Subject: Re: [GIT PULL] i3c: Changes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574747107;
        bh=nuDyXm+mp6cFNyhAwjYz0fl1RN/MHYSardDiSk6vYNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YnH//R5p90+mvOPrdlu8nZO0Z9/yDlBWRX0TIfhwg306nGnPxb9B1dmjVN9e90miI
         hTfNwollKUBEX0ymnTSueRhDrsQzpgBiQoqWWbXhzKv9Go7XTlIQHu3FzOZkfmMgPL
         CSlLMvcYbj39oGDVzqun22POxRRenAkVgodPIlMw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125090244.1ccd14cb@collabora.com>
References: <20191125090244.1ccd14cb@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125090244.1ccd14cb@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.5
X-PR-Tracked-Commit-Id: ae24f2b6f828f4ae37d0f0fd3be4e7744b6aab13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a11b696975f257ad2410cbb26f288cc52724f81a
Message-Id: <157474710740.9386.2938572312614587508.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 05:45:07 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Vitor Soares <vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 09:02:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a11b696975f257ad2410cbb26f288cc52724f81a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
