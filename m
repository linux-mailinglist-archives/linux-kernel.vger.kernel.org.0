Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75592C8F56
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfJBRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 13:04:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35637 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfJBRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so7752390wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5173HAo8p1LhYV3fg4+aqN0iEH53Ly0slEkdev9Cjg=;
        b=ff5iuJGqQwK7W8NVggxafmcrET7AQ8KvAtXc439Vhn0YvaoKt3O9eY1Fwk4QhOXb3y
         b/+lntD2LNGbaNUSQGbZ+9adA2U/h6YUtnqyL3Wl1f5WwwwxSKvZajfn+d+vk6El/F1D
         B72GlPDKrkfRtJiSH3sKLpJtSzqtM+LOfa8qHZh0wjRAV4UM46VEOVYyBsci5IgRA46a
         CzstOvEmTXTz8s1hYmNAg+q72lzi62qJjkXoFM59AOpPKif5nn+FfDTXkLuD4e/SzQeA
         bC19QNkNg3SKzzusUKZwIEu+ws0mJh5XGPzVbDj62+Tb/FrNrgvRLxEVFF7gSUJBuZ1c
         cX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5173HAo8p1LhYV3fg4+aqN0iEH53Ly0slEkdev9Cjg=;
        b=SRPyubbfg4seVEStQNa3U6I6qfLID5ivopvEv1dTcmNB+5zKV/9cR/hmDCsOf3+JlF
         B+QPnMdlubZ5SbyXJzR9LB7f5b2Kdr+WYUb0UWm03xIfFUN5q0kxWeKOwQbqA1uemTk9
         4WboumWqABc766iKsnO8D9DM6ZCNaB5MwFKUAbAHMgNmQhjiLvgT5WdGdSsRxy5zTRhU
         ePdE7eDLEIgiLJPoQ2Bg3eBi5rgcIjMa+h8VRdtd8vZ+pAoiwbWSWWO2xrTZcy2A5yfw
         10eBQZqCr7oIrLaDVrjx+GCZaOM4m2Pblpaf7lHckSR2qhd8a2TmeKvOAbFt0GWPgqeK
         7Tgg==
X-Gm-Message-State: APjAAAUeQgRJlcZBv3Kdq+SS6KbSRevLctjC5XjLR9DnMZLxqIWJfOm3
        KyQE/PrK5xYkzXP0yfrFWJ0vVQ==
X-Google-Smtp-Source: APXvYqzRU9v5iB8bXQCVIqJYRqFON6vt7RbKcCaKUjNl+xnm8AnxImyNX9t1t04BarMYjjZn5E5Apw==
X-Received: by 2002:a1c:3bd6:: with SMTP id i205mr3561886wma.135.1570035833039;
        Wed, 02 Oct 2019 10:03:53 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:52 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 3/7] efi/tpm: Don't access event->count when it isn't mapped.
Date:   Wed,  2 Oct 2019 18:59:00 +0200
Message-Id: <20191002165904.8819-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Jones <pjones@redhat.com>

Some machines generate a lot of event log entries.  When we're
iterating over them, the code removes the old mapping and adds a
new one, so once we cross the page boundary we're unmapping the page
with the count on it.  Hilarity ensues.

This patch keeps the info from the header in local variables so we don't
need to access that page again or keep track of if it's mapped.

Fixes: 44038bc514a2 ("tpm: Abstract crypto agile event size calculations")
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Peter Jones <pjones@redhat.com>
Tested-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/tpm_eventlog.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 63238c84dc0b..12584b69a3f3 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -170,6 +170,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	u16 halg;
 	int i;
 	int j;
+	u32 count, event_type;
 
 	marker = event;
 	marker_start = marker;
@@ -190,16 +191,22 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	}
 
 	event = (struct tcg_pcr_event2_head *)mapping;
+	/*
+	 * the loop below will unmap these fields if the log is larger than
+	 * one page, so save them here for reference.
+	 */
+	count = READ_ONCE(event->count);
+	event_type = READ_ONCE(event->event_type);
 
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs) {
+	if (count > efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
 
-	for (i = 0; i < event->count; i++) {
+	for (i = 0; i < count; i++) {
 		halg_size = sizeof(event->digests[i].alg_id);
 
 		/* Map the digest's algorithm identifier */
@@ -256,8 +263,9 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 		+ event_field->event_size;
 	size = marker - marker_start;
 
-	if ((event->event_type == 0) && (event_field->event_size == 0))
+	if (event_type == 0 && event_field->event_size == 0)
 		size = 0;
+
 out:
 	if (do_mapping)
 		TPM_MEMUNMAP(mapping, mapping_size);
-- 
2.20.1

