Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3734A11EDC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLMWbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 17:31:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34287 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMWbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:31:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so184750pgf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LHoIae2XNCa3AukmEzpCJ7hn/t0mtHhIaNOkcRhKOG0=;
        b=hU1x7VCUvKIt7Cg/eg0wfaKvqD1IFsyIilDpGwxLmedBHlc57jIwuVRLykhhgnlF15
         pXEkRXNiVOnpris7PSvO4SXDdYoV/4r8PjVjg6Psp0jjSJ5GMbZxPdiRxp/XIC3yEoTy
         YAD7RaGTrmZ8z5dcM6+C2shxjzlAlTg6AR7UXN0NQOCsPrlrlqWFM76RrkaBPHzC4H3Z
         TvBQac9a39iOdD2lH8sPVrC6VaYGk+hcXZmeVhO0QXzLnGhwzPn3udyxehROqh7l9dm3
         XPGbp1iz/h/771ZHP2xIedtVK7140ipS2BNzCSzNH3b05Bufl4E1cAfIkdG2mMfsBMcL
         cqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LHoIae2XNCa3AukmEzpCJ7hn/t0mtHhIaNOkcRhKOG0=;
        b=HLstZo5hVDXA4JskcVACt3WlxHXE9UAZczcDC7EHNkbHZ3WDjCHH5SPiarH9ibHrYh
         9zflkVxaKSRtnZvDxl30n3yKGRifC4gC2RrpCs9gEE1jLTpWdAmwjTRFcymsClqBT9pt
         CxFnqb+SJppriOQpWIJBn5JreXAzjjx/WIbaJJys0TuJvcaWctIYdAq72C82O9wNBEpc
         ClH8nRRzGKhGP78LWqPAkKJFVLLRD8AaPWmdIpQ67N16hAKvIvxw1KzjFooq37YnZ/c6
         hRsfMrZwVRJxI0kuqcOXvJFuHOcv4FSu6CPcNTEiLfXr4FAeSYUuVicn0q3wSwI9bwbY
         eyBQ==
X-Gm-Message-State: APjAAAVyZgWjYhE3BxhcM6QK14ppktPLwAI1898CzjP4PaumF8pIHRmZ
        3/zyHZDhilPBJS16OsN2+zlpCErNc48=
X-Google-Smtp-Source: APXvYqxjGsOY8wNPiQWZLO7QyfMd7NVagT5u/0KddkS/aD8uWQT99Tud+8ZE/aeIyFzf4UG2IRosGA==
X-Received: by 2002:a63:5442:: with SMTP id e2mr2058808pgm.18.1576276269733;
        Fri, 13 Dec 2019 14:31:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d26sm11556782pgv.66.2019.12.13.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:31:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] coresight: Fix for v5.5-rc2 
Date:   Fri, 13 Dec 2019 15:31:06 -0700
Message-Id: <20191213223107.1484-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please consider this fix for the current cycle.

Thanks,
Mathieu

Arnd Bergmann (1):
  coresight: etm4x: Fix unused function warning

 drivers/hwtracing/coresight/coresight-etm4x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.17.1

