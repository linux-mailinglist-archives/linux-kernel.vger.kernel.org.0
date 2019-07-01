Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC912B7DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfE0Ovt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 10:51:49 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39047 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfE0Ovn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:51:43 -0400
X-Originating-IP: 90.88.147.134
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 87BE3FF802;
        Mon, 27 May 2019 14:51:35 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 00/14] crypto: inside-secure - self-test fixes
Date:   Mon, 27 May 2019 16:50:52 +0200
Message-Id: <20190527145106.8693-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The crypto runtime self-tests were improved and thanks to this we
spotted new issues within the Inside Secure SafeXcel cryptographic
engine driver:
- Intermediate IV were not retrieved from the hardware nor copied to the
  quest IV buffer for cbc(aes/des).
- HMAC updates wasn't supported.
- We spotted issues with the use of the SG lists.
- There was an issue with the use of result buffers.

The series fixes all those issues, and includes other small changes
found while doing this work.

Thanks!
Antoine

Antoine Tenart (14):
  crypto: inside-secure - remove empty line
  crypto: inside-secure - move comment
  crypto: inside-secure - fix coding style for a condition
  crypto: inside-secure - remove useless check
  crypto: inside-secure - improve the result error format when displayed
  crypto: inside-secure - change returned error when a descriptor
    reports an error
  crypto: inside-secure - enable context reuse
  crypto: inside-secure - unify cache reset
  crypto: inside-secure - fix zeroing of the request in ahash_exit_inv
  crypto: inside-secure - fix queued len computation
  crypto: inside-secure - implement IV retrieval
  crypto: inside-secure - add support for HMAC updates
  crypto: inside-secure - fix use of the SG list
  crypto: inside-secure - do not rely on the hardware last bit for
    result descriptors

 drivers/crypto/inside-secure/safexcel.c       |  13 +-
 drivers/crypto/inside-secure/safexcel.h       |  17 ++-
 .../crypto/inside-secure/safexcel_cipher.c    | 116 +++++++++++-------
 drivers/crypto/inside-secure/safexcel_hash.c  |  92 ++++++++------
 drivers/crypto/inside-secure/safexcel_ring.c  |   3 +
 5 files changed, 157 insertions(+), 84 deletions(-)

-- 
2.21.0

