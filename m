Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E5A17ECB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 00:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgCIXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 19:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgCIXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:40:07 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583797207;
        bh=oW9dYCrh/741KAP4Zl39z1XztqvyWrWSjONJF8a0AfI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zbGsdai+E2Q+ZO2c2O/aD+xAnkPLQjoDkwsyOxPh+SFK7JoRZtLpIvkTqo03LIsMK
         3sdtaskfj8eaVEbD/3g7wPR86aFOw93WIyXG87Ima7mlesFvhqL1X52XGe/mBWl/P0
         DW6JiX2eMokuCW+bmuFohuV1YuNdZL1PLyZWjLpc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200309154336.22598-1-ulf.hansson@linaro.org>
References: <20200309154336.22598-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200309154336.22598-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc1
X-PR-Tracked-Commit-Id: 31e43f31890ca6e909b27dcb539252b46aa465da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d397a82b7ccaa4c4fe3e149ecb763dd6214abc93
Message-Id: <158379720717.7202.15051008030468380095.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Mar 2020 23:40:07 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  9 Mar 2020 16:43:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d397a82b7ccaa4c4fe3e149ecb763dd6214abc93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
