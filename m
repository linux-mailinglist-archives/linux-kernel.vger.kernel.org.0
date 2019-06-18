Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0533B4ABE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfFRUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 16:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730176AbfFRUeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FCE0ABE3;
        Tue, 18 Jun 2019 20:34:36 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/3] Automatically choose a bigger font for high resolution screens
Date:   Tue, 18 Jun 2019 22:34:22 +0200
Message-Id: <20190618203425.10723-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is an RFC patch for automatically selecting a bigger font for
high resolution monitors if available.  Although we recently got a
16x32 sized font support in the kernel, using it still requires some
extra kernel option.  This patch reduces this and the kernel will pick
up a bigger font.

The logic is simply checking the text screen size.  If it's over a
threshold, the penalty is given to the function that chooses the
default font.

The threshold was chosen so that the normal display up to Full HD
won't be affected.

There are two preliminary patches and they are merely cleanups.  They
can be applied no matter whether to take the last patch or not.


thanks,

Takashi

===

Takashi Iwai (3):
  fonts: Fix coding style
  fonts: Use BUILD_BUG_ON() for checking empty font table
  fonts: Prefer a bigger font for high resolution screens

 lib/fonts/fonts.c | 103 ++++++++++++++++++++++++------------------------------
 1 file changed, 46 insertions(+), 57 deletions(-)

-- 
2.16.4

