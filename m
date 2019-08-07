Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CCC83E87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 02:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfHGAuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 20:50:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34663 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfHGAuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:50:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so89640455wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5+rKbwY4FKqVWmbsGvvdEeOmqTq+9PbufWY+vIRJyY=;
        b=RFvhDhAzsEGmP3R8DL+pcMrzIbrq7k+polU6BnPglD2j6Ds3u6BvfSCwQrHN/oSbUo
         ZQWbBRIwhTDubauU1tBRlsnHba4NQW5MFP6x+0n71sG6JIBHQJ6CgdFofTEp2E//sVeZ
         2NN6sWNnuDOyl6ehYH4jFJ28qsVckaeA4MhqeNCBtmdooWzBz4xpyCmIduZtAplwogqH
         oibugB4zkY5h7pF5VSgR1yDskxbQF74yap84y6xXHY1Sd1Q7fzyVWEeLuH+v9Q3yXMJV
         W0auuFW6rZErNPQflCH6ojmh9PLMuBUEvYpGu/yt49vkEevA1XB5Ks+baotLc5FA64Yb
         ENIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5+rKbwY4FKqVWmbsGvvdEeOmqTq+9PbufWY+vIRJyY=;
        b=hg+xc++Z6oqw8c65vpb9fuKf+N4rGu1x2riFvvGceUg4Pvi44M39GaQVgS0njTx72+
         j6B/rIWE/0R/KpFdwLa4Qjm2oeCrVx21ErHkFbMgtR4MpkInSEnPWc8F6JpOznS9gC3b
         /B2OAZ+iZ9fvFQsgvWBYnNswFXgT3/PA00me6I4egiSuRf7qg9M6pRwGLF8kuOqa8OnW
         vojN0zFYEi4xLgShqNRov+Bia6sSIe8lekK/sRTgLBv71QBIF3Dh4/ztV+kKif5aimRv
         6ut+GXa3V51tKc3xDHYi1GslOD1nnYDYjNEkqQ6nk0gkb37/lmfZff2dOGkS0t/sznMn
         yDLQ==
X-Gm-Message-State: APjAAAVm7TfPlcbkR0qdOQUlbmFb9lJoUcIOb/vF3h9zZIhy4R439cWI
        Qm35vo5txw3YgV4d+c3gtrvJUg==
X-Google-Smtp-Source: APXvYqy8KQjeNNxOIH8SeUbJwgyA5CS+DhnMMoQmPDKz4PGFRVmsXJYIn35yv5oyM8mLa/a/mW6Dow==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr6854010wrn.285.1565139044280;
        Tue, 06 Aug 2019 17:50:44 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id h8sm99831846wmf.12.2019.08.06.17.50.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:50:43 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, dvander@gmail.com,
        elsk@google.com, gregkh@linuxfoundation.org, joelaf@google.com,
        kernel-team@android.com
Subject: [PATCH v2] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Wed,  7 Aug 2019 01:48:28 +0100
Message-Id: <20190807004828.28059-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <CAJWu+oo=GrZ+SbA6=bboM4==TKXBsTRWkTrkWiZ55pqhJtgQqQ@mail.gmail.com>
References: <CAJWu+oo=GrZ+SbA6=bboM4==TKXBsTRWkTrkWiZ55pqhJtgQqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling Direct I/O with loop devices helps reducing memory usage by
avoiding double caching.  32 bit applications running on 64 bits systems
are currently not able to request direct I/O because is missing from the
lo_compat_ioctl.

This patch fixes the compatibility issue mentioned above by exporting
LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
The input argument for this ioctl is a single long converted to a 1-bit
boolean, so compatibility is preserved.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alessio Balsini <balsini@android.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 44c9985f352ab..2e2193f754ab0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1753,6 +1753,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
 	case LOOP_SET_BLOCK_SIZE:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.23.0.rc1.153.gdeed80330f-goog

