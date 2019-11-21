Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8870310510E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKULG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:06:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40792 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKULG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:06:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id 4so530824wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 03:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljgj1xBlmM+fK+Y7fLIkJkb9AcnZl/Iz6MDt7yS8lHs=;
        b=M3Ixx7GOLmOHI/ZOcnBvPkpZbDz64yJzUuEk+gnpcVJSRKKF0ZT+xATB8qsP5hzTFV
         YqQ3lW+mQVoZRNIbEQxcLHZLW6T/atRm4BBh4rTxdoV3L1AE8TQVPMNp7szbeJY5eJsq
         +g5E7fPjbqhUUNiyDJN94NtvLSvnlCCecKPyjVZEd/3Ad+R4Kh8hfOVjFCoXhgZUeEGQ
         ++Dj7w0Am4a/IcMtnyCIfDobFiY0VJg8I6wKuY0YhxRFMVNwGsHWtBIlV33xeqiPXF2j
         P8i6qRHGXFp5pEXmChZW/fBRqfGcleRS03ZDaRZMkVcE03hAA/z53333c9IcmizvqGbG
         q2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljgj1xBlmM+fK+Y7fLIkJkb9AcnZl/Iz6MDt7yS8lHs=;
        b=gelhBTroT3F4UR0P4jvfS3Y0TbJ/7+59WcsU2/wYlTJVv3ZCBNmkeRolHlIEjZDguN
         A+GB+QdR5URzZS+DdT3bwP7TsZ9QH2YtHhDN7qjoPYEB2bpG8SrM2ZiczUpaw9d902Nd
         ESkDo45cc+xTpj+I57KRx3y+o3zyDpjcs+WiPIvaoK9L1Dmt8mApFpQ+TZ+d54yYsD+7
         12pA1ANqNvnjHp4rQ/Pl5cmM+p4ra+puLf07AHg/cz03DpCN7iiou1jpTmUEshjMLwQE
         VS/+OHhpPIgDp32GOwvZGKAA8tOvmRVmNIQl7cO2XLAzFWzzJLFR0350m3AKOTTvqCkg
         qjCw==
X-Gm-Message-State: APjAAAWkeI7H+CVY0956+TKNj7FwwRCZo5HxgltfjBorkbhxymEwBbE2
        taBEMHkc4cKP6RyPj4ppFZ+uTg==
X-Google-Smtp-Source: APXvYqyfowC60J9HexHKh65Jj0TsFNXovztkKoBf2uUSJT/8LOcFJFgstWnJjyny0i5QCKMyp/1Sig==
X-Received: by 2002:adf:e449:: with SMTP id t9mr10075992wrm.196.1574334415422;
        Thu, 21 Nov 2019 03:06:55 -0800 (PST)
Received: from localhost.localdomain ([79.140.122.151])
        by smtp.gmail.com with ESMTPSA id 13sm2427358wmk.1.2019.11.21.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 03:06:54 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     mtk.manpages@gmail.com
Cc:     adrian@lisas.de, akpm@linux-foundation.org, arnd@arndb.de,
        avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: [PATCH] clone.2: Fix typo
Date:   Thu, 21 Nov 2019 12:06:46 +0100
Message-Id: <20191121110646.1398-1-christian@brauner.io>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

This surely meant to say clone3() and not clone(3).

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/clone.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/clone.2 b/man2/clone.2
index 382f6b791..e5ab2a096 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -252,7 +252,7 @@ argument supplied to
 lb lb lb
 l l l
 li li l.
-clone()	clone(3)	Notes
+clone()	clone3()	Notes
 	\fIcl_args\fP field
 flags & ~0xff	flags	For most flags; details below
 parent_tid	pidfd	See CLONE_PIDFD

base-commit: be479fdf027a3288e88d53dbe05ba76bf202776e
-- 
2.24.0

