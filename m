Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09221137886
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgAJVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgAJVcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:32:31 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869B92082E;
        Fri, 10 Jan 2020 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578691950;
        bh=x7ehtRUt6vDp/rZ2bCs9Z7prWxJZUh/0btn3hnEns9E=;
        h=Date:From:To:cc:Subject:From;
        b=Et77zTJIe9B9c+l0Rj7M4nW5BGpg9rUVDxbE4WXo1OsMfFUK3dspFpJg1jBelK9Ab
         +q4UoOY0srwci7pE39sb6OlEvt11K8gtDx54p3bIspgZSZ4MhReTfUxWbRnksC2xOF
         B55ggwbL8b0i7utBokeLKmF8H+9pxVUaawbHOkBs=
Date:   Fri, 10 Jan 2020 22:32:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fix
Message-ID: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive regression fix for EPOLLOUT handling in hidraw and uhid.

Thanks.

----------------------------------------------------------------
Jiri Kosina (1):
      HID: hidraw, uhid: Always report EPOLLOUT

 drivers/hid/hidraw.c | 7 ++++---
 drivers/hid/uhid.c   | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
Jiri Kosina
SUSE Labs

