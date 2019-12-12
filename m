Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2215C11CDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 14:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfLLNAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 08:00:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45762 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfLLNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:00:30 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifO4v-0003mN-3e; Thu, 12 Dec 2019 14:00:25 +0100
Date:   Thu, 12 Dec 2019 14:00:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
Message-ID: <20191212130025.elwei6m5lnjzjsau@linutronix.de>
References: <20191211232345.24810-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211232345.24810-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-11 17:23:45 [-0600], Rob Herring wrote:
> Change the implementation to a fixed size and use hash_32() as the
> cache index. This greatly simplifies the implementation. It avoids

The negative diffstat is nice. It solves the original issue I had and it
did not introduce anything new, just tested it. So feel free to:

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
