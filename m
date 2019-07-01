Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF120D32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEPQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfEPQkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:40:21 -0400
Subject: Re: [GIT PULL 3/4] ARM: SoC-related driver updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558024821;
        bh=6RhDvkyGscL0Pnfdw/X1wRzhSqReFlcWpE0FSRPy3Ts=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UYq3lHqgJJ8nRcv45axMDXGavlZ/xfa2ugdZBkqMq6WajQA0qsffpOHSs4RDi5jCU
         /FXSCjdEmFaP+3/akCKqozeC4fl6TPTssRbi4WGV+q/gYc3d7l2SOHlje7zH2q0Zwt
         t2FsTNkfCK3YT47KVBf7iA+IDKtls7I76on9MbAo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516064304.24057-4-olof@lixom.net>
References: <20190516064304.24057-1-olof@lixom.net>
 <20190516064304.24057-4-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516064304.24057-4-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers
X-PR-Tracked-Commit-Id: 80d0c649244253d8cb3ba32d708c1431e7ac8fbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc413a90edbe715bebebe859dc072ef73d490d70
Message-Id: <155802482146.32664.5210951355749631063.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 16:40:21 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 23:43:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc413a90edbe715bebebe859dc072ef73d490d70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
