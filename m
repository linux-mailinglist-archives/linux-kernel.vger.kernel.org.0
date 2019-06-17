Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30FE491A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfFQUqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 16:46:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfFQUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:46:52 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcyWh-0004wk-5x; Mon, 17 Jun 2019 22:46:51 +0200
Date:   Mon, 17 Jun 2019 22:46:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] rslib: decode_rs: Fix length parameter check
In-Reply-To: <20190330182947.8823-4-ferdinand.blomqvist@gmail.com>
Message-ID: <alpine.DEB.2.21.1906172246380.1963@nanos.tec.linutronix.de>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com> <20190330182947.8823-4-ferdinand.blomqvist@gmail.com>
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

On Sat, 30 Mar 2019, Ferdinand Blomqvist wrote:

> The length of the data load must be at least one. Or in other words,
> there must be room for at least 1 data and nroots parity symbols after
> shortening the RS code.

Indeed!

