Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8931FF88C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 07:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfKLGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 01:51:17 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19472 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfKLGvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:51:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dca56630001>; Mon, 11 Nov 2019 22:51:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Nov 2019 22:51:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Nov 2019 22:51:15 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 06:51:15 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 06:51:15 +0000
Received: from henryl-tu10x.nvidia.com (Not Verified[10.19.109.97]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dca56610001>; Mon, 11 Nov 2019 22:51:14 -0800
From:   Henry Lin <henryl@nvidia.com>
CC:     Henry Lin <henryl@nvidia.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb-audio: not submit urb for stopped endpoint
Date:   Tue, 12 Nov 2019 14:51:06 +0800
Message-ID: <20191112065108.7766-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573541475; bh=uaQU/d9YZIhPAFnpZUJ/WgAWpgBHxUlq6+ZdUcJ/2w0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=cSKBTpCVzDDNzjJOZ7Bs2de/FsrJr/iybeyLPt0/Bhxg+ztWxOu2eFJWEeGuvpwwm
         fV4+hrOnpMfYzdYKlMi/7pkPJpxI4gCxF5/ilFNsg9a/YmEAEMXY60m7izlUcMDNlI
         mmx1Y7VQ80UPo7UHJkya+Hq+mUbp3qgHNWb8NnYP1ty3J/nFQkPYa74lBmVO7x8Oih
         bXiBR17J8WI4rRYsM5LUKi8y/2WjNljnYJPiE0QQ8aRi6cMUuJjVS98nrCPi/5mx6w
         R0HpEUVA4YpkkbB/YkI2hADJVLr59tc9jbsubxx1TG6mEA6TWYXojp0giuvFROtfO8
         3CkkHxdUNBT0w==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While output urb's snd_complete_urb() is executing, calling
prepare_outbound_urb() may cause endpoint stopped before
prepare_outbound_urb() returns and result in next urb submitted
to stopped endpoint. usb-audio driver cannot re-use it afterwards as
the urb is still hold by usb stack.

This change checks EP_FLAG_RUNNING flag after prepare_outbound_urb() again
to let snd_complete_urb() know the endpoint already stopped and does not
submit next urb.

We observed two scenario have this issue:
1. While executing snd_complete_urb() to complete an output urb, calling
   prepare_outbound_urb() let deactive_urbs() get called to unlink all
   active urbs.

[  268.097066] [<ffffffc000af7638>] deactivate_urbs+0xd4/0x108
[  268.102633] [<ffffffc000af87fc>] snd_usb_endpoint_stop+0x30/0x58
[  268.108636] [<ffffffc000b0272c>] snd_usb_substream_playback_trigger+0xa4/0xf4
[  268.115765] [<ffffffc000acdbd0>] snd_pcm_do_stop+0x4c/0x58
[  268.121245] [<ffffffc000acda24>] snd_pcm_action_single+0x40/0x88
[  268.127245] [<ffffffc000ace984>] snd_pcm_action+0x30/0xf0
[  268.132632] [<ffffffc000acea68>] snd_pcm_stop+0x24/0x2c
[  268.137851] [<ffffffc000ad5e14>] xrun+0x60/0x6c
[  268.142374] [<ffffffc000ad7a98>] snd_pcm_update_state+0xa8/0x10c
[  268.148374] [<ffffffc000ad7e24>] snd_pcm_update_hw_ptr0+0x328/0x344
[  268.154635] [<ffffffc000ad7ed8>] snd_pcm_period_elapsed+0x98/0xb0
[  268.160723] [<ffffffc000b02510>] prepare_playback_urb+0x46c/0x488
[  268.166810] [<ffffffc000af7d60>] prepare_outbound_urb+0x60/0x1d4
[  268.172805] [<ffffffc000af8d60>] snd_complete_urb+0x244/0x264
[  268.178548] [<ffffffc00081fb38>] __usb_hcd_giveback_urb+0x94/0x104
[  268.184721] [<ffffffc00081fbe4>] usb_hcd_giveback_urb+0x3c/0x114
[  268.190724] [<ffffffc00084d4b4>] handle_tx_event+0x1304/0x1434
[  268.196552] [<ffffffc00084dbc0>] xhci_handle_event+0x5dc/0x788
[  268.202378] [<ffffffc00084dee4>] xhci_irq+0x178/0x280

2. Userspace application stops playback from sound subsystem with below
   call stack:

[   28.506477] CPU: 5 PID: 1274 Comm: AudioOut_25 Not tainted 4.4.38-tegra #31
[   28.513430] Hardware name: quill (DT)
[   28.517085] Call trace:
[   28.519531] [<ffffffc000089a84>] dump_backtrace+0x0/0xf8
[   28.524837] [<ffffffc000089c44>] show_stack+0x14/0x1c
[   28.529885] [<ffffffc000401c54>] dump_stack+0xac/0xe0
[   28.534931] [<ffffffc000b35f94>] deactivate_urbs+0x148/0x180
[   28.540578] [<ffffffc000b37160>] snd_usb_endpoint_stop+0x30/0x58
[   28.546571] [<ffffffc000b410d8>] snd_usb_substream_playback_trigger+0xa4/0xf4
[   28.553699] [<ffffffc000b0c160>] snd_pcm_do_stop+0x4c/0x58
[   28.559179] [<ffffffc000b0bfb4>] snd_pcm_action_single+0x40/0x88
[   28.565178] [<ffffffc000b0cf14>] snd_pcm_action+0x30/0xf0
[   28.570568] [<ffffffc000b0fbc8>] snd_pcm_drop+0xac/0x140
[   28.575873] [<ffffffc000b0fc84>] snd_pcm_release_substream+0x28/0xb0
[   28.582212] [<ffffffc000b0fd48>] snd_pcm_release+0x3c/0x98
[   28.587686] [<ffffffc0001e3210>] __fput+0xe0/0x1ac
[   28.592469] [<ffffffc0001e3334>] ____fput+0xc/0x14
[   28.597253] [<ffffffc0000c2904>] task_work_run+0xa0/0xc0
[   28.602558] [<ffffffc0000897bc>] do_notify_resume+0x48/0x60
[   28.608123] [<ffffffc000084ee8>] work_pending+0x1c/0x20

In the call path, snd_pcm_stream spinlock has been acquired in
snd_pcm_drop(). If an output urb is completed between the spinlock
acquired and deactivate_urbs() clears EP_FLAG_RUNNING for the endpoint,
its executing of snd_complete_urb() will be blocked for acquiring
snd_pcm_stream spinlock in snd_pcm_period_elapsed() until the lock is
released in snd_pcm_drop(). When snd_complete_urb() continues, all jobs
for deactivate_urbs() are finished.

Signed-off-by: Henry Lin <henryl@nvidia.com>
---
 sound/usb/endpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a2ab8e8d3a93..4a9a2f6ef5a4 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -388,6 +388,9 @@ static void snd_complete_urb(struct urb *urb)
 		}
 
 		prepare_outbound_urb(ep, ctx);
+		/* can be stopped during prepare callback */
+		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
+			goto exit_clear;
 	} else {
 		retire_inbound_urb(ep, ctx);
 		/* can be stopped during retire callback */
-- 
2.17.1

