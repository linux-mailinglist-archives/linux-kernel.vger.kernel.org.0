Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5020777134
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 20:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbfGZSZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 14:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfGZSZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:23 -0400
Subject: Re: [GIT PULL] (ibft) for-linus-5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165522;
        bh=UBAKE6BAsIPXe1KS+aRjQRwFDvQNCEb9dXo6spFXWZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YVGOCY4hFFtncFyxPTeh6+YOCIvS2YbIhWAJGvf/FRT05FjWFwS8eINND5nxIVDNL
         3Q8REK8VJT15/QzBXvVt8Sy8aChdXsUG7f3EWKfS1dzOkmV+SCZrKXSaa6jiwzaDRr
         Y3Mnq6GVM+QDzy9lIwxPxSs59PK2UtU89mpFTGos=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190725175207.GC11606@char.us.oracle.com>
References: <20190725175207.GC11606@char.us.oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190725175207.GC11606@char.us.oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git for-linus-5.3
X-PR-Tracked-Commit-Id: 94bccc34071094c165c79b515d21b63c78f7e968
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55d31aaec0da46801e7337779bb3ebe88b034ef3
Message-Id: <156416552201.19332.11360030302385846743.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:22 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jul 2019 13:52:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git for-linus-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55d31aaec0da46801e7337779bb3ebe88b034ef3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
