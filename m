Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362C348D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfFQTIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:08:53 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:45015 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfFQTIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:08:53 -0400
Received: by mail-pf1-f173.google.com with SMTP id t16so6171272pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rnvedP+27FpjNnYtAjFGpiRqsnOOK2nmaRaeNdbtb1o=;
        b=vBsNL4xA75AArFv43xH/ZFWaTuVytMM6eqHpZ1tXM+VDVoEy5yMQripNDjto8EE4gy
         sLy8/DOabehrCXI85ff0a+D2MFJfY75cflKwRSSagC0yV0ctc+HzbxAa9ddgOJ1KFbz5
         xziO5rtypSlZ2XccylDBALkxodIipsANhVV2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rnvedP+27FpjNnYtAjFGpiRqsnOOK2nmaRaeNdbtb1o=;
        b=MMxXndauXWyZukwYASGXqNmCG/7PQc93T4a2O14IQAMSuqI2NI3jbL75loumQE9Gbn
         FbbTjTGmCq5x0nJlUs4hnRIvz3QtTul7vKah0sPyRLSVHvTzkhH9kbkQjVD4HhCjZO4/
         DVdYd3fzi69UsmWkTgl9o56pT+2A+jZHVZ+secntaZdrM5M0oCeM85hBHZyTgA3ZZ9Tw
         0ic1cP4wp43OAr6JpHq+f4fYw9aMRB0l1hUSpEqAjkjZY1iSd1e/jrnLemIc43dp4o6y
         4oTa+UqCe1yH5zEbjZIBfl87K0jtqrWCh9dGRqbvwDPYSeNLdWRMKxQx/VfA0l474eC7
         3ODQ==
X-Gm-Message-State: APjAAAVbKiYa+SaRMRZcmEXPce3iDttsePYvn9CrIANW1Up5agpVIeRS
        YHT+bwEtTFNwv5RAeOehg4DWug==
X-Google-Smtp-Source: APXvYqwwGimRXjyilSR/k74EsjGUAgN/gKKO8YMsV/GXu+UiCTnuTOfgehMR7Sr7m7f0NsT6WX/TrA==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr428903pjr.64.1560798532555;
        Mon, 17 Jun 2019 12:08:52 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id p43sm111063pjp.4.2019.06.17.12.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:08:51 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v3 0/3] UDP GSO audit tests
Date:   Mon, 17 Jun 2019 12:08:34 -0700
Message-Id: <20190617190837.13186-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to UDP GSO selftests ot optionally stress test CMSG
subsytem, and report the reliability and performance of both
TX Timestamping and ZEROCOPY messages.

Fred Klassen (3):
  net/udpgso_bench_tx: options to exercise TX CMSG
  net/udpgso_bench.sh add UDP GSO audit tests
  net/udpgso_bench.sh test fails on error

 tools/testing/selftests/net/udpgso_bench.sh   |  52 ++++-
 tools/testing/selftests/net/udpgso_bench_tx.c | 291 ++++++++++++++++++++++++--
 2 files changed, 327 insertions(+), 16 deletions(-)

-- 
2.11.0

