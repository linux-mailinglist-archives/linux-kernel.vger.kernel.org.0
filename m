Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB5ACF14
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfIHNsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 09:48:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46962 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfIHNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:48:40 -0400
Received: by mail-io1-f68.google.com with SMTP id d17so977280ios.13;
        Sun, 08 Sep 2019 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oFn65Gx0LceV9UpwBpRBxIJy0Sy+f8hyn5shhbHZwGY=;
        b=fZ1C77cALrVsEVNsgCc8SoP1kDV2VcjQckKG2yXKeZxbSTAOiSGATXDS0TkMDpYooW
         C6PjdLTYnZh0qPgKG647RSGa6U7/tDP9IhwUopPKNatbWgGl2hT5QuhSxDsh+FcrBHfJ
         dKipTfEorZhVcxWmdwmFFw5AzqTPUXdawvg+8ga81oOcH58ZxnXBmWQPrkeEn91pKJS7
         YhI3Sid3dpmiVXz8p1RNqkcpqxGoVVffGuko9jAm9UrA2h2vq3/RsEmN9LXIaRlI/isv
         pFb6DLQL9HK0z90Z1P+dkquY8wAa/RcIrv4CNwS3Q8nLoGUunkM9eibAy/789iBaDANr
         JHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oFn65Gx0LceV9UpwBpRBxIJy0Sy+f8hyn5shhbHZwGY=;
        b=b1hXA5NJGyG0tO+uA109YWas76Bm0fijfQSxoWCcFqVkJeOkpftp2OUwJCuIRmRRfd
         XXhl3YR17DKTJ8dLBq2HG8h0OSgpWZucdOpXBGLLzDKgPDtIVIyPOBhdEM6pjtcYZMCQ
         l4l85PK90OaUnOj/Ff+Jp/3V6GQ3mV3RVOe/9rcuHbJbeXh2l+IohjtpleCf0w39ZPB9
         XEnSCqFJsV5Iuickzngkb5fz7JOfk05FVuNPtzcK7kC7Fd9009Htbw0QinQaJmZTYJu0
         g93FT6ckbCjt/0/hvwRl8miUyj7Cwc5Fr7V/s2QZ7M938MRUW/GHvGjqCJYuA6ElU/ak
         jOog==
X-Gm-Message-State: APjAAAU9pV7EA6wbT3lXNj5REfFG+Vh8aQlNgy4pKpg620jOz6+TtP7w
        cv3l4u1oW+CPDvf03WwZjok=
X-Google-Smtp-Source: APXvYqymoIbipF+QFyqKIvFQS+3h+eR47zlB0UY9E1dU6IsNMCa2eT2KiNA0h+tsaaSp48HbhI0HUQ==
X-Received: by 2002:a5d:9746:: with SMTP id c6mr15520437ioo.235.1567950517595;
        Sun, 08 Sep 2019 06:48:37 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id k11sm2813251ioa.20.2019.09.08.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 06:48:37 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] dt-bindings: anybus-controller: move to staging/ tree
Date:   Sun,  8 Sep 2019 09:48:05 -0400
Message-Id: <20190908134805.30957-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

The devicetree bindings for anybus-controller were mistakenly
merged into the main Linux tree. Its driver resides in
staging/, so the bindings belong in staging/ too.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 20a980e957bf ("dt-bindings: anybus-controller: document devicetree binding")
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 .../devicetree/bindings/fieldbus/arcx,anybus-controller.txt       | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {Documentation => drivers/staging/fieldbus/Documentation}/devicetree/bindings/fieldbus/arcx,anybus-controller.txt (100%)

diff --git a/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt b/drivers/staging/fieldbus/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
similarity index 100%
rename from Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
rename to drivers/staging/fieldbus/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
-- 
2.17.1

