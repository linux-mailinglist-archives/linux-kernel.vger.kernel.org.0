Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17317569DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfFZM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 08:57:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfFZM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:57:53 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg7Um-0000Me-7f; Wed, 26 Jun 2019 14:57:52 +0200
Date:   Wed, 26 Jun 2019 14:57:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] rslib: RS decoder is severely broken
In-Reply-To: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
Message-ID: <alpine.DEB.2.21.1906261456480.32342@nanos.tec.linutronix.de>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ferdinand,

On Thu, 20 Jun 2019, Ferdinand Blomqvist wrote:

> This is the second revision of this series that fixes the bugs/flaws in
> the RS decoder. This addresses all of Thomas' comments/suggestions.

I've picked up the lot and it's en route to 5.3.

Thanks a lot for your excellent work and your patience!

       tglx
