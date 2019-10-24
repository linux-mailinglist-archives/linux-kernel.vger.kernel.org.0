Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1410AE3F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 00:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbfJXWfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 18:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbfJXWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:35:06 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.4, round 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571956506;
        bh=UxS1/0iOkIcZ9qv0FyZweVUjggL6cG18LH/dVZuywE0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1dYf/QBvnWfqCzu5YO0ZwW1gzZYOX2OnYQcJryTef6+J7q0ILUCEOzLknyrB7DdNI
         12QaNcf9rWQByorXpfOBYm4apBC1q8yFMwkHS2/I6gAeuGsCeDgVdHCwP5WwdoHbl4
         lxKxtTJWYx084fsIAbmfXtjSn5y2GcJMHI6b5FZA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191024222255.GA25776@bogus>
References: <20191024222255.GA25776@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191024222255.GA25776@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.4-2
X-PR-Tracked-Commit-Id: 5dba51754b04a941a1064f584e7a7f607df3f9bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39a38bcba4ab6e5285b07675b0e42c96eec35e67
Message-Id: <157195650608.8812.1605642294686975929.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 22:35:06 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Oct 2019 17:22:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39a38bcba4ab6e5285b07675b0e42c96eec35e67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
