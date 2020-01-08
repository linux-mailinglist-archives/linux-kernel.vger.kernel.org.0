Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C70135029
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 00:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgAHX4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 18:56:14 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34670 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAHX4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:56:14 -0500
Received: by mail-pg1-f173.google.com with SMTP id r11so2319989pgf.1;
        Wed, 08 Jan 2020 15:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHrL6v0Uw66YhBXxgwYhRKU+mM7wW3ICLAPhDHJZnZI=;
        b=TsV31oHuYUrTWDADB0GeSf5Ja4Tx3vAEdFTZ8j+GUSukv2yUeP3xYSVmNbL5onBIZ+
         EIQewAW2KgMjdB9iNQ5sfc4KqbA4Tk7I+jhdfxcaW42H/HIEYBeHTWFQBDdsZXAAyXSL
         IDmGATtPwKHWhODhEtheqIvBz3XaHEAO/O32HNxSYcN8WU6YPOGpgftrx23vgmanYUAC
         br9BuxyflB8m96uqOfy7ZMIKQlKRDL6r/FToT2AqhPrHtzPiHZiNOPJiMJ/vfH0Dup/1
         WyOLSVtsIOCSoHi7m38s/pDvmwgwjep8bm1gm0rOPj26Bt6MMW9zPnar3bYm/POBvnOX
         LTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHrL6v0Uw66YhBXxgwYhRKU+mM7wW3ICLAPhDHJZnZI=;
        b=idq5qY11bdXyyRzSDJMYPqJZ01589wS7c/53axVtSagDTAgdSRPrUbY7Hx8yMH0tgX
         Sa09TKuObfvE/fY/F4tI/msFLSOtkqBW3JHuW2kNvONawu4YRAktjfEMXzP/Hj5T2DcM
         Tn54oONaCF05Q2WUdM3bFV9I0R3RJ3oH8qlrUmH+M6FdZgBmQxD1Orlargwr3/CkgRB4
         xux9i5wTrOAKbzR9tb4A4+fAm2UdH6zSbppros1jw2z/QuXSjsb/Qw5tr39XB6q3BHK6
         I3cnIiwIbTqJvbTuMugL5tTN1lR6vCQpi12hVxu4aSzu9/QomS++IDXkvuZTQtQV5Y45
         bpfA==
X-Gm-Message-State: APjAAAW5mxL5lVFdfhKI4oetWrba1Ae9J34YnkhQmJu43mAiIUjDYM0w
        6Mt1vhKRid56bzauhXXzuQo=
X-Google-Smtp-Source: APXvYqyln/X9tK1/v1SDPoi3Eb0DxxrKu9hBOdTHuIzAqjt73KadruyPy2BLeoTIyq0V1/1+8PV8ng==
X-Received: by 2002:aa7:946c:: with SMTP id t12mr8030393pfq.137.1578527773391;
        Wed, 08 Jan 2020 15:56:13 -0800 (PST)
Received: from localhost ([100.118.89.215])
        by smtp.gmail.com with ESMTPSA id y6sm4810131pgc.10.2020.01.08.15.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 15:56:12 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add AUO B116XAK01 panel bindings
Date:   Wed,  8 Jan 2020 15:53:55 -0800
Message-Id: <20200108235356.918189-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 090866260f4f..5f1d765447bc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -33,6 +33,8 @@ properties:
       - ampire,am-480272h3tmqw-t01h
         # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
       - ampire,am800480r3tmqwa1h
+        # AUO B116XAK01 eDP TFT LCD panel
+      - auo,b116xa01
 
   backlight: true
   enable-gpios: true
-- 
2.24.1

