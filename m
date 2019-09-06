Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61AABD48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405831AbfIFQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 12:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392057AbfIFQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:05:07 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567785906;
        bh=5yaOr2Yil3vt014dyHva3cmCs/812kSoThsrVHyY+ew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r+EwSkltEYN70HkKmlZ6u+mPBAPCq0vFEKmkjVA1EZh5aLSSVaTSYzySZbLPE4QTa
         KfJrzzl+nRoi/tRR8UYTBmk2/5rVdMfi7smWzYoQezPPKcBDWOHwwp1yL936okUcVa
         Pwfcmqltpj/gmyCxZCiCJae+D/gIhWE9nwOtjKHA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190906102137.637-1-ulf.hansson@linaro.org>
References: <20190906102137.637-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190906102137.637-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc7
X-PR-Tracked-Commit-Id: 8ad8e02c2fa70cfddc1ded53ba9001c9d444075d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0445971000375859008414f87e7c72fa0d809cf8
Message-Id: <156778590688.8517.16430260265496177921.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Sep 2019 16:05:06 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  6 Sep 2019 12:21:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0445971000375859008414f87e7c72fa0d809cf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
