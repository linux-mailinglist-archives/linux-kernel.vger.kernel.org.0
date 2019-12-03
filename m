Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9211037C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfLCRaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 12:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfLCRaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:30:19 -0500
Subject: Re: [GIT PULL] dmi update for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575394218;
        bh=ov6uYvmyeKZThHZpYr+zuN/valNM2WOp+h5tx8ytMZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XdXV9ZfG9hW0VXuaUsOzMhEhiKtNT2vz3IUvIC34tEWl0eZcfANCNE+qQkpEsMp1E
         tJvBGNKE7526KWvp7BnN7H0T4K8Fz5U/nLDQqORznHzywvB+TFQ6ANOKDrOLtRicpE
         /kL/C6gdWrSHexb8hEBiCJyPaQEaVv5gVmYBfbTc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203113938.4fb05398@endymion>
References: <20191203113938.4fb05398@endymion>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203113938.4fb05398@endymion>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git
 dmi-for-linus
X-PR-Tracked-Commit-Id: 7c2378800cf7ac87e2663afa7f39d102871f0c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dff2a1c9b7cc83529119eb04cef1d7b68e11352
Message-Id: <157539421889.1633.515262804046240070.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 17:30:18 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 11:39:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dff2a1c9b7cc83529119eb04cef1d7b68e11352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
