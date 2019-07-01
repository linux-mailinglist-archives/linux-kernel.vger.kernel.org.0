Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4948D5C1F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfGARar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 13:30:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43908 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbfGARar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:30:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so7677761plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbjyLgOhtDSopoLbQRya8z6cDiEX3QnPAyeC6iTDsA0=;
        b=awfBR53cYYeNdAmUC6qRCyNuCBq5Gn2U5ktWi0DUNSiBQWFot1XhV5VGK4sbk/MFwU
         ky2Sa+/a0NTwiIPa3hqvnAIkkzfBsqD7ZoJzBHJSfgMx1jdZDX8fSsuRzuqN7G8putue
         XmUQwpNoeWMI32y5wZq6n5r4jpu73EXLoMtdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbjyLgOhtDSopoLbQRya8z6cDiEX3QnPAyeC6iTDsA0=;
        b=Q+rXfQMdn6W8LrQi56oa9GEmOHVSit8DNSNbnwrH8bgnXwTbK8ZcNWxXdYIdV2xGWx
         9S6QsoFxdECYaPDGx8vQxnyUnIup4Ixg965r+P3V3m7vv+LAXJTqD0LhMmNr6K7f4TzN
         u24g4NJ7YvejsNNfEJs2tS9S+u1qILF+uaATu9VGVcqdzNvWbXHxJEoy/Z930h3YHo+9
         uRTH3rWrbe6aitDEFJnHqZIbuLfK+wN3a6rWEMwPNp4ygIbnJ87I+16kQVILEjlK73Sh
         L0Fk/jlw4cdTyM5xPZYyhAbg+tlxKOocsszPJwi1d+aK1HAJRW2APcExYDVVf6iYdHE7
         PUVg==
X-Gm-Message-State: APjAAAW4QjFuKcXsYc43gqYy4Fc5BFO++SY/zEMXUck2rVEabYcKzeuW
        pHNvLdQGUw2zJ/9ofxfEzFLstA==
X-Google-Smtp-Source: APXvYqwJmfJtaeEEUAjJY21fEcsc6H+J501S5pJOv3Ogy74WItHaVtEmV14wGfUAV6Z+V1lvyGiIDw==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr3403051plo.157.1562002246821;
        Mon, 01 Jul 2019 10:30:46 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id h11sm11791289pfn.170.2019.07.01.10.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 10:30:45 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3] ALSA: hda: Fix widget_mutex incomplete protection
Date:   Mon,  1 Jul 2019 10:30:30 -0700
Message-Id: <20190701173030.168346-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The widget_mutex was introduced to serialize callers to
hda_widget_sysfs_{re}init. However, its protection of the sysfs widget array
is incomplete. For example, it is acquired around the call to
hda_widget_sysfs_reinit(), which actually creates the new array, but isn't
still acquired when codec->num_nodes and codec->start_nid is updated. So
the lock ensures one thread sets up the new array at a time, but doesn't
ensure which thread's value will end up in codec->num_nodes. If a larger
num_nodes wins but a smaller array was set up, the next call to
refresh_widgets() will touch free memory as it iterates over codec->num_nodes
that aren't there.

The widget_lock really protects both the tree as well as codec->num_nodes,
start_nid, and end_nid, so make sure it's held across that update. It should
also be held during snd_hdac_get_sub_nodes(), so that a very old read from that
function doesn't end up clobbering a later update.

Fixes: ed180abba7f1 ("ALSA: hda: Fix race between creating and refreshing sysfs entries")

Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v3:
- Moved locking back into callers (Takashi)
- Combined update_widgets exit flow (Takashi)

Changes in v2:
- Introduced widget_mutex relocation

 sound/hda/hdac_device.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 6907dbefd08c..3842f9d34b7c 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -400,27 +400,33 @@ static void setup_fg_nodes(struct hdac_device *codec)
 int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
 {
 	hda_nid_t start_nid;
-	int nums, err;
+	int nums, err = 0;
 
+	/*
+	 * Serialize against multiple threads trying to update the sysfs
+	 * widgets array.
+	 */
+	mutex_lock(&codec->widget_lock);
 	nums = snd_hdac_get_sub_nodes(codec, codec->afg, &start_nid);
 	if (!start_nid || nums <= 0 || nums >= 0xff) {
 		dev_err(&codec->dev, "cannot read sub nodes for FG 0x%02x\n",
 			codec->afg);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	if (sysfs) {
-		mutex_lock(&codec->widget_lock);
 		err = hda_widget_sysfs_reinit(codec, start_nid, nums);
-		mutex_unlock(&codec->widget_lock);
 		if (err < 0)
-			return err;
+			goto unlock;
 	}
 
 	codec->num_nodes = nums;
 	codec->start_nid = start_nid;
 	codec->end_nid = start_nid + nums;
-	return 0;
+unlock:
+	mutex_unlock(&codec->widget_lock);
+	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_refresh_widgets);
 
-- 
2.20.1

