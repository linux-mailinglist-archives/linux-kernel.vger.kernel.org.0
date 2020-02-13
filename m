Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26A915BD92
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 12:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgBMLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 06:21:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgBMLVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:21:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70159B18D;
        Thu, 13 Feb 2020 11:21:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ALSA: usb-audio: UAC2 effect unit parsing
Date:   Thu, 13 Feb 2020 12:20:57 +0100
Message-Id: <20200213112059.18745-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

UAC2 Effect Unit needs different parsing from Processing Unit and co,
and this patch set implements the partial support for that.

As it's the fix on top of the latest USB-audio fix, I'd like to apply
through sound git tree.  So please review and ack if USB header change
is OK.


thanks,

Takashi

===

Takashi Iwai (2):
  usb: audio-v2: Add uac2_effect_unit_descriptor definition
  ALSA: usb-audio: Parse source ID of UAC2 effect unit

 include/linux/usb/audio-v2.h | 12 ++++++++++++
 sound/usb/mixer.c            |  6 ++++++
 2 files changed, 18 insertions(+)

-- 
2.16.4

