Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB898CAE2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbfJCSaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 14:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388727AbfJCSaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:30:14 -0400
Subject: Re: [GIT PULL] kgdb changes v5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570127414;
        bh=UBjhMnDknMo9MBM+b7Q1nXNP29xUGsrYmOuL34RiEus=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XJRaODP7UK2oVyVg5fcd8lali/Uv/uxeYkQGBmtI6MO8ywUGg1YjCEZUBGl+ZxNz/
         x80UHBM9C5oeB1YYZ6jcJPCVJJRqvKKX90BfgVhfGYCD/PF8En1kZv5Kr/LTte7/A5
         Z1Z9CqT244wkBJxH5fQhQOT7ktFmR9S+CuU26yAk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191003155606.o5y5vmnszyzotbvw@holly.lan>
References: <20191003155606.o5y5vmnszyzotbvw@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191003155606.o5y5vmnszyzotbvw@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.4-rc2
X-PR-Tracked-Commit-Id: 086bf301f541eb4acfb5dadae7b1b207ad1b95a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1053cd122b23519322c8256ca24487e3b9695ce
Message-Id: <157012741398.22675.8973403667311156197.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Oct 2019 18:30:13 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Oct 2019 16:56:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1053cd122b23519322c8256ca24487e3b9695ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
