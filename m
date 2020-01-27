Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE7A14AA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 20:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgA0TZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 14:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0TZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:25:05 -0500
Subject: Re: [GIT PULL] regulator updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580153104;
        bh=Z6iVP1EIeNMdYFjfv6EZ71Peb8Q02cGFOMUNoyliHk8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x/NWUc3dCuMRb6WSl4ZYcHFLdKc9dUhtDLo5Fm1AGMHyH6C/+RDzeggwlTH7RIZdi
         zcsy2ETw8YeyZ7Xn2ijgNrg3nsqmQ/C6yxjFLLw6sttVNa5IOq+DCpq82UBZ2Rv2Ft
         PUvgsC6VnQi6Y5XBc/AV3l9OTE4weBVEdg5NjfV4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127173859.GD3763@sirena.org.uk>
References: <20200127173859.GD3763@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127173859.GD3763@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.6
X-PR-Tracked-Commit-Id: e4e4c2ff78edd2f9c7d2d3e588ca68ffa1dd8dc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aae1464f46a2403565f75717438118691d31ccf1
Message-Id: <158015310462.9462.2453864679200933923.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:25:04 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:38:59 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aae1464f46a2403565f75717438118691d31ccf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
