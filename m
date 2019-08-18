Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB950915F3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfHRJje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 05:39:34 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39064 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:39:34 -0400
Received: by mail-wr1-f43.google.com with SMTP id t16so5633540wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVpNEoE/BxDZP3AnSrh5KM36/mTZcJaEyBMKciMdmh8=;
        b=X6wg8g0uyV/acsfF+jItxAWJviTshcEItycKNx190tPdM7j+fZihWpO1P2/2SEk1cE
         Fyd5B4VDdVOms6IzW1zZ95utc9t91MyU35PrBD3R2WpHdatS3XZSswUS5WiEbIuxD519
         oq1t5lAcWJREaH7GZrc8AVg71xCgcMAI1n4ys2MhhUE/v7lqDEhw8jWLZrgv/VzWdqCD
         Kbe8D70/BW+xzC+mxNjB4ayfm6hSJ0j9E2AVjRtL/z3PXkYx1etbWwVjjL8QWM1E3T6Q
         Ob6aJqGaNKvc/K7d5TPioI1bf30AcX/5Bq5n0ZwUC6JQFFvcQRI2SrfbnXAV5nqONXsC
         QbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVpNEoE/BxDZP3AnSrh5KM36/mTZcJaEyBMKciMdmh8=;
        b=YfZdIdmvqEDikHOtBf6f/bhQNkX9Sfp1HsVMKXwqUwt9zPhMkb6CYN7etcaduCfiWt
         yVZNAL3lW/sVkThUrtDAeVnqTPdyQeCf+7T2FNmXvuRjmqD9YVDdKArsYTMEYca8xyrY
         BJRO0B7gzoISAP1eijvadEH+BsY0VssGOHIyxqXE8gGk1dQ3xsv09PEkAPLs38mscQgz
         AiBOasd7+/7weZSC3i7exibgbLZ1Yi0F4rM7W9j2FW7mdzCy0WpfvxdZZHmv2Hz82k2J
         oAlEejsXkC7TQm0z/UNCIBQsLDQR2lf/CYU7lAX4v/jYFTUkGI6WugmQIcetNqHQDXrF
         qZkQ==
X-Gm-Message-State: APjAAAW5X5v9kW1pkHCfjs80dIGKNeZJMayeQS5hDb5OglGJFQ+bg5Wu
        r2ihB1vOLHE0Rv3GxdipyVglfckyAII=
X-Google-Smtp-Source: APXvYqxWo+syJssxQmYPM/XOZJsyOsNTWSqEQ0nnsZ8uMnzOC0IUA2zmC/py5WS12vUy2M1xHhzPHg==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr20227106wrr.11.1566121172080;
        Sun, 18 Aug 2019 02:39:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q3sm11520190wma.48.2019.08.18.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:39:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: patches(set 1) for 5.4
Date:   Sun, 18 Aug 2019 10:39:00 +0100
Message-Id: <20190818093902.29993-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some slimbus patches for 5.4 which includes:
Two fixes, one to fix the dt node refcount and other
is to address a coccicheck.

Can you please queue them up for 5.4.

Thanks,
srini

Nishka Dasgupta (1):
  slimbus: qcom-ngd-ctrl: Add of_node_put() before return

Srinivas Kandagatla (1):
  slimbus: fix slim_tid_txn()

 drivers/slimbus/qcom-ngd-ctrl.c | 5 ++++-
 drivers/slimbus/slimbus.h       | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.21.0

