Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53435131540
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 16:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgAFPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 10:50:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39569 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAFPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:50:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so36662604lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P72Y5udFHhnfLqxUCy8WtY2iwNO/ZT4H/0nL4IC4LCk=;
        b=JP0b+4c0tOcwp4Lpvmk3bZgjwoZsqNQj9Z75B2PLPp2N8D2Jps7qwivqRdI5nG2GxW
         q7tFwFtV8YHW+hRYHSU2CvwodPmG/ExNZOTf50N/rkyihNrUTjwzTG3iDL3PRYk/06xP
         vjoXq3f6PTokKo9n+OonMJVyBUcQerhfh5aMcFWcgY/qm87Qh8YsONJfEOsldins3HHq
         KE0ru5XwUATOWNpCGjxu5n95VlJncCtaveAHmz9Reu1S6zrZgaZUddXACVK0Hk4kBgcV
         MdwCECkaE6EFNlX6OubNIUNN4tgMFAljH2eiCeoUGcXP4Gcg5cI4ReN4V5hyKSErwZwD
         0CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P72Y5udFHhnfLqxUCy8WtY2iwNO/ZT4H/0nL4IC4LCk=;
        b=bvuZmhj6sxfulkbqb91YaVHOQ+Hn4UJybByAAKDWZT8/N3i0qr2FFe7473joRPsXiv
         5XwM4kW/umBt1+NTCWeW+ffIgcmhP8aQJuw4fn+ku4LY/YCBt0GIGBN5vXQNPvluH1+H
         JV0lYMh4X40lESZ97PZ2e7VVLeN6+e7jfzw+jVthwy6AHAKjE8ttukZOnSugiZZRB4Wu
         Isl7r20RvnTLms+BdnxsHIle5VqYSsxdBq55rVHETyp01d/Z2Nk5QnGD4JBhTBgRs4gq
         uOxOgqQSmuCWljb/kKdZk3EW7na9wEV/+e3ig/t+psvPRV+qF9F2Ulv/IHr6YgZBvv9Q
         PHUw==
X-Gm-Message-State: APjAAAXB4z7eF1L3Uc0QG9zB0Lf9vdh8dkVAup3ETBadcYJrgQlnAcND
        uSV6NWPBJpMdLLRTA4EhQkZd1w==
X-Google-Smtp-Source: APXvYqwJndXw9VMBnLiZOjQDx4YLHmlQ8iXyn23TbeD2f6P2p64e/eYu/B+nXSWUbPj3otLutnE33g==
X-Received: by 2002:ac2:4476:: with SMTP id y22mr57355676lfl.169.1578325809147;
        Mon, 06 Jan 2020 07:50:09 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id x84sm29388259lfa.97.2020.01.06.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:50:08 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 03/12] venus: venc: blacklist two encoder properties
Date:   Mon,  6 Jan 2020 17:49:20 +0200
Message-Id: <20200106154929.4331-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two properties are not implemented for Venus v4 (sdm845),
thus don't set them to firmware.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 4f645076abfb..c67e412f8201 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1207,6 +1207,8 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
 	case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
 	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER:
 	case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE:
+	case HFI_PROPERTY_PARAM_VENC_SESSION_QP:
+	case HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE:
 		/* not implemented on Venus 4xx */
 		return -ENOTSUPP;
 	default:
-- 
2.17.1

