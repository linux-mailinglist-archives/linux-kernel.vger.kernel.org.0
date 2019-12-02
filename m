Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7BA10E464
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 03:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfLBCFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 21:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfLBCFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:05:19 -0500
Subject: Re: [GIT PULL] Backlight for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575252318;
        bh=PnzmZ1l6elwD1S8GUuhop+PktoKslOXlwGUay8hIf6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y3GLb9cvD44aoKS95CyR8ACBL6Cv8LXica2FpLxAQ1zuhKosj3UqROW1utAz7G/Hx
         DMVdo+TelAt5wsrkQ3TG0CG/xKp5joO6HvpbwVHIvWWAlH9MiiRxqFPa0qtFevJsnk
         kdoyClWu/yVul5PfjL6RSbzQ8nAbimyY5sAYDfMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128144511.GA14416@dell>
References: <20191128144511.GA14416@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128144511.GA14416@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-next-5.5
X-PR-Tracked-Commit-Id: 102a1b382177d89f75bc49b931c329a317cf531f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38edc3dff9d2805c48e0a171667e7ca820336ab7
Message-Id: <157525231871.26823.2841519412473226517.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:05:18 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 14:45:44 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38edc3dff9d2805c48e0a171667e7ca820336ab7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
