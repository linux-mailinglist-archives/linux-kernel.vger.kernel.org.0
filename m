Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EAF12387F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfLQVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 16:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfLQVPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:15:16 -0500
Subject: Re: [GIT PULL] regulator fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576617315;
        bh=wwq1d7kL/xgWfp2a7DAUXWN3nvZCsn54omsv3NdHofI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qXHTAkkPlmkxIBFxEMcVzV0g9aAHQLZe9XolHyyYNo1K57LqWubtSvaSSt/IkwJ8s
         Mm4nzxUtIG8fwS+1BNph7BeD9qnvMdsZjkgOYIHSM63QkFDHFl1VNA0o3F+Tq30VfX
         uMYKYotaF4TYt8KRaRcraYv1QaUMeobmEtuCfHWc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217123349.GE4755@sirena.org.uk>
References: <20191217123349.GE4755@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217123349.GE4755@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.5-rc2
X-PR-Tracked-Commit-Id: 62a1923cc8fe095912e6213ed5de27abbf1de77e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58d90a04bdcc28e1b34251f4d9c1c4d39d4bba69
Message-Id: <157661731547.2643.16999106884357676341.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 21:15:15 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:33:49 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58d90a04bdcc28e1b34251f4d9c1c4d39d4bba69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
