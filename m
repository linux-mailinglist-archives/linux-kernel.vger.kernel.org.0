Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312ECD8CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbfJPJwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:52:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41830 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfJPJwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:52:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so14370036pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWF8mjNiT97Y4Yu34Asbv40t0M1Iiy1fzG350OTTfxo=;
        b=OyRfN2AjU/zwDJtW2CPORsAfs4PwytUhC1ypdFgrGTCPuc9R0BBosbQYcKeQygIPKr
         McZ+W/bCqe+m0bPl9mQgFre61jTN5Q1sn4X45qbx3++tLN5BT+XkQgBAIAPNMLXDVPbX
         KmGPXIXdxE11LT3plJ2aMbVA7eU+XFKFeg3JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWF8mjNiT97Y4Yu34Asbv40t0M1Iiy1fzG350OTTfxo=;
        b=LZKquFnQ90uW9bxRPH7TVJv0ZT0G/Y+IaZnDd7qcBwKdf8B+Nr4WcPx2EtLQ9k1lCD
         lpNoYr2UBEsVhLsWf2NtNvTIGZeuFaTPe9ArClojyra6BRL7gzfSMIQhLbnM86af5OA8
         0rJGEIEjs6qrh1DMD5Er5/SWJjjKYk8DkOa2d+Sr+VhdKuHtn8NSVRLRA48IXMgYYJow
         v497Yp6Ukcb+Ub9VuXAmFEyXP9T/eDql44RZiH9i/qucqBw6XSg1i/yeZVAHyoQYXZNZ
         GVm2XlFBGifpRQQDoLRSdiI3ogLykGp4Q1jFX/PQ9nUa6yR6KqMzBg9hkJj7VsZjeLde
         1++g==
X-Gm-Message-State: APjAAAWLkwCfUWsjKzX4jSu83jO2jKXqr+vqh+xqdWRcV+cR7L6GbKdH
        5gClGjrVdcmNOckKUohGrg6lcg==
X-Google-Smtp-Source: APXvYqzMYt1/QR51QpPbDB/T2Np2kF1ttwoTTGshOFnZ92nrBInOM49017vQwrwHKqikCFhoRTKq+g==
X-Received: by 2002:a62:3441:: with SMTP id b62mr42023107pfa.12.1571219570728;
        Wed, 16 Oct 2019 02:52:50 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id g20sm24199694pfo.73.2019.10.16.02.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 02:52:49 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH] media: Documentation: v4l: fix section depth
Date:   Wed, 16 Oct 2019 18:52:39 +0900
Message-Id: <20191016095239.132921-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The request API documentation introduced a new section which should have
been a subsection. Fix this.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 Documentation/media/uapi/mediactl/request-api.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/mediactl/request-api.rst b/Documentation/media/uapi/mediactl/request-api.rst
index a74c82d95609..01abe8103bdd 100644
--- a/Documentation/media/uapi/mediactl/request-api.rst
+++ b/Documentation/media/uapi/mediactl/request-api.rst
@@ -53,8 +53,8 @@ with different configurations in advance, knowing that the configuration will be
 applied when needed to get the expected result. Configuration values at the time
 of request completion are also available for reading.
 
-Usage
-=====
+General Usage
+-------------
 
 The Request API extends the Media Controller API and cooperates with
 subsystem-specific APIs to support request usage. At the Media Controller
-- 
2.23.0

