Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE10D5C87D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 06:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfGBEn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 00:43:27 -0400
Received: from ozlabs.org ([203.11.71.1]:37871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfGBEn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 00:43:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45dBSr6w8Yz9s00;
        Tue,  2 Jul 2019 14:43:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1562042605; bh=iMxxUb/MrP5191LRn/nhBkFeow9aH4C71D4VIMnNmRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S3cXogx40ElVPWdtEYhfnIcMrb8TYMv+B1xiJHUGxAt2qAUgNfWW2IdQdPh9/Z8+A
         6fAWJGzr68M/oUWTxGC8wVYJ5iHEJx9Dtb5yBmfD/JczygqUAy2fD/1fpq15jR67k2
         M6q6aj4vxkQw5On2qFdn1MgBva2NLYCGr9J8oNAkKZNO5vqvzWujqb5hjtIMBmV9hB
         XW2b1yFEfaYiJrKpJDkSzPREBRvbm4imtcPS2nux5nGxSfV+skEBlxG50ZT22mUmvs
         7lENejasmL/gsS9/49RCMPote2mSjmE4NN9eowOcYQ+T7dlGswD9hMTzcGYbVaxC5i
         bSt/mlcGaIqxA==
Message-ID: <7cb3a9fce3c51837e7cc29fb15e10ed7c6d2631b.camel@ozlabs.org>
Subject: Re: [PATCH] MAINTAINERS: Add FSI subsystem
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Tue, 02 Jul 2019 14:43:22 +1000
In-Reply-To: <20190702043706.15069-1-joel@jms.id.au>
References: <20190702043706.15069-1-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

> The subsystem was merged some time ago but we did not have a
> maintainers
> entry.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy


