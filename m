Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82DFD156CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 23:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBIWaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 17:30:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgBIWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:30:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so5222805wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+cR9uVxyvC6kcqjxC2C+5dqUA2dibMuqlzRwuHl68M=;
        b=lPn02R7xpd16ZZgB+2+rd/U5Q0igmHGWTMEjcE0aq00usl6ZSMPdS3SQ2aJL0d+4E9
         kr1zWCYIAOmX3IB4UVVcLi9nDM29KCMV1kXR9jZzIXsR+oyKxXN8OwF82BvvsS6ZGdFd
         GLIDCLHZiYglR0aaBYI3WPhvCObTrDQrph0/mZN5ShjfsEdz/2mAXnc5lrxGkSR51Z1S
         luuBEyzstb0Kqoi0KBstSQK/chqoOcrEJ3/pPnLTX6MHozidFaffX5d+tqtfwxegUENz
         vOM9ikwavb6hKvd/yASAIBmKU2OwgCyF2s8CnfPuGyhCYzEk+lE2pDfSDuAMA9WOWzkt
         GOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+cR9uVxyvC6kcqjxC2C+5dqUA2dibMuqlzRwuHl68M=;
        b=SpTHqpyksPUl9irpkFyFLyU45PLV77bAmKTQCpUv4lUbggRzxslu2nRasr7yGtRnjV
         6YwbBiKGU+Pb2x5bbavaDZjd3bWdHn9RA4sjcPrA5O1WZ5Rg71PcP8+IUjr94fd7n00t
         wBlMtqj6O0T7OHmHf05e6EN6T5uK+klaNQct56TnAHsNCyIoFx+g3i7tAJWprsSVrrUe
         /sKRenWu9y/qURUfH2pkXHkWO5CcNaTBEVeITZxFwX06iMsD/5S5w2OiAbuNfYSSWJ1F
         DQQvZY1k+7kqg11TBlaGNtQJ90W+ltbHFngFTIkLN9jRhFqh0cfu5UFfVwMGiIIURKeu
         cASg==
X-Gm-Message-State: APjAAAUAsPVBg4iKv9qXWHHV7pdbwBQi0iLoxkkGi4jKx5rk8YQwTXPt
        bUKCeUTP2kbskRGqu+/e5A==
X-Google-Smtp-Source: APXvYqwS5Mr9EjLivto+WZ26UPxvo2/MkpieHq9JDAHqAlrwYaRU1lk5N5iZRgw509uuB0jKA0EIKQ==
X-Received: by 2002:adf:e50f:: with SMTP id j15mr11963601wrm.356.1581287417608;
        Sun, 09 Feb 2020 14:30:17 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm12765716wmj.6.2020.02.09.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:30:17 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 03/11] futex: Add missing annotation for fixup_pi_state_owner()
Date:   Sun,  9 Feb 2020 22:30:01 +0000
Message-Id: <db720e9f421af9c221e163fdd9914983f903deba.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at fixup_pi_state_owner()

warning: context imbalance in fixup_pi_state_owner() - unexpected unlock

The root cause is a missing annotation of fixup_pi_state_owner().

Add the missing __must_hold(q->lock_ptr) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 93e7510a5b36..5263cce46c06 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2440,6 +2440,7 @@ static void unqueue_me_pi(struct futex_q *q)
 
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 				struct task_struct *argowner)
+	__must_hold(q->lock_ptr)
 {
 	struct futex_pi_state *pi_state = q->pi_state;
 	u32 uval, uninitialized_var(curval), newval;
-- 
2.24.1

