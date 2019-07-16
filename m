Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A266A6ADBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfGPRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 13:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPRfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:35:18 -0400
Subject: Re: [GIT PULL] Backlight for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563298518;
        bh=Sw6G1ZnosnI0CUcwosNoY9FjLHgWm8eQtW+B36A7SX8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zfPvFujcMCFsba0d0hCPafSEHYW+5eMssvfvVocwx+cSrDPH+NaBgDJqD1Nc7pym2
         XvSFihEQN6e2zKFbbEu0uu8eKtVedPYzcWoPLj8x5WayEmMPjMp0znhiJOParrGarF
         TueaXlkhoz4EDNb9eNbHOkqYja5YA5gCS9Wlt2PU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715080009.GD4401@dell>
References: <20190715080009.GD4401@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715080009.GD4401@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 backlight-next-5.3
X-PR-Tracked-Commit-Id: 73fbfc499448455f1e1c77717040e09e25f1d976
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50950626414a982c8ed539128c7f69a3d328a970
Message-Id: <156329851813.6656.3301753205079827662.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 17:35:18 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 09:00:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50950626414a982c8ed539128c7f69a3d328a970

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
