Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D256E9BC7E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHXIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 04:05:06 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42131 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHXIFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 04:05:05 -0400
Received: by mail-wr1-f49.google.com with SMTP id b16so10574408wrq.9;
        Sat, 24 Aug 2019 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VCD60Jb/+pjJ/5tE2H1gE1kn+YA9VqYcdsUMqOXSco=;
        b=IRLobxtjE94mqtQg5b9qleFlE2Cr+arwKQzrAYp5C/aNxsGM14b/lZ2dMXxVbNthdZ
         RXT0JvYJ6VLojJQ8flXvXLfElikgys4OKbTZ7uCfTrS9kY7qoKCZvKtaDBiwsKuGCXgZ
         UCmQLG8DdYljPqGL/NcbUrObjhNqWcze/M5j/QvB3G9HjGnXsNTFWaVGYPEvW6ruhDzO
         cpXP5zbyqTl4tiNdFoVgtU7ThJt4HFQib+9ANuJCrVSYI5cPC0RTtyPo1TWsNeFbR0LS
         +08sNU1i4ZqzR+v61c9nMlqbsFV6H2487Xkw6JkTNt70sP0QVm496cIipNg531uk7kod
         T6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VCD60Jb/+pjJ/5tE2H1gE1kn+YA9VqYcdsUMqOXSco=;
        b=lx1IDju1v/6r3qc+MbiVM5fyhOdkCmltVN9SyaYkzEJ3yhIPC2auU+Zo1MWZusbg5Y
         8YPAnvmUXhgCtYP5xEbGqsebY1nULWWo4fGiiyr2MRj3DeLqRe6QoignxYd22Qp674VB
         zZWIC2jdPKdxSKW05b7+87NUTZPXZnaKINb27/USc3z/Pbt+0K14i9+cSxVWY+Eacgqc
         sJhcHaao58f11fvjOXShCT+a/E2b8N1lbQROrCpllXAhUXgXBxeYmoLIprZ65H1gmw4j
         2u+PdzzpKWQ8PWc6OdGEj6kVMzaPQl3ycmij9naat7pappr5DULa2e1nck/3/5zvmqN4
         IHPg==
X-Gm-Message-State: APjAAAWwmlONn+xm9U9FaMCGdVVZLcuXvVPbawEiNgO1omaLj59us+V4
        9uPujkKFVtdPCXrXXM3Bsi8=
X-Google-Smtp-Source: APXvYqxmIa4QM7AcW/83pmrZJxqiFUk74JNfWaLeB0hSRpCmPT8473gpHyeXLWjKOEQDzkQWTtWY+Q==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr10230811wrn.87.1566633903310;
        Sat, 24 Aug 2019 01:05:03 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id w8sm16615656wmc.1.2019.08.24.01.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 01:05:02 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH v2,1/3] dt-bindings: Add vendor prefix for Ugoos
Date:   Sat, 24 Aug 2019 12:04:08 +0400
Message-Id: <1566633850-9421-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com>
References: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugoos Industrial Co., Ltd. are a manufacturer of ARM based TV Boxes,
Dongles, Digital Signage and Advertisement Solutions [0].

[0] (https://ugoos.com)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbb..d962be9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -965,6 +965,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ugoos,.*":
+    description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
     description: United Western Technologies Corp (UniWest)
   "^upisemi,.*":
-- 
2.7.4

