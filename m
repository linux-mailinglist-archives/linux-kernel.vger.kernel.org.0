Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9930129D32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391635AbfEXRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391625AbfEXRfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:19 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558719318;
        bh=3//W+R2g2vtbQtrQlh2PcION/YmJvJ4R3j5ioeXprnY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iurwumsIfrQST3FAYazTkarb1OTMEL6xWkw8iNTGSG5uGRZ6whhBns1YfmO0+8zLS
         ZKy7Xa0AkifFmaAiolWREMIB+QXkYZDo8HhLduuNqUPNQKAJu6XI93J2Sd8Eee3taP
         EWVgx+cnIE/v5cN/DcqfHr39ExrR+T08lsoklsDo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190524101028.8158-1-ulf.hansson@linaro.org>
References: <20190524101028.8158-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190524101028.8158-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-2
X-PR-Tracked-Commit-Id: ec0970e0a1b2c807c908d459641a9f9a1be3e130
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e50e6798f1e29e57bc83ba546a9bbbdabe1104a4
Message-Id: <155871931801.20356.14786012085460229236.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 17:35:18 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 12:10:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e50e6798f1e29e57bc83ba546a9bbbdabe1104a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
