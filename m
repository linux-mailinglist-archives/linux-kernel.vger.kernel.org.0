Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500A0186A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 12:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgCPLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 07:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730907AbgCPLyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:54:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDE0205ED;
        Mon, 16 Mar 2020 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584359688;
        bh=24D2nmoA1PD2UDbWlzqD/g16A8HBhZbRXBxFqrR2eX4=;
        h=From:To:Cc:Subject:Date:From;
        b=woKdUbjOhCrnilC3sCEt3y39EL5CZdCI72qTnRuL8MQi6XfOyOVAr9pfK77lb5S0g
         bf0iUMADXGl0lmeO6obpAiBf7pymdUTcYXQfMlCDj2kS28OlnDyY2cql+Dol1Ed3oH
         wE0B6RAxBU67RGkqB8soNjQ3f7LaTISLTdX+JYDA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDoKU-00D45x-VP; Mon, 16 Mar 2020 11:54:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     John Garry <john.garry@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 0/2] irqchip/gic-v3-its: Balance LPI affinity across CPUs
Date:   Mon, 16 Mar 2020 11:54:31 +0000
Message-Id: <20200316115433.9017-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, john.garry@huawei.com, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mapping a LPI, the ITS driver picks the first possible
affinity, which is in most cases CPU0, assuming that if
that's not suitable, someone will come and set the affinity
to something more interesting.

It apparently isn't the case, and people complain of poor
performance when many interrupts are glued to the same CPU.
So let's place the interrupts by finding the "least loaded"
CPU (that is, the one that has the fewer LPIs mapped to it).
So called 'managed' interrupts are an interesting case where
the affinity is actually dictated by the kernel itself, and
we should honor this.

* From v2:
  - Split accounting from CPU selection
  - Track managed and unmanaged interrupts separately

Marc Zyngier (2):
  irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
  irqchip/gic-v3-its: Balance initial LPI affinity across CPUs

 drivers/irqchip/irq-gic-v3-its.c | 153 +++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 26 deletions(-)

-- 
2.20.1

