Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B95777E16
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 07:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfG1FAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 01:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfG1FAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 01:00:19 -0400
Subject: Re: [GIT pull] locking/urgent for 5.3-rc2 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564290018;
        bh=1+VPNs2WNibkly6XcqkCscZlEuNVDtoO5JGLrrHuviM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PX/Zo5gdDTQxOV861p3LtbRbbJylNnb/pPFULL0lEkCy79vQE07R1EQHic3ynUrcL
         8KLGI7n9ugcI4bzWGCVDteHTDOA2aCGHPQ+ovVHu2mDZwqW5u4aZGMNiQ2cS3Zs1+B
         Di/F3M7OFCGk1wDWRTOnK9sBAin1jDG6kkuGCeEE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156426997428.6953.243313961246845573.tglx@nanos.tec.linutronix.de>
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
 <156426997428.6953.243313961246845573.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156426997428.6953.243313961246845573.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 6c11c6e3d5e9e5caf8686cd6a5e4552cfc3ea326
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 431f288ed730abfaca5cb73f7e0a2d04459aa65c
Message-Id: <156429001889.32180.14136791997353219362.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 05:00:18 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 23:26:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/431f288ed730abfaca5cb73f7e0a2d04459aa65c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
