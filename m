Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7786518E652
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 04:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgCVDo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 23:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgCVDo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 23:44:28 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D9C206F9;
        Sun, 22 Mar 2020 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584848668;
        bh=PdGUyDr5TNiAHER+Gc7L/PkOPiHYfEpX9aUbK6v+tag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiPOSp6N0Bcq1WSJJK+EAhU3wTCEcSQUmP/2S2NSc0rUb8LUzjkaM4md3IE3ZFtGP
         Z+/+XyAgPICM9sWDDmIa/Hv28n03/b8fXM+pmduMlHff8oH02gw9VXcNpJf9RPi7vC
         /gq7vNobay9YJf3JSYG4H3lpVCtu8hS/t/2I8Xao=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v3 0/2] vt: fix some vt_ioctl races
Date:   Sat, 21 Mar 2020 20:43:03 -0700
Message-Id: <20200322034305.210082-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320193424.GM851@sol.localdomain>
References: <20200320193424.GM851@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix VT_DISALLOCATE freeing an in-use virtual console, and fix a
use-after-free in vt_in_use().

Changed since v2:
    - Implemented tty_port_operations::destruct().
    - Added comments regarding vt_in_use() locking.

Changed since v1:
    - Made the vc_data be freed via tty_port refcounting.
    - Added patch to fix a use-after-free in vt_in_use().

Eric Biggers (2):
  vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console
  vt: vt_ioctl: fix use-after-free in vt_in_use()

 drivers/tty/vt/vt.c       | 23 ++++++++++++++++++++++-
 drivers/tty/vt/vt_ioctl.c | 28 ++++++++++++++++------------
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.25.2

