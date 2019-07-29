Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E8E789B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbfG2Kkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 06:40:33 -0400
Received: from foss.arm.com ([217.140.110.172]:41726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbfG2Kkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:40:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED56028;
        Mon, 29 Jul 2019 03:40:32 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0603F694;
        Mon, 29 Jul 2019 03:40:31 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: ccree: aead fixes
Date:   Mon, 29 Jul 2019 13:40:17 +0300
Message-Id: <20190729104020.3681-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix AEAD handling of authentication failures.

Gilad Ben-Yossef (2):
  crypto: ccree: use the full crypt length value
  crypto: ccree: use std api sg_zero_buffer

 drivers/crypto/ccree/cc_aead.c       |  3 ++-
 drivers/crypto/ccree/cc_buffer_mgr.c | 21 ---------------------
 drivers/crypto/ccree/cc_buffer_mgr.h |  2 --
 3 files changed, 2 insertions(+), 24 deletions(-)

-- 
2.21.0

