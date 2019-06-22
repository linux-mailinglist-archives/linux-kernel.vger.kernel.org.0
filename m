Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1ED4F8D1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 01:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFVXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 19:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfFVXFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:05:05 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561244704;
        bh=7QUak2VryUzJwlPALMoUzkXCarUVSfSF93ogRPYy7Rw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G7z8ii+ZisH9XgKUpYJfVPRw5IkNG/61M7CIvWj85/D4T8f59zeVh5jRguBtaTHOF
         L5wlNVE5NiiU6RVKS/7w3LUf33OPK4Ru/lknH7a7svM2V1NqCD4lL9Irwf2/SFQcTD
         9I4AJq6PvfVvK41ZhRJc1jaFjmWvYaxESPgK2W8Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190622194641.GA5200@8bytes.org>
References: <20190622194641.GA5200@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190622194641.GA5200@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fix-v5.2-rc5
X-PR-Tracked-Commit-Id: 0aafc8ae665f89b9031a914f80f5e58825b33021
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6698a71a1e360d89514aafcea15ccff837f59038
Message-Id: <156124470420.733.3742446385319983333.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jun 2019 23:05:04 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Jun 2019 21:46:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6698a71a1e360d89514aafcea15ccff837f59038

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
