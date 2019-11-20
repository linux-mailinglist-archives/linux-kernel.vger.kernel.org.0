Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86F51042EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfKTSH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:07:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTSH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:07:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXUNw-0005Ct-Mi; Wed, 20 Nov 2019 19:07:24 +0100
Date:   Wed, 20 Nov 2019 19:07:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     mingo@kernel.org, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/4] x86,mm/pat: Drop rbt suffix from external memtype
 calls
In-Reply-To: <20191021231924.25373-4-dave@stgolabs.net>
Message-ID: <alpine.DEB.2.21.1911201907150.29534@nanos.tec.linutronix.de>
References: <20191021231924.25373-1-dave@stgolabs.net> <20191021231924.25373-4-dave@stgolabs.net>
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

> Drop the rbt_memtype_* calls (those used by pat.c) as we
> no longer use an rbtree directly.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
