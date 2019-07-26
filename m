Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4999376C50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfGZPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 11:05:33 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:58088 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfGZPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:05:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 95EAB18AFA;
        Fri, 26 Jul 2019 17:05:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f04B5gwHognF; Fri, 26 Jul 2019 17:05:31 +0200 (CEST)
Received: from function (dhcp-13-113.lip.ens-lyon.fr [140.77.13.113])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id DFBD318AF8;
        Fri, 26 Jul 2019 17:05:30 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1hr1mk-0001Vd-Gv; Fri, 26 Jul 2019 17:05:30 +0200
Date:   Fri, 26 Jul 2019 17:05:30 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        931507@bugs.debian.org
Subject: hda: Fix 1-minute detection delay when i915 module is not available
Message-ID: <20190726150530.cibwiaohhexl5jdc@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        931507@bugs.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distribution installation images such as Debian include different sets
of modules which can be downloaded dynamically.  Such images may notably
include the hda sound modules but not the i915 DRM module, even if the
latter was enabled at build time, as reported on
https://bugs.debian.org/931507

In such a case hdac_i915 would be linked in and try to load the i915
module, fail since it is not there, but still wait for a whole minute
before giving up binding with it.

This fixes such as case by only waiting for the binding if the module
was properly loaded (or module support is disabled, in which case i915
is already compiled-in anyway).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 sound/hda/hdac_i915.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -143,10 +143,14 @@ int snd_hdac_i915_init(struct hdac_bus *
 	if (!acomp)
 		return -ENODEV;
 	if (!acomp->ops) {
-		request_module("i915");
-		/* 60s timeout */
-		wait_for_completion_timeout(&bind_complete,
-					    msecs_to_jiffies(60 * 1000));
+#ifdef CONFIG_MODULES
+		if (request_module("i915") == 0)
+#endif
+		{
+			/* 60s timeout */
+			wait_for_completion_timeout(&bind_complete,
+						   msecs_to_jiffies(60 * 1000));
+		}
 	}
 	if (!acomp->ops) {
 		dev_info(bus->dev, "couldn't bind with audio component\n");
