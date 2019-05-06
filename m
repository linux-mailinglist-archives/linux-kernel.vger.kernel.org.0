Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99415439
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfEFTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 15:12:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38869 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEFTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:12:23 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hNj2D-0001Gs-AF; Mon, 06 May 2019 21:12:21 +0200
Date:   Mon, 6 May 2019 21:12:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: Provide a pointer to the valid CPU mask
In-Reply-To: <20190502151055.GA50195@gmail.com>
Message-ID: <alpine.DEB.2.21.1905062112000.3334@nanos.tec.linutronix.de>
References: <20190423142636.14347-1-bigeasy@linutronix.de> <20190502151055.GA50195@gmail.com>
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

On Thu, 2 May 2019, Ingo Molnar wrote:
> 
> Looks good to me in principle - Peter, Thomas, any fundamental 
> objections?

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
