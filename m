Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F3148B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbgAXP4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:56:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50696 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389209AbgAXP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:56:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2117000wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V49eDPK1RxI7emBI+6HyeraP6a4Pl1g4ihe19+WEXsY=;
        b=f5s52TMqkN1hbJ3m5ijqyd1gugwRwZpdSNUp1MQSSmlD8acxtb8qMPMqY+YlkeZbRe
         rqIiRm+1Ir+uDuyTpH03cKGdd0/IOmev1vdc8WzOY+NXUHUk64po6g7kBQM+P+/5jx5n
         t9TJcXt/1N1buCmKdGcx3wDMxosIQbuobG7Qa94dLuaBLkCNRePhNzbt+QXiWlVvCE++
         yIZib1d7pLRcX+LoRtLoqAEJyDTzK3mBLzUR6asIZ6NxZYwlqK51ANAYOlQnYoHD35s6
         jVXqktOIgMSmu0UY4PfLbRjE7AfCZALcdJg+g0K8SbQgS7ikMPSUAXOPg7tBAqg1qrYv
         /yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V49eDPK1RxI7emBI+6HyeraP6a4Pl1g4ihe19+WEXsY=;
        b=E1P6iBh7SZlraTQDzGqkPSVcsuQuEDtOW4ukDA4ggJYSzZ4QvSQTr3zbE5M4o1jtRg
         +UPzsRTtrMdgI304dtYvzEgLUvhQN/Wam2YWflKpyq06UB9Ps1RcNOuyM/7u7uADq37h
         dHXNJthMYJ39S4dprlGELriJZm3JHlf59kuHrrg7sZ4fyPac6znC7mWIartTZ8aapZzj
         R20qJ7diSdwYHn7WocPjGK2NxJFpLXhJBCJpQnlBYVGYoexueIkwZz/pDDyRHxG9DpqS
         7nfHW2Y26zvkXoxq4vBkH5BSZaxNw1pJYM0CmcNB3DjFy5ARJIVArVgYggeoSisgP+A/
         Z2IQ==
X-Gm-Message-State: APjAAAVbJx1OudruT5YGW7zsZJRd+y5FVRCS/sdg9Z2SuCbyJUtdRtC0
        pJz7SprfNqwBWCArGMV+EE4G7A==
X-Google-Smtp-Source: APXvYqx+CLEXqR1mcb4MPoapn3ds/D4SG19ISlv2DzH7K9vKhU+RbFsjo7t3xTGQRetT6MTAJtYeSA==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr1938216wme.64.1579881393333;
        Fri, 24 Jan 2020 07:56:33 -0800 (PST)
Received: from mjourdan-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i204sm6121979wma.44.2020.01.24.07.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 07:56:32 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: meson: vdec: don't resume instantly if not streaming capture
Date:   Fri, 24 Jan 2020 16:56:31 +0100
Message-Id: <20200124155631.7063-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case userspace configured the capture queue before the source change
event, do not resume decoding instantly if it wasn't streamed on yet.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---

Note: this patch is based off Neil's series:
[v4,0/4] media: meson: vdec: Add compliant H264 support

 drivers/staging/media/meson/vdec/vdec_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index ff4333074197..a4970ec1bf2e 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -417,7 +417,8 @@ void amvdec_src_change(struct amvdec_session *sess, u32 width,
 	 * Check if the capture queue is already configured well for our
 	 * usecase. If so, keep decoding with it and do not send the event
 	 */
-	if (sess->width == width &&
+	if (sess->streamon_cap &&
+	    sess->width == width &&
 	    sess->height == height &&
 	    dpb_size <= sess->num_dst_bufs) {
 		sess->fmt_out->codec_ops->resume(sess);
--
2.20.1
