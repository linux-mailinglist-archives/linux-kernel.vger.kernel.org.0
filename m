Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B97337EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFCSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 14:34:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44867 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfFCSeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so2276358pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yT42r3h0cAw/2mpRzLZAzdkYnaKrCVtoe9m/CkNDjI=;
        b=luThx1kXsf4yDgGgnPNd2OH8HzsCff6ZKCEi+2VCHrJ75re5/gzXXHR9iqMrlk9zc1
         syVFTNJw4a6mb1UbFwCOJfq9ojOWzOyDtXQbqDG03auwMlQqIqZTYsXlrPq+WshXxsCb
         eB0Z/bSYyuBnzsUHnAPYN7ieIK2jRttxDmhLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yT42r3h0cAw/2mpRzLZAzdkYnaKrCVtoe9m/CkNDjI=;
        b=A2REYq/ITrDZ0QKhbg1QfA10OfwSSTkrM7LStntAQrpjmVeuqKCEdk2nkBAg7hx80L
         k525j8HmV6ndfwGSnkpopZEPOLQTdoCAmytBp+hfLrfRCr6rrq/9mjgh+olnSCtQUTov
         8OvqR7twNYubTAdpv/rX8YQDkfnV3cWv6jBvk9piWcABX864FMtpFiSbboJWfdyjA/bU
         WJmfKWqxae61I5LXdSe4gbylhAVImoDOQ4wJzdfC655bSb47eZJsxNgKUPQtCLBQmUgK
         4xYKFUj0EvLf0zQinr7mAKd1Ji3jlp/GIhBXTYIph8SSTHSKeEsmhqH9pgk6AIrtSek5
         BgqQ==
X-Gm-Message-State: APjAAAV+lW0kQfGsWUA2rlkVFPSEST7mCAJCxNtMxg2mx/89aoHAlx+3
        fwRZ1wyO/R+m7HlI8Q+pzJW79A==
X-Google-Smtp-Source: APXvYqxfndY6StSeMuggFZiuQpa7Krv2RQ7QOAYlgAtsZu5E1HbYKA0/gGTHCbhxTxblEioudV9blA==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr30294938pgl.103.1559586849654;
        Mon, 03 Jun 2019 11:34:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id v64sm7234518pjb.3.2019.06.03.11.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 02/30] mfd: cros_ec: Zero BUILD_ macro
Date:   Mon,  3 Jun 2019 11:33:33 -0700
Message-Id: <20190603183401.151408-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined out build macro used when compiling embedded controller
firmware.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 48292d449921..7b8fac4d0c89 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -13,6 +13,11 @@
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
+
+
+
+#define BUILD_ASSERT(_cond)
+
 /*
  * Current version of this protocol
  *
-- 
2.21.0.1020.gf2820cf01a-goog

