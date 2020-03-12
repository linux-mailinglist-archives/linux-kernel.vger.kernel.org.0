Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6283318395B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCLTTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 15:19:16 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:53528 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgCLTTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:19:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C1F21249F;
        Thu, 12 Mar 2020 19:19:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6261:7903:9025:10004:10848:11026:11473:11658:11914:12043:12296:12297:12438:12555:12679:12895:12986:13069:13311:13357:13894:14096:14181:14384:14394:14721:21080:21433:21627:21811:21939:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: plate17_6db8f10d3c737
X-Filterd-Recvd-Size: 2505
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 19:19:13 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] virt: vbox: Use fallthrough;
Date:   Thu, 12 Mar 2020 12:17:14 -0700
Message-Id: <68773b4cd82288b78ca6fcde8c43e249a025378a.1584040050.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1584040050.git.joe@perches.com>
References: <cover.1584040050.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

And by hand:

drivers/virt/vboxguest/vboxguest_core.c has a fallthrough comment outside
of an #ifdef block that causes gcc to emit a warning if converted in-place.

So move the new fallthrough; inside the containing #ifdef/#endif too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/virt/vboxguest/vboxguest_core.c  | 2 +-
 drivers/virt/vboxguest/vboxguest_utils.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index d823d5..b690a8 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1553,8 +1553,8 @@ int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
 #ifdef CONFIG_COMPAT
 	case VBG_IOCTL_HGCM_CALL_32(0):
 		f32bit = true;
+		fallthrough;
 #endif
-		/* Fall through */
 	case VBG_IOCTL_HGCM_CALL(0):
 		return vbg_ioctl_hgcm_call(gdev, session, f32bit, data);
 	case VBG_IOCTL_LOG(0):
diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index 50920b..739618 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -311,7 +311,7 @@ static u32 hgcm_call_linear_addr_type_to_pagelist_flags(
 	switch (type) {
 	default:
 		WARN_ON(1);
-		/* Fall through */
+		fallthrough;
 	case VMMDEV_HGCM_PARM_TYPE_LINADDR:
 	case VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL:
 		return VMMDEV_HGCM_F_PARM_DIRECTION_BOTH;
-- 
2.24.0

