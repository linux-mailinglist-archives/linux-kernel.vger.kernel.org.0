Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1132DF55
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 16:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfE2OKj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 May 2019 10:10:39 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:40630 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfE2OKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:10:39 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 10:10:38 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 1382E1809AD97;
        Wed, 29 May 2019 16:04:49 +0200 (CEST)
From:   David Gstir <david@sigma-star.at>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Can an ahash driver be used through shash API?
Message-Id: <729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at>
Date:   Wed, 29 May 2019 16:04:47 +0200
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've done some testing with hardware acceleration of hash functions
and noticed that, when using the synchronous message digest API (shash),
some drivers are not usable. In my case the CAAM driver for SHA256.
Using the asynchronous interface (ahash), everything works as expected.
Looking at the driver source, the CAAM driver only implements the ahash
interface. 

I'm wondering if there a way to use an ahash driver through the shash interface?

I've seen that it does actually work the other way around, since 
crypto_init_shash_ops_async() in crypto/shash.c takes care of translating calls
from ahash to shash and that's how the *-generic drivers are usable through the
ahash API.

Thanks!
David
