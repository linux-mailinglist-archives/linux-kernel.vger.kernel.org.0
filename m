Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291DC1769A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCCA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 19:56:58 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54886 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCA45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 19:56:57 -0500
Received: by mail-qt1-f201.google.com with SMTP id z19so1106182qts.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 16:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SULigJR1aTK5nhD4DW5vzLxOpw0a6L5bA6kmDOAsplI=;
        b=injIeMqMZawiZtbu21dhSltYB0O5rhrqzMybRcK8b6oGBM9+5KYW9+Pl3/HksCicAq
         OafNYFAgvdHTQplSo4Hp8ANg3N3TnxSepZ54fa5l0i/mschehgdcxT32ZDTK5G8pL46p
         R2fG29+YkvYSf/WxXFXj7ZFGZPzTpE1VuEoUjM4UPBbc7BDfVNrItSzqZALf+0+TMld0
         Za4C9Tox8rorBeZDuVqisBvsBiEx99FiywWEEZoJB7a7KLuc2S8e5oBpx4FXcSoL2ocZ
         D01RX3pR/6WmvIyhmsah2gKKY+H2I93ABHs/nNJK5Gs+drLBYD0e0nWK3+YgpLL5sRbH
         Ghtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SULigJR1aTK5nhD4DW5vzLxOpw0a6L5bA6kmDOAsplI=;
        b=DI3iOeZ9HL/iK+bvocZc8eQtSCGLjZvftg1hS4oIq9vMZ7XRygsYb+1UKoezwrbPR8
         hpY2S8M0pKTWLwNo9VYISy7Dvbg8ZHtf13fumeJjcRlKy19sZc5n0IWgzrrjSJZNL3Pb
         poW9JofLxUPWewPcYJy4rntKNmPgELmKVKh99dTTFrMSEuPiwmkj0u/3fqk/SqtZR0ru
         utfv/roUGvvS6Xz4E1TrF70jyAUMsyyenlBX8KDe+5lLJTAOwnfb4qn2xqBRsByHtEt3
         rTuKgRpmQB4NsNR1JNl5by97IE9hd2/hWQfm9i4xcE8dYRqVCh0nFv9eyzQNCOegvys5
         YbJQ==
X-Gm-Message-State: ANhLgQ11Azj5ocXRcQLgBuE8tiMCBbTvu0tusnKRTT1olpxXN4ErjDJd
        yPEKTeVIZx8sablcRRl8FZzrFKbZ5x+5
X-Google-Smtp-Source: ADFU+vvXjBgQ/YGbN50roM6YKMJ/M+jQtstx9IRDHO2a0UEkj4Q3JoN3kO4kxSzTHaSfEs4ikepPnM3qRL+n
X-Received: by 2002:a0c:ef05:: with SMTP id t5mr2014421qvr.240.1583197015091;
 Mon, 02 Mar 2020 16:56:55 -0800 (PST)
Date:   Mon,  2 Mar 2020 16:56:45 -0800
In-Reply-To: <20200303005645.237763-1-rajatja@google.com>
Message-Id: <20200303005645.237763-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200303005645.237763-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 2/2] Input: Allocate keycode for SNIP key
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New chromeos keyboards have a "snip" key that is basically a selective
screenshot (allows a user to select an area of screen to be copied).
Allocate a keyvode for it.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 include/uapi/linux/input-event-codes.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index e12a19dc30262..51f419657d044 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -656,6 +656,9 @@
 #define KEY_KBD_BKLIGHT_UP              0x280
 #define KEY_KBD_BKLIGHT_DOWN            0x281
 
+/* Selective Screenshot */
+#define KEY_SNIP                        0x282
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these keys
  * are intended to be programmed / bound to macros by the user. For most
-- 
2.25.0.265.gbab2e86ba0-goog

