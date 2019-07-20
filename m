Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B886ECFE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 02:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbfGTAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 20:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389307AbfGTAaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 20:30:24 -0400
Subject: Re: [GIT PULL 2/4] ARM: SoC-related driver updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563582623;
        bh=aieO24Tmilr9QBH2VK1ARoxwbvICpE1R/vYGAehhk6w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yYHG9lV3e3zM0+A34LrDC4DQkd7aluQsKWn8c1zg330iXMlusE/J8z2x28f6Ic0Z/
         WD2yLafWpOohRBxRORNAEbqtYmVj8A/1PUaMUeHfkb7Cw7lIoaqLORl0zYfH3SvdZL
         6FtDcTURuCQ+CI2UK6KuEjii+qgTgQTqWeb1ZlfU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719235434.13214-3-olof@lixom.net>
References: <20190719235434.13214-1-olof@lixom.net>
 <20190719235434.13214-3-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719235434.13214-3-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers
X-PR-Tracked-Commit-Id: 8c0993621c3e5fa52e5425ef2a0f67a0cde07092
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8362fd64f07eaef7155c94fca8dee91c4f99a666
Message-Id: <156358262380.21220.15206916055426121206.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 00:30:23 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 16:54:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8362fd64f07eaef7155c94fca8dee91c4f99a666

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
