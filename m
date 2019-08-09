Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6368804B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437444AbfHIQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 12:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437320AbfHIQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:10 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368509;
        bh=N9F7Jw2Dq7vVnJFXitrX8BVxevJLrxprukSoIaHNVPE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IdSvxobxdCEWW3lFo/vcpzgRxgEZXa5wPvBJONpKWwmubHlTXzA/ZjRZ+I7jQTYtZ
         mfA3OFv0UXfeFB6T3f1UQ3ybeQ9aSTkc0iQo8Y5q3GQ/1M46iTsbZbRXLlT1Xy7jHA
         3zws/bc7cwbEJZnpq4ejjFFGoLo4c50nRlhXd4vY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5ho90yhex9.wl-tiwai@suse.de>
References: <s5ho90yhex9.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5ho90yhex9.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.3-rc4
X-PR-Tracked-Commit-Id: 1be3c1fae6c1e1f5bb982b255d2034034454527a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb42f06c9f418ec2ee56667d01e9ba965a4c61c9
Message-Id: <156536850910.6429.16027630638861476980.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:09 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Aug 2019 11:21:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb42f06c9f418ec2ee56667d01e9ba965a4c61c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
