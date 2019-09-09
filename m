Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83F6ADF93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 21:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405819AbfIITkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 15:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405742AbfIITkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:40:07 -0400
Subject: Re: [GIT PULL] regulator fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568058006;
        bh=l9yk5C9PIOyhPJqJ+6kH32ph1DRKYAUwjm1iJI+zw9k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tLtj/Yohggg28i176KYvl0eKqKjjd2/GEGIFmVq2UeyUCcO16LME6gbNmSor+d30C
         gi67oSiztUyvZKwTZoWDd5cZnNhbk7NSXkrbCnUBqlVpoXpjuKip4/utCcEHq73euM
         YbKL78OkqCG5s1jYs+t9gjfBKeme5fu5Vx7EBH64=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190909141604.GI2036@sirena.org.uk>
References: <20190909141604.GI2036@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190909141604.GI2036@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.3-rc8
X-PR-Tracked-Commit-Id: 3829100a63724f6dbf264b2a7f06e7f638ed952d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56037cadf60461b4a2996b4d8f0057c4d343c17c
Message-Id: <156805800683.31009.6693230726754417981.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Sep 2019 19:40:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 Sep 2019 15:16:04 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56037cadf60461b4a2996b4d8f0057c4d343c17c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
