Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BDF11EE3C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLMXKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfLMXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:14 -0500
Subject: Re: [GIT PULL] Devicetree fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278614;
        bh=9Jqy57MnuS+7AL5Siub1FpBM4jXOJuv2RI7AfSUxAJU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mNYzpgzF6EuTHz1J2kHjnedWo1fH9GpIaJwTa3G/5f2X7RV9Xt/+r6/I6UmG8zmm2
         FFDYdSEsCIJ03iMcWmvpO7XJK2KCN1Iof155J/I3rHX29v8iJdFLWDe1uQCf1HXJo4
         wE4j6kAOX9B9L0uUACwlgGrrl84GLGtMjiq2Qbdg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191213153531.GA28973@bogus>
References: <20191213153531.GA28973@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191213153531.GA28973@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.5
X-PR-Tracked-Commit-Id: ee9b280e17dce51c44e1d04d11eb0a4acd0ee1a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1482e664fe353775c48d3f9d3e5059b9853d4d99
Message-Id: <157627861412.1837.5586160503821764001.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:14 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 09:35:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1482e664fe353775c48d3f9d3e5059b9853d4d99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
