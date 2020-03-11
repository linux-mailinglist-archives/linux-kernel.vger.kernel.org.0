Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545FE1817E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 13:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgCKMVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 08:21:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38043 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgCKMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:21:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id t11so2351762wrw.5;
        Wed, 11 Mar 2020 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6tI8IqiFkVMvrJ+LF1HeAfS7yMDlsfMjzHjhhujiGLg=;
        b=Ipc4nGGldeGiRNuTzxX+94IZMSFEy/DelczRwhnFCF1XEVPCvXkXJQvAKilzWQi+P0
         5SqbX0JaMU8nI6UCls0Rn/kSyD4/rQnGO9uNzBFf1QP+bQtpalqR93/fG5HZIMSzvD3l
         uTHUCJSpYWZvAohvLVDR9tXOCE40D+RwUQcY/9SSTWkQqZ3HP94wTsR8n7vPxfPnuuV8
         f5elSVSJ+xhyAqVB3K42JO6cZB8UPQqDDfWKYhNa3tR1weoJUqnsJ7MR/YWqOOxulCi5
         zZSLFA30j7+EV5Uat4AvX+qmia2mtfTiASsFkdEwIFLBz8CG3qIuzV5u7Rm8XtpYPYbg
         IePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6tI8IqiFkVMvrJ+LF1HeAfS7yMDlsfMjzHjhhujiGLg=;
        b=E9SJjuTumkNTXXFIwPzuL6MXm7YccAJu/eISur+YlvkELtud+zbLWP/X9epya/R1QW
         W9kslcVGDGRX0/Qv/9jbERM2Gw1NbulQwOh2LDKFsKjuRobbqnAxttS64L2wcwEdKqhV
         m2A2jDTJTjFi96AzOuoYTCTkm9bqXkLs+az8vlH1LhHF5cwgu/LuvApJtd5dCAPY+5xl
         A4NlUe/tJvVqtE9kfMpxr4Nt1S3MF+1OeYXHbpGrTrCl66bgJmaDpcI0lBaCN2TQjoHd
         wOJIFG7tdMoUFGyA9Hh+r0M9IQZA+U+imolo/GbscapkQy3BOkZxc///4f2mL1FcpvW9
         KJTQ==
X-Gm-Message-State: ANhLgQ1yoxVxqpITZ5bNyV4IgTdaS5cA81ImL7YYs0BXnysnze5F4zkP
        mcsdVHWmo+CoLIzIxvli59o=
X-Google-Smtp-Source: ADFU+vswhcbaVOoEw7phI5b6dKzfHaE+NTsrEgnTVYhOrh/989nyMb/sImno+ijXAmm6my+y9cFQYg==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr4282670wrx.341.1583929290177;
        Wed, 11 Mar 2020 05:21:30 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u25sm7998875wml.17.2020.03.11.05.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 05:21:29 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: usb: dwc2: add compatible property for rk3368 usb
Date:   Wed, 11 Mar 2020 13:21:21 +0100
Message-Id: <20200311122121.8912-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200311122121.8912-1-jbx6244@gmail.com>
References: <20200311122121.8912-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dt.yaml: usb@ff580000:
compatible:
['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas

The compatible property for rk3368 dwc2 usb was somehow never added to
the documention. Fix this error by adding
'rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2'
to dwc2.yaml.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v2:
  Combine compatible properties with enum.
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index d8d3c7c22..4eda7f221 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -25,6 +25,7 @@ properties:
             - rockchip,rk3228-usb
             - rockchip,rk3288-usb
             - rockchip,rk3328-usb
+            - rockchip,rk3368-usb
             - rockchip,rv1108-usb
           - const: rockchip,rk3066-usb
           - const: snps,dwc2
-- 
2.11.0

