Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F8ED7A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfJOPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 11:54:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42729 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfJOPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:54:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so17371548otd.9;
        Tue, 15 Oct 2019 08:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qhKK3H7JHx9Pg9rqpVbjQ8Fqzdg622NRYKtEz3pOpY=;
        b=UM+NOX/2ooHc5rvjlcwZPc5pvWMlxN2Vl0/JHZ8Xua+GefiYLwD/2a10/81nuKFQ/L
         8rGMhMnaWmHeS2vBJujMfbwJ0AtLBMim7MI5Vz63Jn+C4HM2NeYVPgnRjrWmaUMy0zYW
         nbIiH72KmM86XKZgh/yKKsbo1nJwk6C/pzgG43u9UimqstpgniCLyer1YYRYiKjM9icI
         HtwtgcwHfK2EWeneuKB/JfdP7WDKeVB+GiMZugtBPy6HKrvqK6UaMQUv4Tirn/w8oPZu
         VZ/BUCMqtL+QbnKCAboua2bttpO/WKPMxp3RITHvC37qegqt8QaK2qKzFhRvVJqgbhDi
         NmRQ==
X-Gm-Message-State: APjAAAUoWR20xcNVsYCTYewcmEzA4lIH9RWWPkknCZZaA4taMjplDPQr
        UOpna3AO2Ml+94P7Llf3K6/5C5o=
X-Google-Smtp-Source: APXvYqzl97gscGI19gtvshAXHiRZe7RDUF1en6rFopsA1RXXpXv4IuPAtA5BF/7n06btN4F5+XXLDg==
X-Received: by 2002:a9d:7d16:: with SMTP id v22mr1008454otn.331.1571154874589;
        Tue, 15 Oct 2019 08:54:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y137sm6633719oie.53.2019.10.15.08.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:54:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH 1/2] dt: writing-schema: Add a note about tools PATH setup
Date:   Tue, 15 Oct 2019 10:54:32 -0500
Message-Id: <20191015155433.25359-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users without an existing python install may not have their PATH setup
for pip installed python programs already. Add a note about having the
DT validation programs in the PATH.

Reported-by: Robert Jones <rjones@gateworks.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index f4a638072262..3fce61cfd649 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -117,6 +117,9 @@ project can be installed with pip::
 
     pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
 
+Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
+installed. Ensure they are in your PATH (~/.local/bin by default).
+
 dtc must also be built with YAML output support enabled. This requires that
 libyaml and its headers be installed on the host system.
 
-- 
2.20.1

