Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6471B62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbfGWPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:18:39 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:60730 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbfGWPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:18:38 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B9407C0C7D;
        Tue, 23 Jul 2019 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563895118; bh=+h2vDYvKU/Eqz/lBSbkDj8osIUzT6k7dY1OtU9w00zg=;
        h=From:To:Cc:Subject:Date:From;
        b=lbgYaMQqZ9QqkfRQhzZ7pfqbF7+akNRNRB1qLjwphTRETosy78vv2HxZBhWcFFfmr
         3hVLNPL+rq2VeMpc9O012q0rLnVqHaDxb4J/QaXp2KU2GtopnJzHCH0Yf3/P7VpC2x
         595COp3jj9op/VALiB4cTtoc1y0qdc+Djp+2+yzi9dF2kkFp//bU8GylNZKkOBEbz+
         sEfwXxe/2+1MUJNf7tlZZZuZO7G/lpL/nQTwKMsgk24aW3AKxWuiTgylXQVzwSaj7D
         sMnxoqPlA+Vwr0i4zMwSU7ZjHdt1Fl6XTI05PTbAdDyODWFzYDshfBOEKrbAsvbtP0
         Jbqll+MubWTcg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 14946A0057;
        Tue, 23 Jul 2019 15:18:36 +0000 (UTC)
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com, Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [RESEND V2 0/2] Add DesignWare IP support to simple reset
Date:   Tue, 23 Jul 2019 17:17:26 +0200
Message-Id: <1563895048-30038-1-git-send-email-luis.oliveira@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a reset-simple compatible string for DesignWare
IPs allowing active high and low resets inputs.

Also adds the corresponding documentation.

Gustavo Pimentel (1):
  reset: Add DesignWare IP support to simple reset

Luis Oliveira (1):
  dt-bindings: Document the DesignWare IP reset bindings

 .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
 drivers/reset/Kconfig                              |  2 +-
 drivers/reset/reset-simple.c                       |  3 +++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt

-- 
2.7.4

