Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB510B5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfK0SpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 13:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfK0SpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:15 -0500
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880315;
        bh=Et45nYjHHhdlrb0u6s5hUgzH/53qX2G2iHPEcjL8L5o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IWjCMvEGQ+u2BZQvmLR2xi37QPQm1Fj7fNmUei96JtpAiFjJgfiNehXbuPOWHB6ix
         sLiGAt3A9/ggGmXyhUDEY6oyMkG+f6kZ4IxqK82UqV+GL84JHtQQY5bjsNi5MwdFRp
         vTV1GkXP7xAt/WH99eAwtwWpqBur7eveoGvql02U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126154851.14737-1-ulf.hansson@linaro.org>
References: <20191126154851.14737-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126154851.14737-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5
X-PR-Tracked-Commit-Id: def7bd940f8cceb41ec3d1383acd8ab937056dcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e45384cecccaa950783e67e7a29ed470133f19d
Message-Id: <157488031536.21185.583861190630466522.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:15 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 16:48:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e45384cecccaa950783e67e7a29ed470133f19d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
