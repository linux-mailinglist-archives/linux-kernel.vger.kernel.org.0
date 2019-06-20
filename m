Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6144D9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFTTKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 15:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfFTTKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:10:05 -0400
Subject: Re: [GIT PULL] arm64: fixes for -rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561057805;
        bh=mLnyONor8YwKu0lQJZYf617exsgcRJjfEH8DZTdJwDU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZdTWmd5PAjyYveR9hc9Mebl+oshrauBIiQESas+U7NK/5O11my77W9JfJRQ9vT85s
         tN3vtuzlNRAnjQUNGZN9VkVhTQZAnTCAcY88OZU2LUb6GwFyK9UW0W1Yax/HuRc3Br
         mu4sZXVQzUgVIrYX3oKJJg18CHVjg8QtUrl2eons=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190620165916.GB24650@fuggles.cambridge.arm.com>
References: <20190620165916.GB24650@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190620165916.GB24650@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 615c48ad8f4275b4d39fa57df68d4015078be201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e929387449cf631e96840296a01922be1ef3c832
Message-Id: <156105780497.22331.18365592459813742115.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jun 2019 19:10:04 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 17:59:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e929387449cf631e96840296a01922be1ef3c832

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
