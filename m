Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBB11F494
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLNWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbfLNWFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:16 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361116;
        bh=qRqhz4DmKNMUtrK7aqvcoewGHHbeM+jZAKLx+3LtF0Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i9EKdPcEJ2/o5p26mjeLa5nf8xSSCZZaqVarquMvUPmmo+HtmULyYi/REGC6Rs8+D
         i77vpr7CNs2xljj46qWcgWdYfwSG1yzYMT7V9XwMYoKdIs52aVcxf6D/4740Fjx+K5
         iRee1MyZrBLCZfyDKkvgh5iUyB+WVacxnJEi5MpM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1576339105.4035.6.camel@HansenPartnership.com>
References: <1576339105.4035.6.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1576339105.4035.6.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: bba340c79bfe3644829db5c852fdfa9e33837d6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07c4b9e9f71aa4bc74009f710fc5a745e10981bf
Message-Id: <157636111621.10255.13079108279291730099.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:16 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 07:58:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07c4b9e9f71aa4bc74009f710fc5a745e10981bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
