Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA54210E013
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 02:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLABkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 20:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfLABkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:40:18 -0500
Subject: Re: [GIT PULL] kgdb changes v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575164417;
        bh=U5wyoC5b/9h2G1XvLUScDFCH+7A+o40+EW7kniU9gwg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xw+NnUMwDIAsJMdBwrx7S3qaMZAKI6+EZIzAENPBt7PLv6VE+xaK84OMHrrImp8c/
         cMnli4kYZnWx3f8ayTWsHAAkTMh8iwtqYdMWCU7IC+UPRyXcpo/R/EVP1v6TC+EKX6
         5lIGyUgUl3f/VhZhEaCPQSGG1It0Yfdx9nb60I/s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126153858.bclidzxinfjrtkl6@holly.lan>
References: <20191126153858.bclidzxinfjrtkl6@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126153858.bclidzxinfjrtkl6@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.5-rc1
X-PR-Tracked-Commit-Id: c58ff643763c78bef12874ee39995c9f7f987bc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a99117f6e8793ab945d85db038f09e85703b97b
Message-Id: <157516441755.28955.171624881662964797.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Dec 2019 01:40:17 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 15:38:58 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a99117f6e8793ab945d85db038f09e85703b97b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
