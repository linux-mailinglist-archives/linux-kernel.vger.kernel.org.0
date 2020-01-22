Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305A7145D72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 22:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAVVFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 16:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVVFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:05:03 -0500
Subject: Re: [GIT PULL] hwmon fixes for v5.5-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579727103;
        bh=wmFNqsvcvqhGUmM0lVT/YB9hRrRPQNs7ulV0NOy2ZCM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CU4t4LpIn/qMw1BmoUE1ut5pyhvuzc4SlBwi42HyqvywNfO09tv+Gxl/OupOCg0zS
         CIjHq7Tk4oQGDdHUEpO3n0eFVPcSBiuVSoa85XFjhJm/80agJ/h8JVLvQM3gFQVei+
         poaCAitciTYr+Z1wQq02O55Uuk2TQZFFWWqhWGk8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200122181937.18953-1-linux@roeck-us.net>
References: <20200122181937.18953-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200122181937.18953-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.5-rc8
X-PR-Tracked-Commit-Id: 3bf8bdcf3bada771eb12b57f2a30caee69e8ab8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b4e677f86c7f730999223053534973bd0818c3c
Message-Id: <157972710315.17393.17475365828781547151.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Jan 2020 21:05:03 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Jan 2020 10:19:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b4e677f86c7f730999223053534973bd0818c3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
