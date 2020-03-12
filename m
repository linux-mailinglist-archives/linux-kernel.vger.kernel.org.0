Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC8182E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCLLC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 07:02:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44766 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:02:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so5857083ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 04:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDdc7kJCwX6NG51y4/WhGpKrhuKlpllW6J0+34aBuUM=;
        b=rDhXxWfSMor8C5yLYvVD1zmA+FGPl8dRH8+C9iAG7Myngt8sC7o7UYQYzzw69zF2m/
         UDyP+cCVaA8hWu7MpP09bp7dUwMzs0BWFcgwdnKN5FioUnXFt+enslj6BWuebf2oBpgd
         ksnlbFbYuKf9K7cvqIBzvz8w/A9QFjWxFEVPcbai83a0DLZAAw2pFweqB8uDfHaXjN+w
         PbH+aOoTJ2Tfes1s4QVUWgF5keAchxPkuKyAamfG63bQB4oPJPgRn1OiEAfe/iwUubdr
         KXUCBTWT5rdRTpevMeNJ0PiZbK2tZ9zvREtD3Eeni6vpk3zQdmqS594iUH4NJzWNOoYE
         yDNA==
X-Gm-Message-State: ANhLgQ32c9CKjGvTj2UDz2wNJHZb1ypmnzd+xh8b5UYHvH1H9/pnthys
        WnXUTFL5vUYrg1wkohOW9cY=
X-Google-Smtp-Source: ADFU+vsmOZIFeUfO5yjeQGM0J/m8azRAO/gGJ3hAhSFyU/Ra3PAxnqt6mjXyuMaP4RnH09Ungsc0gA==
X-Received: by 2002:a2e:b55c:: with SMTP id a28mr5012329ljn.108.1584010946521;
        Thu, 12 Mar 2020 04:02:26 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id b3sm7342740ljj.46.2020.03.12.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 04:02:25 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1jCLbS-0005kD-C1; Thu, 12 Mar 2020 12:02:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Axel Haslam <ahaslam@baylibre.com>,
        Bryan ODonoghue <pure.logic@nexus-software.ie>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: greybus: loopback_test: fix build breakage
Date:   Thu, 12 Mar 2020 12:01:48 +0100
Message-Id: <20200312110151.22028-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loopback_test tool hasn't received much love lately. In fact, it has
failed to build for the past two years after a scripted EPOLL*
conversion.

Newer GCC also started warning for potential string truncation of
generated path names; the last two patches addresses that.

Johan


Johan Hovold (3):
  staging: greybus: loopback_test: fix poll-mask build breakage
  staging: greybus: loopback_test: fix potential path truncation
  staging: greybus: loopback_test: fix potential path truncations

 drivers/staging/greybus/tools/loopback_test.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.24.1

