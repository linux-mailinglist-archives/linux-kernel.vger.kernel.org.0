Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0DA44C7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfHaOnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 10:43:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:46752 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbfHaOnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 10:43:46 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 51A587DC;
        Sat, 31 Aug 2019 14:43:45 +0000 (UTC)
Date:   Sat, 31 Aug 2019 08:43:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write
 lock
Message-ID: <20190831084344.6fd7c039@lwn.net>
In-Reply-To: <20190831134116.25417-1-federico.vaga@vaga.pv.it>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2019 15:41:16 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

>  several CPU's and you want to use spinlocks you can potentially use
> -cheaper versions of the spinlocks. IFF you know that the spinlocks are
> +cheaper versions of the spinlocks. If you know that the spinlocks are
>  never used in interrupt handlers, you can use the non-irq versions::

I suspect that was not actually a typo; "iff" is a way for the
mathematically inclined to say "if and only if".

jon
