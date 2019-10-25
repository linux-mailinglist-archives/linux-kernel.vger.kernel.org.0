Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284BBE55F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfJYVfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfJYVfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:35:06 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572039305;
        bh=kIBRFC+WzLvHnyuivCbAm9UXp/nf0r1cY6JZlUeqvfs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=myXHvwEQusb9e1pq+lpzNES512g/Njno0IKgiCxzkGFSkpeqVjs4FB1Y0JUog3EPb
         gZG3F996Iys2X5z9+CjUcYVAQyA1vlqXMtxOEWTU/wUr9GM5AYMAdPrIJBDOnSaWkN
         fVymj1cGS1BfAjZtYvT7u+rEkL4NEmQnJbt5luow=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191025153817.rtj6hh6jmr5asfto@localhost>
References: <20191025153817.rtj6hh6jmr5asfto@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191025153817.rtj6hh6jmr5asfto@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 86ec2e1739aa1d6565888b4b2059fa47354e1a89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63cbb3b364c0c2500e59d24a6cde92c8f2ff1c18
Message-Id: <157203930573.23557.14092448668609979344.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Oct 2019 21:35:05 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, soc@kernel.org,
        arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 08:38:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63cbb3b364c0c2500e59d24a6cde92c8f2ff1c18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
