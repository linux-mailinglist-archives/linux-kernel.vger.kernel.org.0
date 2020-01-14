Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01913A254
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 08:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgANH5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 02:57:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39061 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgANH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:57:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so6189445pfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rz+1A6+K1PzsFBhkTCJB1epd9yg/lbQ9jkVOeEMF3bA=;
        b=WKA2xbKplXk9+U7EVxjiEyxOePWsDur8y5OxbhG24UzYTyjn21JVwDI7za+TbhHpCA
         9sTjB/ChIBgk58fBPHQlYPNcPR+57/DL+El+VZh7Pj9g1yfYeyOrjaSc33kprfivRP/5
         bHsILXH0OY36TRX1ksCc1uJCWmztzEcfsIReKXgXSsW416Fd8tMGT47A3lWRO3okLQCi
         32qQ5U9B65L6v5m99XvGZkayHtl1IjMWHHCCAj2TVbmY2hwDlDj4SXrO4eVDWixDYXCd
         Y5K9rtt7+4Es5tFomqL0ZOwfU8HvgvunKNKKs7z5uUrSA5XgyuCr/LdpjcQBjbDQzhZY
         3T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rz+1A6+K1PzsFBhkTCJB1epd9yg/lbQ9jkVOeEMF3bA=;
        b=YgQNhdx3wOJLFg3zMc/sLgM2q7y5V45rB0CYXQ9wq4QrC7SyRQfbVytqNt/ungxs+Z
         ssR8OdK6h4DIUdX8XL86fg2NWMTicBi9ILEMgVobf6D+M4l15MXvmv5kcvKKjtgePASk
         T3rolyCj4lcsVi1TMd1cgOsScIC6dSbYExJ3A32WqLuxXA724sFGjea1vUw5RCKOkqFC
         bKCZPJ7mJY1+oixfLtec1D69TRJnrDfC2XCzhxFPWOKzZzHCBIRQkDvJuZmhOw0+jte8
         7lv0MWwp2b1J4hOtSk/W76+ruDMFXCd8J0Jc1Z8j+XvD7DkQj8ywQ1eBdLtEuX9e22If
         vXMA==
X-Gm-Message-State: APjAAAXcDOE39T60O9IB2yXAgLZV8jzSm6lCegkCw/Xvc0Y5qAvlzITn
        Jp4foi+MpSmM3bCZGoAYvh6+xA==
X-Google-Smtp-Source: APXvYqz4KBxXvA7TWAR4lzvTyYHOkRgwFmEqymwdpHQNTuw/iJJ6d9qIPbQ4s+AGZcJ4Uv2xErwBaQ==
X-Received: by 2002:a62:87c5:: with SMTP id i188mr24018264pfe.52.1578988671689;
        Mon, 13 Jan 2020 23:57:51 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q63sm17349352pfb.149.2020.01.13.23.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:57:51 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/5] QRTR flow control improvements
Date:   Mon, 13 Jan 2020 23:56:58 -0800
Message-Id: <20200114075703.2145718-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent overconsumption of resources on the remote side QRTR
implements a flow control mechanism.

Move the handling of the incoming confirm_rx to the receiving process to
ensure incoming flow is controlled. Then implement outgoing flow
control, using the recommended algorithm of counting outstanding
non-confirmed messages and blocking when hitting a limit. The last three
patches refactors the node assignment and port lookup, in order to
remove the worker in the receive path.

Bjorn Andersson (5):
  net: qrtr: Move resume-tx transmission to recvmsg
  net: qrtr: Implement outgoing flow control
  net: qrtr: Migrate node lookup tree to spinlock
  net: qrtr: Make qrtr_port_lookup() use RCU
  net: qrtr: Remove receive worker

 net/qrtr/qrtr.c | 319 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 247 insertions(+), 72 deletions(-)

-- 
2.24.0

