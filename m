Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9C51BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 22:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfFXUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 16:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfFXUFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:05:04 -0400
Subject: Re: [GIT PULL] MFD fixes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561406703;
        bh=LijzAu6DGrK9bv659BIrOOCohD2isQ91AwWVrppW/1A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZGmXJ+vDJkxift9jo6vAKdn0F9DLHRvFVQunc5XleLoO0AzD5umS5OARsOXP1F6MD
         manSyzdEPcBfC/KQAJkIbmQaEt9JOt8ac6RVdVD7oaDN3AGrN0B7x7mBc43M17qJy4
         9Lh12ckywXKKOVtRfkVCrEJz9XLmPcLloy001w6g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190617100054.GE16364@dell>
References: <20190617100054.GE16364@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190617100054.GE16364@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.2
X-PR-Tracked-Commit-Id: cd49b84d61b2dfc0360c76d9e6be49f5116ba1a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63b2de12b7eeacfb2edbe005f5c3cff17a2a02e2
Message-Id: <156140670371.9276.768665215644990880.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Jun 2019 20:05:03 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jun 2019 11:00:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63b2de12b7eeacfb2edbe005f5c3cff17a2a02e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
