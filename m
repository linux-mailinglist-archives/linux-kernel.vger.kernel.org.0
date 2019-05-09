Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8F18624
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEIHZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 03:25:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfEIHZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:25:34 -0400
Received: from [85.235.16.11] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hOdQc-0000ZV-Sc; Thu, 09 May 2019 09:25:19 +0200
Date:   Thu, 9 May 2019 09:25:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux@endlessm.com,
        peterz@infradead.org
Subject: Re: [PATCH v2 1/3] x86/tsc: use CPUID.0x16 to calculate missing
 crystal frequency
In-Reply-To: <20190509055417.13152-1-drake@endlessm.com>
Message-ID: <alpine.DEB.2.21.1905090924390.1855@nanos.tec.linutronix.de>
References: <20190509055417.13152-1-drake@endlessm.com>
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

On Thu, 9 May 2019, Daniel Drake wrote:

> native_calibrate_tsc() had a data mapping Intel CPU families
> and crystal clock speed, but hardcoded tables are not ideal, and this
> approach was already problematic at least in the Skylake X case, as
> seen in commit b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake
> Xeon").

...

For the whole pile:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

