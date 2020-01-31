Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271C114F2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 20:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgAaTfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 14:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgAaTfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:35:16 -0500
Subject: Re: [GIT PULL] ARC updates for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580499316;
        bh=IUMbiycIe1bt0rX1nc5L5vMe8l9p7Q4JvNaX6pAiDyc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HaGm7W2VBveiKRW9vCudVOvyVIpSHtI79LARltdq3D+bcbxV92qUNh0IqRyD2go5o
         24cKK9HnfNl8cUMdQT+gRh/aDZlWEb015z+S7AxZWiJggcetVCn3vFlasFHGoOiNBo
         G8S3E6xA5uxRPCDD0bsP5O+fcE2fjWrmn2yDcb7w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d709d1dc-69e8-3fcd-f790-8699ca6a4e04@synopsys.com>
References: <d709d1dc-69e8-3fcd-f790-8699ca6a4e04@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d709d1dc-69e8-3fcd-f790-8699ca6a4e04@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.6-rc1
X-PR-Tracked-Commit-Id: f45ba2bd6da0dc8000aa7ea7a3858fb51608f766
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7e573bb4a7a511741f8942b1fb03cfe602ee57f
Message-Id: <158049931650.14867.17056834872077409001.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 19:35:16 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 17:43:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7e573bb4a7a511741f8942b1fb03cfe602ee57f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
