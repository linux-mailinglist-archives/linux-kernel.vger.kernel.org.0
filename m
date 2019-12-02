Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF210E461
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 03:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfLBCFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 21:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbfLBCFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:05:20 -0500
Subject: Re: [GIT PULL] MFD for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575252320;
        bh=49YayIKrbNdesXjIC8kdUbtDCuPeKKSzkbs/Y1leh94=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YFacKDNQt4xSlTj4Ap8JTkgmIf2h3etswfQFFSWYGn7Do9rBBixKJo3hfMMNVUzJx
         6filJTdZWkU2B54t9nDKwEWkLuClcO/iTmqCpqlNl8xHmhMvwV/aAai80UnU1VrIxE
         gTiQJuLPE966SAQLaMcy1Pu8TUwdTueqEeiFILIw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128144807.GB14416@dell>
References: <20191128144807.GB14416@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128144807.GB14416@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.5
X-PR-Tracked-Commit-Id: edfaeaf742b4c3ee6f58e0b8be95b5296a3375e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37323918cac24c89facdc009b0566b25cce94ea5
Message-Id: <157525232013.26823.8366418486058198342.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:05:20 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 14:48:07 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37323918cac24c89facdc009b0566b25cce94ea5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
