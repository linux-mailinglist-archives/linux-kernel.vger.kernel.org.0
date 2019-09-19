Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90DBB8367
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404877AbfISVah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 17:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404843AbfISVaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:35 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928634;
        bh=4MnoG/BKHITPvEBxROAt2KBSPTK1LsMVqyRz44QC8II=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WNiG6SUSjA3fDpx7xzRgHMSQh6HKnY6gwqojalRnXclQFLPtJpDaRUQ2ECXs+E/Ry
         E2RpkYMuNspjzlGW3afr4YzzAx4BdfnKYOMV0f7Ipg1CnJ7p5+hD+S+AomgaDl30pv
         AlAeTTvfJhCflsH7HJm76TvMW9Kzh/AFqWHN03og=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919174641.GA172744@google.com>
References: <20190919174641.GA172744@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919174641.GA172744@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.4
X-PR-Tracked-Commit-Id: 4c1fde5077dcad1a2a10a6a0883c8f94326c4971
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32b90daf5cafdda62b1ce62d0b7445fa9107babf
Message-Id: <156892863488.30913.17670198651332075462.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:34 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        gwendal@chromium.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 10:46:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32b90daf5cafdda62b1ce62d0b7445fa9107babf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
