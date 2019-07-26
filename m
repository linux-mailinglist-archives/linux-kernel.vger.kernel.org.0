Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89717714E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfGZSfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 14:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfGZSfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:35:19 -0400
Subject: Re: [GIT PULL] Documentation fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564166118;
        bh=00eFWGSJAFEiRhcAVxH0e+juGnNJgTCywMWQMpyjPWE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T9MW8XLiEOCrqT/wmrG/A0cQCpHHrpKubD0YCsGLGcVc/rgF/LM+SXxquKZzog94n
         vG6/umqjUGnyD5zzkc2sEtFLM5iREg+7AbOyb+pWsBKM3wFsRoAn8p+ZPIPVOI15//
         NS5cA3NWgpmmYOPtGVt2/WDNx5OBo5X87v7oLjkc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190726082125.0c8467e9@lwn.net>
References: <20190726082125.0c8467e9@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726082125.0c8467e9@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.3-1
X-PR-Tracked-Commit-Id: d2eba640a4b96bc1bdc0f4a500b8b8d5e16725c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ea54d9b0d655dab5b5becc7d6456082089fc166
Message-Id: <156416611868.28538.12602714238237239718.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:35:18 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 08:21:25 -0600:

> git://git.lwn.net/linux.git tags/docs-5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ea54d9b0d655dab5b5becc7d6456082089fc166

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
