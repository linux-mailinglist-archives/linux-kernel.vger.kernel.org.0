Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB8F38A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKGTcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfKGTcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:32:03 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFC52075C;
        Thu,  7 Nov 2019 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573155123;
        bh=KHBa+k7hyLQ0MV0ubF5yXoe3GPRCg6Ei4nXyQ7DcToA=;
        h=Date:From:To:cc:Subject:From;
        b=SDJyJT5EsN4cJy3QsL3vUtnb1JzCoDLR6CXru/KKIyvCu8e1LRfxGe0RCvFiucygH
         Nb2MptfJUQUTc430DxBP7IV9G1gDwXMgcmoVT4VmAFfz3f6oPB1jZQSCV6iDKSaHt1
         wYU88V9XklPD9MwP0ENMvUT5xhnO3gHw7keNzbZ8=
Date:   Thu, 7 Nov 2019 20:32:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1911072028330.1799@cbobk.fhfr.pm>
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

to receive two fixes for HID subsystem:

=====
- regression fix for i2c-hid power management, from Hans de Goede
- signed vs unsigned API fix for Wacom driver, from Jason Gerecke
=====

Thanks.

----------------------------------------------------------------
Hans de Goede (1):
      HID: i2c-hid: Send power-on command after reset

Jason Gerecke (1):
      HID: wacom: generic: Treat serial number and related fields as unsigned

 drivers/hid/i2c-hid/i2c-hid-core.c |  4 ++++
 drivers/hid/wacom.h                | 15 +++++++++++++++
 drivers/hid/wacom_wac.c            | 10 ++++++----
 3 files changed, 25 insertions(+), 4 deletions(-)

-- 
Jiri Kosina
SUSE Labs

