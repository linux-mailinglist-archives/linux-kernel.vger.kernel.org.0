Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC0E2EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409068AbfJXKZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 06:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405702AbfJXKZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:25:07 -0400
Subject: Re: [GIT PULL] regulator fixes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571912707;
        bh=trat/hM1iZw7v3j4+QzkKNY15YvQW3URoaxVJwxQYb0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iLSUeP4Nzm5di0w5UjVX3CpUHiBfTFMGf/JBDc5mqUzGV5dcnQE+Qeu9gJdXozA3T
         8YMgDhAqyqEX4AwTpRggTV0K1KbOyKEDTPK5OQySsvAYcp5JHQf0qmtsossWSeau1C
         vjtjjC7UliiWTdk93BbdvH2gw0+vrO/R2T9XFxuE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191023164131.GJ5723@sirena.co.uk>
References: <20191023164131.GJ5723@sirena.co.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191023164131.GJ5723@sirena.co.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.4-rc4
X-PR-Tracked-Commit-Id: 77fd66c9ff3e992718a79fa6407148935d34b50f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: deed1d44699135e5af7678442607469d14a92141
Message-Id: <157191270707.16083.4149543236217077906.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 10:25:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Oct 2019 17:41:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/deed1d44699135e5af7678442607469d14a92141

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
