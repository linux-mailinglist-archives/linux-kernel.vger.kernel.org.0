Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFB1098F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 06:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfKZFpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 00:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfKZFpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:45:06 -0500
Subject: Re: [GIT PULL] pcmcia odd fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574747106;
        bh=9ctIAKYrJWDfdc0tqDnqfXG0o7pvTb+ADx1d/tT9Vcs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LMCj91ar9JgKLaJVQL225AkoLUUpRyvqvtEjWPmx4NFvGpd2AIxDCV6Hw0aEMc2CQ
         dnhyXvz5FXEnhZkWkEY3TPDhWQiMxxz9+7qc74K6IzTqgEZ37jVp+Df2chQt11LcFh
         ItXKffQvueeeOZYQ+yfr5VBoRrud3kwXdxrRtcW0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125070745.GA589513@light.dominikbrodowski.net>
References: <20191125070745.GA589513@light.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125070745.GA589513@light.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: bd9d6e0371d147b710f549b55d7b44008264aa06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae2dc032773da914911f4e2a6075f31d1cbc9ca0
Message-Id: <157474710607.9386.12048626518016616769.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 05:45:06 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 08:07:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae2dc032773da914911f4e2a6075f31d1cbc9ca0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
