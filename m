Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB110F484
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 02:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLCBaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 20:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:32796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfLCBaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:30:21 -0500
Subject: Re: [GIT PULL] OpenRISC updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575336621;
        bh=2HHNi9jt2CEjhhglrUy3+GonDpvuMHpqSRE7j1QJELo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cTasfkY68100KpxSVud6QK7y2niwnJx7hq0+Mr+9bAhC8Sj93MdklSXh0diHTFVLd
         JobIScItUtpCFb5WRZoapw7XaaFlgE233QVUvvS6rV0osrIJJWtduMXtCNnVeg5wKB
         fwshiyOBgL2Agt9jQqA23RD6RYILK7CTzy+qnzIk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191202115510.GO24874@lianli.shorne-pla.net>
References: <20191202115510.GO24874@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191202115510.GO24874@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 0ecdcaa6d5e78649578ff32c37556a4140b64edf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 120e47686a00144ef1195cfc137645d1bed46d23
Message-Id: <157533662106.4888.4608498727365693870.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 01:30:21 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Dec 2019 20:55:10 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/120e47686a00144ef1195cfc137645d1bed46d23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
