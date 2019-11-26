Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF41097BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 03:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfKZCPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 21:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbfKZCPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:11 -0500
Subject: Re: [GIT PULL] m68k updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734511;
        bh=fUTixOUXgX4xQyp7iS+tzjyjkV5MbzkvlYm2t91QnxY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kRnheX/tCUAIa9PdoN8mo4711Exv83krvTlPv5zl+AxUz/wuRjxyM1AISn9am2duh
         wWn/jt4NZ33DXvyRISSMx25HKElCkrHpNfgX2QHXqBDkK4TJsE9WoWagVRakqxFySB
         KJfVizEiC8MDKacGyU3ofx2m6Wcpim8YHCex6OTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125093320.12738-1-geert@linux-m68k.org>
References: <20191125093320.12738-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125093320.12738-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.5-tag1
X-PR-Tracked-Commit-Id: 5ed0794cde59365d4d5895b89bb2f7ef7ffdbd55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ef30d74232ed204a461a5dbd0309718d63abd01
Message-Id: <157473451137.11733.638944916333266059.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:11 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 10:33:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.5-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ef30d74232ed204a461a5dbd0309718d63abd01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
