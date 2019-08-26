Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338049D61C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbfHZTBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 15:01:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36843 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHZTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:00:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so18991100qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwuY5sKjDPAwM+Eem6lSsn7R4L71P95IVVWzmn8Wm+8=;
        b=FgCCF3AP0YmnF2LejCVe101FrUUf6kmHoXj2PR30frAoZbyQsvuBWlRQpPGROktgcK
         Q9iijuL25Ge0l4YDSLYImTqkM8+2Kz9w/LlLYow27imU5TKvZ1FE5S0dEQ54Ok4vxlnt
         rzT65ReQAVdCqfJk6HEhHP5wmZHVvFqteyH3NVAoADlXG/Fxp1ajR/692fNqYWQD2x+d
         jE/69FydSNlhO8d7GREtGEU/s3Pl1R8fW/9GiQSdh7LT7bz8eZux+yBKZ0tLTlFChi0I
         ovgnk334G/N6WVMoibuCVgTXrQsyrpz/Q2qjVADuGdKG4w346BbPwvs+ajjRcvfWmM7W
         5xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwuY5sKjDPAwM+Eem6lSsn7R4L71P95IVVWzmn8Wm+8=;
        b=owyqGHMaIjxam5AGnX7GjxN/wJpkxW2IrSjho7LDtzvNYfY5gFJX6871vRWWt6kLbn
         eBOsjJdsGrjgWl/f0U8RuXu2rkPWv5T4h9FjR78gRLbqR0O9yjZ8ZQIy+ZHZLir1hgdT
         sisiq3JjKlW7OTp8CaR9O/Qz5EKmvJvEGP7KDcmbJN2agUFwvAvJh3KqJh41hTv9Xuut
         XOB9JgHXoyoDFk2eek3Phvwk3m76v9u7tLdUC27N+FDCuNP0KACkFa7l8HCIIhoFPsgj
         J6xV9k7y06UAGZeOyUGO4bQ8QFI8DNnPB6GQCgDnAnYdSJZBnj06usaz24kjkJdBeE/f
         RACg==
X-Gm-Message-State: APjAAAWeiTpJC7yvJdOhFslOvC45pgzWkmarVYN+lPl010S3qdhSsujT
        iBrSGds8PDF2WX6APY8RovspBull8lA=
X-Google-Smtp-Source: APXvYqx70qupmhIz/B7QuYzWH1TgZQebS1UrrW8+S6jNJLoBgPyN9gqcqANa3UWN/UDyR6cFmCr9Hw==
X-Received: by 2002:ac8:4691:: with SMTP id g17mr19142886qto.104.1566846058466;
        Mon, 26 Aug 2019 12:00:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o45sm8614377qta.65.2019.08.26.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:00:57 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com
Subject: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
Date:   Mon, 26 Aug 2019 15:00:50 -0400
Message-Id: <20190826190056.27854-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
However, it is still not possible todo on systems with device trees.

Here is EFI fixes from Marc:
https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com

For Device Tree variant: lets allow reserve a memory region in interrupt
controller node, and use this property to allocate interrupt tables.

This way we are safe during kexec, as these page tables are going to stay
the same after kexec.

Pavel Tatashin (6):
  rqchip/gic-v3-its: reset prop table outside of allocation
  rqchip/gic-v3-its: use temporary va / pa variables
  rqchip/gic-v3-its: add reset pending table function
  rqchip/gic-v3-its: move reset pending table outside of allocator
  rqchip/gic-v3-its: move reset pending table outside of allocator
  dt-bindings: interrupt-controller: add optional memory-region

 .../interrupt-controller/arm,gic-v3.yaml      |   7 +
 drivers/irqchip/irq-gic-v3-its.c              | 121 +++++++++++++-----
 2 files changed, 96 insertions(+), 32 deletions(-)

-- 
2.23.0

