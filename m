Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468D8C0C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 22:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfI0UPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 16:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfI0UPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:15:22 -0400
Subject: Re: [GIT PULL] arch/nios2 update for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569615322;
        bh=QBO3i0U9u0yvcgtO62IvhaCFPAA9RqQLsM6h9oR7iBE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FWEI4jHdeqHWvAcOrgKwaNAyXoAbyRmZrB+KuR8TjU4O44SwLjrFR6nyuIlNueUbz
         2dsgcSIcq4ZpFUE27Pql52fiWJFnJBZ4ql9Hyf3lBgcUf+lEjYLEtIYM4M1hSjU8xp
         4n/VNIi67eSAvTn8sdgjaurerv/N969co/SaFKfQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1569574252.9826.4.camel@intel.com>
References: <1569574252.9826.4.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1569574252.9826.4.camel@intel.com>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 91d99a724e9c60e14332c26ab2284bf696b94c8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70570a6418be2bd28be30fda700e57a81df7282b
Message-Id: <156961532241.31800.5944226627488244545.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 20:15:22 +0000
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "lftan.linux@gmail.com" <lftan.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Sep 2019 16:50:52 +0800:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70570a6418be2bd28be30fda700e57a81df7282b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
