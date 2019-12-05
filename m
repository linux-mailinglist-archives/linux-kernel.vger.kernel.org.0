Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5623711484B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfLEUpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 15:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbfLEUp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:28 -0500
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578727;
        bh=03Fu5fYuvqvbhxsml0+DONIAkc1U6XblV9t9frUBEfw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FMfDN/RxzAOYr8tz+UGqAPJwzIVCTogL4i4Qj0VB1ipXYY2nc7Hk9psP0rgh/KLyU
         g17U5rKDVlKeqrwtMdTwW6gof19agEGaT7nzrPkPyfhXQgZ9KCl7EAi3psiMf76SJq
         NuSbraKP+/elg/XB20qoc/4GdBeTcVZE6cA12Dg4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205180453.14056-1-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205180453.14056-1-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: ab818f0999dc73af3f966194d087e9f6650f939f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6
Message-Id: <157557872789.26858.3675924643438407119.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:27 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Dec 2019 10:04:50 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
