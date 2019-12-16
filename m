Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07D611FC25
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 01:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfLPAYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 19:24:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33851 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfLPAYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 19:24:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id f4so3802407wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 16:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ygwsDNhmKVfGJs/MinYk9AFY4MjB2fx/AFZvzMWfp8=;
        b=LoQmFNUCgZ0zhhXilUbsKTpRrKQdc/E0XvpkZwcpkiZ9YA5T/l9rQt6AHdrb1RYsxn
         9Y0GO+kfO8dtJtp75sHjED8RtO+N32Ly1gock6TDhsiUhnQP73IlQCjj58iC+RP1HBLV
         JGLsqvBWY++cbJWD4HRyfFQdTwr/WcAc7MZhWQ7rsDMvajW4MPnlM4vHUOcm0NRFK5lb
         MuLAiez7h3qy5GhxYDu7CbjILtY6pAuHb94qDWiPTEr8hG3ADLgjeW4nslML6JXwH76J
         tItXOB2Vg335U1W1RrdIy0dZqa2wO71BDgqhSAxjzdkehQAd5e5FuMqwH6JEnp/sckd5
         vbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ygwsDNhmKVfGJs/MinYk9AFY4MjB2fx/AFZvzMWfp8=;
        b=sBjinVyNuIeTvSCwi1kM3MtqIADWA5Hjwrvm5IeIvucNOWWM/gU4NEAp8pPJH4wv59
         iAiGjt6FYp8abXShEkEasGmbI8SXma/y34rVMCY9PBVtWCjqP2uOHWAMcqQw/eMz3HCN
         1P0Ih3rfMMXp8ukEPJ1fhwd4SAAKkKOIGS+7dheMBT3TkgSX8nyBoSlogj2b0cA1NHDV
         HQdU3m74wJ6XzxuVJsau8SA9DN7gN3cC5efGph1tj6FH236KuAB0qG7jRYVeRZyzqoS2
         i+fPovEYzDs6eT125/b8Oj0U4MRINDd9xUXbIiq85idwjvdsHY8IZzCnI60gaiN8MpoZ
         neEA==
X-Gm-Message-State: APjAAAVOpnFtVN2MdXiJfNl2D5PGiElDbXLyWbM0bKtCVdjXP+5ZBtXm
        1kEHQPNFxBn9NejGCCoSdw==
X-Google-Smtp-Source: APXvYqyCjM/SUQtI8w5C26g931jLlZzpDVrQ7Vgtqh1z6PhWKuIhaeY3rBdQqYr4NpSyXxOeMaTywQ==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr27646492wmm.143.1576455854611;
        Sun, 15 Dec 2019 16:24:14 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-53.as43234.net. [92.15.174.53])
        by smtp.googlemail.com with ESMTPSA id e16sm19214555wrs.73.2019.12.15.16.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 16:24:14 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     bokun.feng@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] kernel: events: add releases() notation
Date:   Mon, 16 Dec 2019 00:24:00 +0000
Message-Id: <20191216002400.89985-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add releases() notation to remove issue detected by sparse
context imbalance in perf_output_end() - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/events/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 7ffd5c763f93..c8ad63f9faa5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -295,6 +295,7 @@ unsigned int perf_output_skip(struct perf_output_handle *handle,
 }
 
 void perf_output_end(struct perf_output_handle *handle)
+	__releases()
 {
 	perf_output_put_handle(handle);
 	rcu_read_unlock();
-- 
2.23.0

