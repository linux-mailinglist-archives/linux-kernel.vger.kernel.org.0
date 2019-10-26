Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269E7E59A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJZKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 06:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfJZKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 06:45:06 -0400
Subject: Re: [GIT PULL] dma-mapping fix for 5.4-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572086705;
        bh=wdh+9CC4zUjH3UODJiT2QF2al9L/PsZbfHr3V3iKhlQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MuZAVF8EFlEWDixY58ZGWLsdUpqIVP2UMFen0yfcCE8Zl3WTWeqAt+LAiuxvNYIRw
         KqWCDP4q7DA/z3JuYa/oRrq+DKAFvWTwB8cIVdi3JcDn4WsRChZPZZsRimgh/xI6Hz
         yybxqTjSu27VCnp1atiWQaq5m0DmwGpBLqwkhct8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026054551.GA5340@infradead.org>
References: <20191026054551.GA5340@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026054551.GA5340@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.4-2
X-PR-Tracked-Commit-Id: 9c24eaf81cc44d4bb38081c99eafd72ed85cf7f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 964f9cfaaee31588b1f1a23edee8bed94136452a
Message-Id: <157208670584.20302.7834835768159432653.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 10:45:05 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 07:45:51 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/964f9cfaaee31588b1f1a23edee8bed94136452a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
