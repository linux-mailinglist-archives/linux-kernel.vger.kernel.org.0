Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF57B4330
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfIPVfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbfIPVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:12 -0400
Subject: Re: [GIT PULL] regulator updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669711;
        bh=MnTMxCLDmhiGYKnsiqCSZbUnRoECSUI1XXmavFJhNIE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0eiIsN+s5v/IxJ+6NlAnevRj589oJ77hosLIC0wbi/N/ONt5zuqD2ch298oCIYRUB
         cN5m9q1bDh0ncYPDgUT3e3pAIy0fIzcb4I7Q6fuOuOtTSztisTl4b5rIm6ey8LLB3E
         4KzbJiVNzuBqwkQzjA7xoO2hxqdLwQgGjuuMJh4M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190915230331.GP4352@sirena.co.uk>
References: <20190915230331.GP4352@sirena.co.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190915230331.GP4352@sirena.co.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.4
X-PR-Tracked-Commit-Id: c4ad85026d4dd5a3f65c04b4564fe273e37e5b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4d11ccb2b5cec6cdef7aeeb0017473d23031d96
Message-Id: <156866971161.13102.18008250349824072500.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:11 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 00:03:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4d11ccb2b5cec6cdef7aeeb0017473d23031d96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
