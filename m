Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751A2AB78E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbfIFL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 07:56:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38251 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404296AbfIFLz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:55:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id d10so3378492pgo.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 04:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0xZnwvqrMb6ldOj+rJWYs9r2G218dDOkg+hug4AnqA=;
        b=gLYNOAhGFrZSLpPOwi/adRGDzZxevZp8l1+MggAdRf+GhloCsbcBldsllG04vfEQ5Q
         e3thTHGGQfil99wc0YZ5UsqSNh442lu3kiFdZ7SM0r+YCESy+jfzLjt0WumgScEWvr7p
         SNX6pDxHHDZhE/l7YzR8U864CeKlVREq3rMzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0xZnwvqrMb6ldOj+rJWYs9r2G218dDOkg+hug4AnqA=;
        b=huOYa0T7KM6JQ/tVodCoYTnArRrToqHTsCOrHDOhec5BGX+fzW/Xa8agEUZnfxxqge
         vqxasSTaOjo/ctfOZA8FjDIFnZL7R6DsNl0x9eXXzBqENo1aoIx7mA32wEWvRH0nhTD8
         HnLycWFHf01Q57GEUPW9QxkMElYVx5EMWiwEuqL+QAjmcMOrjXwqGzsQNDZ0XfqgBK5P
         OL0VQgrdpiC4Jqp22auzNvb99Zl2bK7A9k3WqoGcUnCEm5DA+1WUaKyJ1IZQplMuqOu4
         g0WGuaNl0MjxHdthm8ed4w8CO1b+JlG1YfgPJSj8y+i6UhT3WYowNRJ3R4CbBYaElBXB
         6aSg==
X-Gm-Message-State: APjAAAXuwzeRGuxqNWprQQiustIDFEnGT7U7woiXuF5JEmiuVTGuZ623
        imSMAZirc1yt2qsAzcbKMO8Xmw==
X-Google-Smtp-Source: APXvYqx5WhsXkvJ3BjBJ1D6yszHS/6Iq4oTXUP8qX5zioVUs3GbhIlU2rVJbHdqrkKNPSmEZQmBIAw==
X-Received: by 2002:a63:6686:: with SMTP id a128mr7450171pgc.361.1567770955316;
        Fri, 06 Sep 2019 04:55:55 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id o22sm3667394pjq.21.2019.09.06.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 04:55:54 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFC PATCH v2 09/13] media: doc: Add documentation for MM21 video format
Date:   Fri,  6 Sep 2019 20:55:09 +0900
Message-Id: <20190906115513.159705-10-acourbot@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906115513.159705-1-acourbot@chromium.org>
References: <20190906115513.159705-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation for the MM21 video format, used by the MT8183
codec and MDP3 image processor.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/media/uapi/v4l/pixfmt-reserved.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-reserved.rst b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
index b2cd155e691b..10d5bda9ffc7 100644
--- a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
@@ -264,6 +264,16 @@ please make a proposal on the linux-media mailing list.
 	of tiles, resulting in 32-aligned resolutions for the luminance plane
 	and 16-aligned resolutions for the chrominance plane (with 2x2
 	subsampling).
+    * .. _V4L2-PIX-FMT-MM21:
+
+      - ``V4L2_PIX_FMT_MM21``
+      - 'MM21'
+      - Non-compressed two-planar block format used by Mediatek MT8183.
+	The compression is lossless.
+	It is an opaque intermediate format and the MDP3 hardware must be
+	used to convert ``V4L2_PIX_FMT_MM21`` to a non-proprietary video
+	format.
+
 
 .. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
 
-- 
2.23.0.187.g17f5b7556c-goog

