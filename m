Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3411484E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 21:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfLEUpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 15:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730206AbfLEUpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:36 -0500
Subject: Re: [GIT PULL] Modules updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578735;
        bh=4PwQH4H/YtEqPmLpUS3xk4NWALPxDy7UVP2naXYXj3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oerrm3K5mjnz/2cZAjKtxhAHhDcWzhqIm/mIokk+LCmFI0XAR7LDQOELvS1GilwCB
         3HyrbGytnbBA5UwUurJLZZYWrO3sBKL79HBUYNBF27TbkqaQNOiXaZgFWkRbJTc/BF
         41+Kr5bExQexw1FPp/NGYuOl52k9T/ooIvskdQ4Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205200945.GA1750@linux-8ccs>
References: <20191205200945.GA1750@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205200945.GA1750@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.5
X-PR-Tracked-Commit-Id: 5d603311615f612320bb77bd2a82553ef1ced5b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f137416247fe92c0779a9ab49e912a7006869e8
Message-Id: <157557873592.26858.2254245864922941283.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:35 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Dec 2019 21:09:45 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f137416247fe92c0779a9ab49e912a7006869e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
