Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C316418860E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCQNlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgCQNll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:41:41 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97D520770;
        Tue, 17 Mar 2020 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584452500;
        bh=ic3ydP+IoXQ7wu6a/bT76r5LXmDNJV03lwMeUEMds2w=;
        h=Date:From:To:cc:Subject:From;
        b=HU0FQR9AO15rGEFYhUhMu8vDCsT+oxXRhbuX5b+3DztHfer3ew3GV10IQSHRwvz/k
         qtL+uFjzDPZNdDy4J/kHGgdltQTcZiClfv/wtymFBC93K33DZVlpcP68N0V+kGoaWJ
         qVpbi8MPxNMndxb1GO3di+2KXvEInC0z9/yF1spQ=
Date:   Tue, 17 Mar 2020 14:41:37 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2003171439360.19500@cbobk.fhfr.pm>
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

to receive HID subsystem fixes.

=====
- string buffer formatting fixes in picolcd and sensor drivers, from 
  Takashi Iwai
- two new device IDs from Chen-Tsung Hsieh and Tony Fischetti
=====

Thanks.

----------------------------------------------------------------
Chen-Tsung Hsieh (1):
      HID: google: add moonball USB id

Takashi Iwai (2):
      HID: hid-picolcd_fb: Use scnprintf() for avoiding potential buffer overflow
      HID: hid-sensor-custom: Use scnprintf() for avoiding potential buffer overflow

Tony Fischetti (1):
      HID: add ALWAYS_POLL quirk to lenovo pixart mouse

 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 2 ++
 drivers/hid/hid-picolcd_fb.c    | 4 ++--
 drivers/hid/hid-quirks.c        | 1 +
 drivers/hid/hid-sensor-custom.c | 6 +++---
 5 files changed, 10 insertions(+), 5 deletions(-)

-- 
Jiri Kosina
SUSE Labs

