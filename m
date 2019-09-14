Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6EB2D50
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 01:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfINXZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 19:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfINXZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 19:25:06 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568503505;
        bh=c2DxHSp2xDuVui8yBLpwQ9yzQC4MddAJv23G2QnKbM8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kZNelUPbbiwZnavYdyVd2lIWbON+Xxgiu9KTpu9SxI7EdpDhE+46dwfnzS0gvIOoX
         s79Nbw09NORxUy+VrW12AXlJXMvMQtnV0PpD36MksAgQjnpTPM/ZpmfuTdAQ0QuHtP
         ScU0nRDVlDBk2om8qqse7/rwIX6CpQpt9pvvW6dQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913115724.22341-1-ulf.hansson@linaro.org>
References: <20190913115724.22341-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913115724.22341-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc8
X-PR-Tracked-Commit-Id: 87b5d602a1cc76169b8d81ec2c74c8d95d9350dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c4c5e2528af0c803fb1171632074f4070229a75
Message-Id: <156850350565.2116.11769957092833227989.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Sep 2019 23:25:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 13:57:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c4c5e2528af0c803fb1171632074f4070229a75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
