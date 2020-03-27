Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA0195D96
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 19:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0SZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 14:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0SZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:25:08 -0400
Subject: Re: [GIT PULL] Devicetree fix for v5.6, take 4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585333508;
        bh=kphzszlwm1La47MdscXO3TtRShKr08jrCtW7lu0cN2w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dl64cjkmOaBOAkav8OTe3XU5I43HQLRNwNKDo+t2tbMMYC0t9iZr5cPa/p9F5m55d
         gxNA6MhS4o04o3ZHtJNUP8KT4N6HzwqKn/ZONVdu4Q7La1AyHwbvT1ffmM6OszLxiA
         rlr9IvDT+iQaIVtnqXra3jdl8NQEaNR+TNCWYT5M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200327143756.GA32333@bogus>
References: <20200327143756.GA32333@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200327143756.GA32333@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.6-4
X-PR-Tracked-Commit-Id: e33a814e772cdc36436c8c188d8c42d019fda639
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb36d37e29d4e355fdffb4cd932cbb60e25e7e02
Message-Id: <158533350842.5176.13671252955461676794.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Mar 2020 18:25:08 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Mar 2020 08:37:56 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb36d37e29d4e355fdffb4cd932cbb60e25e7e02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
