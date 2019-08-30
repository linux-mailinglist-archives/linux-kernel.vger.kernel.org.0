Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647B9A3C36
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfH3QkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfH3QkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:40:08 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567183208;
        bh=3w05IZaFw4Zq4OAO+9qmAJjzhQNBpvbzD7cVOf/PzHY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nju5dpgjffgzJ0MZZWQSNobgA4vwXIxM75Uk2f6ElF8c7gATNXOVSmnGEaqoLG2rr
         sx4Gbk1YeF49Ikct+gJZaudNm/FGxq48RKx7DDS+aew/fZsXuA8bL4kuZUbahzLLV2
         G6ns5DNVIML74S9F7s1s586kqAVAKJi1Md5d8Ke4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190830074147.3691-1-ulf.hansson@linaro.org>
References: <20190830074147.3691-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190830074147.3691-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc5
X-PR-Tracked-Commit-Id: e73a3896eaca95ea5fc895720502a3f040eb4b39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d70787b65941a8db36fd2c35d25c93178f8b545
Message-Id: <156718320803.32023.885555795131888742.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Aug 2019 16:40:08 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 09:41:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d70787b65941a8db36fd2c35d25c93178f8b545

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
