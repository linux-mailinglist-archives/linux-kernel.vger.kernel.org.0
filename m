Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308736A187
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 06:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbfGPEfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 00:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733149AbfGPEfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:35:18 -0400
Subject: Re: [GIT PULL] MFD for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563251717;
        bh=a3NxcsZMgzh+Fs9H9nvfM6IJImtQ6nfxS/+zKPeTTIo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mDobt/nojYrVQJ1h9rMCA7xsN9BmWnqpaEEygZk5K6EoXzRp/k7isws7rZBshJT/8
         S2IaM3bZTfO2Wr2CwYyZemWEcXusfJvcBXN2kiz8SfiVXaqhbyITxFlEF+dVUQf7Cz
         9dEAUy6s96rNNfbR0dLAV/oWRklFfdgpbKfEJFLE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715074835.GC4401@dell>
References: <20190715074835.GC4401@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715074835.GC4401@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.3
X-PR-Tracked-Commit-Id: 7efd105c27fd2323789b41b64763a0e33ed79c08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8de262531f5fbb7458463224a7587429800c24bf
Message-Id: <156325171739.15429.13286602087178975217.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 04:35:17 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 08:48:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8de262531f5fbb7458463224a7587429800c24bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
