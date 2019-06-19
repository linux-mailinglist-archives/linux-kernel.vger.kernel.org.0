Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C054C122
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfFSTAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 15:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfFSTAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:00:08 -0400
Subject: Re: [GIT PULL] apparmor bug fixes for v5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560970807;
        bh=Mva4RFv1M0/5OCyHMcVJ2gu2vox17gPlwwMFPCzMWws=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QUccs7EgTevSBjKGRnVbe4FoVMhsgKUq2XUMREW1ehEGzpCdBtR7SQ8JLXGx8oLVJ
         YkEKycGwwTbpp/lEheY/ML005sNhNDaLwaJhtrrP/JBrf1hy0iwXexno/3lu0xh7oC
         L2hrUOrymArBb+RwpR8SJRM9UBkan0+5Pqd2WRPw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cfc8f629-4ffa-e64e-f23f-2f4cffca4f18@canonical.com>
References: <cfc8f629-4ffa-e64e-f23f-2f4cffca4f18@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cfc8f629-4ffa-e64e-f23f-2f4cffca4f18@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 tags/apparmor-pr-2019-06-18
X-PR-Tracked-Commit-Id: 156e42996bd84eccb6acf319f19ce0cb140d00e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3c0d546d73ad53c85789154872b8c92d1f96ba1
Message-Id: <156097080700.11094.10794040979648534918.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jun 2019 19:00:07 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jun 2019 18:44:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2019-06-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3c0d546d73ad53c85789154872b8c92d1f96ba1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
