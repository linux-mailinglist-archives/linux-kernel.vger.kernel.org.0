Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847901042DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfKTSGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:06:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfKTSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:06:43 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXUNB-0005BX-LZ; Wed, 20 Nov 2019 19:06:37 +0100
Date:   Wed, 20 Nov 2019 19:06:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     mingo@kernel.org, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/4] x86,mm/pat: Cleanup some of the local memtype_rb_*
 calls
In-Reply-To: <20191021231924.25373-3-dave@stgolabs.net>
Message-ID: <alpine.DEB.2.21.1911201906271.29534@nanos.tec.linutronix.de>
References: <20191021231924.25373-1-dave@stgolabs.net> <20191021231924.25373-3-dave@stgolabs.net>
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

On Mon, 21 Oct 2019, Davidlohr Bueso wrote:

> Cleanup by both getting rid of passing the rb_root down the helper
> calls; there is only one. Secondly rename some of the calls from
> memtype_rb_*.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
