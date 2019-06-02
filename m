Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B4323D3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFBQaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 12:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfFBQaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:30:14 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559493013;
        bh=6W77K+1VaWvd0yLr/qilBdyMSapl3CYKLiCE25hMx/g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v5+dnaqYZ/r5LrYNEdjKWGbTr833n941AdsELZJv/K9YLxRrD5yTz6Y0Ts/g8VeuK
         mxi3QQACXS/tLomrpN8lBAa2Q3wEhFIu9QBF8CfmBfDqlfPeu0l42g5mjkduqDfOkw
         XYHBgJWGDwJ5NqHS6hS7vJxrQEE8Ko0IABEA+KmM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559389512.2947.33.camel@HansenPartnership.com>
References: <1559389512.2947.33.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559389512.2947.33.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 3b0541791453fbe7f42867e310e0c9eb6295364d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1975b337ce26b53814f1b5c55b260649a7115393
Message-Id: <155949301355.9110.2753867128424458270.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 16:30:13 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 01 Jun 2019 14:45:12 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1975b337ce26b53814f1b5c55b260649a7115393

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
